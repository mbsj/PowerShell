<#
.SYNOPSIS
    Invokes a SQL query agains a specified MySQL database
.DESCRIPTION
    Invokes one or more queries agains a specified MySQL database. Result set is loaded into data table rows and returned directly. 
.EXAMPLE
   .\Invoke-MySQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB

   Invokes the query against the specified server and database. Uses a trusted connection and the default timeout of 10 seconds. 
.EXAMPLE
   .\Invoke-MySQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB -Timeout 60

   Invokes the query against the specified server and database. Uses a trusted connection and specifies a long er timeout og 60 seconds.
.EXAMPLE
   .\Invoke-MySQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB -Username DBUser -Password SuperSecretPassword

   Invokes the query against the specified server and database but connects using standard security. 
   This requires an explicit username and password which is specified in -Username and -Password
.EXAMPLE
   $queries | .\Invoke-MySQL.ps1 -Query "SELECT * FROM Table" -Server DBServer01 -Database StoreDB

   $queries is an array of several query strings. One connection is made after which each query is invoked agains the server as in the first example. 
.NOTES
    Be cautious when executing multiple queries agains different tables. As each table will return different properies, these may be hidden when using i.e. Format-Table to format output. 
    The formating cmdlet will use the first objects to define the properties to show, and so will not show properties for rows returned later in the result set. 
#>
function Invoke-MySQL {
    [CmdletBinding(SupportsShouldProcess = $true, 
        PositionalBinding = $false,
        ConfirmImpact = 'Medium')]
    [OutputType([System.Data.DataRow])]
    Param
    (
        # Query to be executed
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]$Query,

        # Server to connect to
        [Parameter(Mandatory = $true, Position = 1)]
        [String]$Server,

        # Database to query
        [Parameter(Mandatory = $true, Position = 2)]
        [String]$Database,

        # Timeout for the query
        [Parameter()]
        [ValidateScript( {$_ -gt 0})]
        [Int]$Timeout = 10,

        # Username used to authenticate with the server
        [Parameter(Mandatory = $true, Position = 3)]
        [String]$Username,

        # Password used to authenticate with the server
        [Parameter(Mandatory = $true, Position = 4)]
        [String]$PlainTextPassword
    )
    
    begin {
        if ([System.Reflection.Assembly]::LoadWithPartialName("MySql.Data") -eq $null) {
            throw "Unable to load assembly MySql.Data. Verify MySQL .NET connectior is installed: https://dev.mysql.com/downloads/connector/net/"
        }

        $connection = New-Object MySql.Data.MySqlClient.MySqlConnection
        $connection.ConnectionString = "Server=$Server;Uid=$Username;Pwd=$PlainTextPassword;database=$Database;"

        if ($pscmdlet.ShouldProcess("$Server\$Database", "Open connection")) {
            $connection.Open()
        }
    }
    
    process {
        if ($pscmdlet.ShouldProcess("Target", "Operation")) {
            $command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
            $dataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
            $dataSet = New-Object System.Data.DataSet

            $dataAdapter.Fill($dataSet, "data")

            $dataSet.Tables[0]
        }
    }
    
    end {
        $connection.Close()
    }
}
