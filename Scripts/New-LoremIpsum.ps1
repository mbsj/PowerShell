<#
.SYNOPSIS
    Generates a now lorem ipsum string. 
.DESCRIPTION
    Queries the site http://lipsum.com for a new string with lorem ipsum content. 
.EXAMPLE
    .\New-LoremIpsum.ps1
    Generates one paragraph.
.EXAMPLE
    .\New-LoremIpsum.ps1 -Type Word -Count 50
    Generates a 50 word string
.EXAMPLE
    .\New-LoremIpsum.ps1 -StandardStart 
    Generates one paragraph, beginning with the standard lorem ipsum sentence. 
.INPUTS

.OUTPUTS
    String
.NOTES
    Uses http://www.lipsum.com/feed/xml
    Credit for the page goes to James Wilson
.LINK
    http://www.lipsum.com
.LINK
    http://www.lipsum.com/donate
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param (
    # Generates lorem ipsum, limited by byte size, word count or paragraphs
    [Parameter(Position = 0)]
    [ValidateSet("Paragraph", "Word", "Byte")]
    [String]$Type = "Paragraph",

    # The number of items to generate as defined by Type
    [Parameter(Position = 1)]
    [ValidateScript( {$_ -gt 0} )]
    [Int]$Count = 1,
    
    # Whether to include the standard lorem ipsum string at the beginning: "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    [Parameter()]
    [Switch]$StandardStart
)

begin {
    $shortType = switch ($Type) {
        "Paragraph" {
            "paras" 
        }
        "Word" {
            "words" 
        }
        "Byte" {
            "bytes" 
        }
    }

    $stringStart = if ($StandardStart) {
        "yes"
    }
    else {
        "no"
    }

    $generatedRegex = "Generated (\d+) paragraph(?:s)?, (\d+) word(?:s)?, (\d+) byte(?:s)? of Lorem Ipsum"

    $uri = "http://www.lipsum.com/feed/xml?amount=$Count&what=$shortType&start=$stringStart"
}

process {
    if ($Type -eq "Byte" -and $Count -lt 27) {
        Write-Warning "Minimum byte count is 27"
    }
    elseif ($Type -eq "Word" -and $Count -lt 2) {
        Write-Warning "Minimum word count is 2"
    }

    if ($pscmdlet.ShouldProcess("http://www.lipsum.com/feed/xml", "Query for $Count $Type")) {
        [xml]$response = Invoke-WebRequest -Uri $uri -ErrorAction Stop
        
        $response.feed.generated -match $generatedRegex | Out-Null
        
        $props = @{
            Bytes      = [int]$Matches[3]
            Paragraphs = [int]$Matches[1]
            Words      = [int]$Matches[2]
            Text       = $response.feed.lipsum
        }
        
        New-Object -TypeName psobject -Property $props
    }
}