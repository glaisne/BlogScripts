<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Create-ScriptProcessingADUsers
{
    [CmdletBinding()]
    [Alias()]
    Param
    (
        [switch]
        $ListProcess,

        [string]
        $ListPropertyName,

        [string[]]
        $ADProperties,

        [string]
        $Server
    )



$BaseScript = @'

$list = @"

"@

$Results = new-object System.Collections.ArrayList

foreach ($Entry in $list -split "`n")
{
    # Clean Data
    $Entry = $Entry.ToString().Trim()

    $Object = New-Object PSObject -Property @{
        <ListPropertyName>  = $Entry
        <objectProperties> 
        Found           = $False
        Error           = new-object System.Collections.ArrayList
    }

    $user = $null
    Try
    {
        $user = get-aduser -filter { <ADFilter> } -Server <Server> -properties <ADProperties> -ErrorAction Stop
    }
    Catch
    {
        $Err = $_
        write-Warning "Error getting user ($<ListPropertyName>) : $($Err.Exception.Message)"
        $Object.Found = $False
        $Object.Error.Add($($Err.Exception.Message)) | out-Null
        Continue
    }
    
    if ($user -eq $null)
    {
    	Write-Warning "User not found ($Entry)."
        $Object.Found = $False
        $Object.Error.Add("User not found ($Entry).") | out-Null
        Continue
    }
    else
    {
        $Object.Found = $True
    }
    
    if ($user -is [object[]])
    {
        Write-warning "Ambiguous user. Found $(($user | measure).count) users"
        $Object.Found = $False
        $Object.Error.Add("Ambiguous user. Found $(($user | measure).count) users") | out-Null
        Continue
    }

    <ADToObjectPropertiesLoop>

    $Results.Add($object) | out-null
}

$Results | select <ListPropertyName>, <ADPropertiesSelect>, found, error |ft -auto

'@

    # build objectproperties
    $objectProperties = new-object System.Collections.ArrayList

    foreach ($property in $ADProperties)
    {
        $objectProperties.Add("$(''.PadRight(8))$($property.Trim().padright(20)) = [string]::Empty`n") | Out-Null
    }

    $Script = $BaseScript.Replace("$(' '*8)<objectProperties>", $objectProperties)

    $Script = $Script.Replace("<ListPropertyName>","$ListPropertyName")

    $Script = $Script.Replace("<ADFilter>","$ListPropertyName -eq `$Entry")

    $Script = $Script.Replace("<Server>","$Server")

    $Script = $Script.Replace("<ADProperties>","@('$($ADProperties -join "','")')")

    $objectProperties = new-object System.Collections.ArrayList

    foreach ($property in $ADProperties)
    {
        $objectProperties.Add("$(''.PadRight(4))`$Object.$($property.padright(20)) = `$user.$Property`n") | Out-Null
    }

    $Script = $Script.Replace("    <ADToObjectPropertiesLoop>",$objectProperties)

    $Script = $Script.Replace("<ADPropertiesSelect>","$($ADProperties -join ", ")")

    $Script
}

#. PowerShell:\BlogScripts\Unpublished\Create-ScriptProcessingADUsers.ps1
#Create-ScriptProcessingADUsers -ListProcess -ListPropertyName 'UserPrincipalName' -PSObjectProperties mail, ExtensionAttribute4 -ADProperties mail, ExtensionAttribute4 -Server 'ch3-nagc-sv01.na.cushwake.gbl'
