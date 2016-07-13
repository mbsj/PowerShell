<#
.Synopsis
   Invokes a SQL query agains a specified database
.DESCRIPTION
   Invokes one or more queries agains a specified SQL database. Result set is loaded into data table rows and returned directly. 
.EXAMPLE
   .\Invoke-SQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB

   Invokes the query against the specified server and database. Uses a trusted connection and the default timeout of 10 seconds. 
.EXAMPLE
   .\Invoke-SQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB -Timeout 60

   Invokes the query against the specified server and database. Uses a trusted connection and specifies a long er timeout og 60 seconds.
.EXAMPLE
   .\Invoke-SQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB -Username DBUser -Password SuperSecretPassword

   Invokes the query against the specified server and database but connects using standard security. 
   This requires an explicit username and password which is specified in -Username and -Password
.EXAMPLE
   $queries | .\Invoke-SQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB

   $queries is an array of several query strings. One connection is made after which each query is invoked agains the server as in the first example. 
.INPUTS
   System.String
   System.Int
.OUTPUTS
   System.Data.DataRow
.NOTES
    Be cautious when executing multiple queries agains different tables. As each table will return different properies, these may be hidden when using i.e. Format-Table to format output. 
    The formating cmdlet will use the first objects to define the properties to show, and so will not show properties for rows returned later in the result set. 
#>

[CmdletBinding(DefaultParameterSetName='Trusted Connection',
                SupportsShouldProcess=$true, 
                PositionalBinding=$false,
                ConfirmImpact='Medium')]
[OutputType([System.Data.DataRow])]
Param
(
    # Query to be executed
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, Position=0, ParameterSetName='Trusted Connection')]
    [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true, Position=0, ParameterSetName='Standard Security')]
    [ValidateNotNullOrEmpty()]
    [String]$Query,

    # Server to connect to
    [Parameter(Mandatory=$true, Position=1, ParameterSetName='Trusted Connection')]
    [Parameter(Mandatory=$true, Position=1, ParameterSetName='Standard Security')]
    [String]$Server,

    # Database to query
    [Parameter(Mandatory=$true, Position=2, ParameterSetName='Trusted Connection')]
    [Parameter(Mandatory=$true, Position=2, ParameterSetName='Standard Security')]
    [String]$Database,

    # Timeout for the query
    [Parameter(ParameterSetName='Trusted Connection')]
    [Parameter(ParameterSetName='Standard Security')]
    [ValidateScript({$_ -gt 0})]
    [Int]$Timeout = 10,

    # Username used to authenticate with the server
    [Parameter(Mandatory=$true, ParameterSetName='Standard Security')]
    [String]$Username,

    # Password used to authenticate with the server
    [Parameter(Mandatory=$true, ParameterSetName='Standard Security')]
    [String]$Password
)

Begin
{
    $connectionString = switch ($pscmdlet.ParameterSetName) {
        "Trusted Connection" { "Server=$Server;Database=$Database;Trusted_Connection=True;" }
        "Standard Security" { "Server=$Server;Database=$Database;User Id=$Username;Password=$Password;" }
        default { throw "Unable to determine ParameterSetName" }
    }

    $connection = New-Object System.Data.SqlClient.SqlConnection($connectionString);

    $connection.Open()
    Write-Verbose "Connected to $Server"
}
Process
{
    $command = New-Object System.Data.SqlClient.SqlCommand($Query, $connection)
    $command.CommandTimeout = $Timeout
        
    $dataTable = New-Object System.Data.DataTable

    Write-Verbose "Executing query $Query"

    if ($pscmdlet.ShouldProcess("$Server\$Database", "Query"))
    {
        $reader = $command.ExecuteReader()
        $dataTable.Load($reader)
    }

    Write-Verbose "Returned $($dataTable.Rows.Count) rows"
    $dataTable.Rows
}
End
{
    $connection.Close();
    Write-Verbose "Closed connection to $Server"
}