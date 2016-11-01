* Get source user all properties
* find Target user by Sid->SidHistory
* Add local copy of source user with ExistsInTarget = $true
* Get target user memberof (distinguishedNames)

class User
{
    # properties
    [string] $SourceSAMAccountname
    [string] $SourceUserPrincipalName
    [string] $SourceDistinguishedName
    [string] $SourceSid
    [string[]] $SourceMemberOf
    [boolean] $ExistsInTarget
    [string] $TargetSAMAccountname
    [string] $TargetUserPrincipalName
    [string] $TargetDistinguishedName
    [string] $TargetSid
    [string[]] $TargetMemberOf
    [string[]] $TargetSidHistory
    [boolean] $HasSidToSidHistoryMap
    [System.Collections.ArrayList] $SourcePermissionedShares
    [System.Collections.ArrayList] $TargetPermissionedShares

    # Constructors
    User() 
    {
        $this.ExistsInTarget = $False
        $this.SourcePermissionedShares = New-Object System.Collections.ArrayList
        $this.TargetPermissionedShares  = New-Object System.Collections.ArrayList
        $this.HasSidToSidHistoryMap = $False
    }
    
    User($SourceSAMAccountname, $SourceUserPrincipalName, $SourceDistinguishedName, $SourceSid) 
    {
        $this.ExistsInTarget = $False
        $this.SourcePermissionedShares = New-Object System.Collections.ArrayList
        $this.TargetPermissionedShares  = New-Object System.Collections.ArrayList
        $this.SourceSAMAccountname     = $SourceSAMAccountname
        $this.SourceUserPrincipalName  = $SourceUserPrincipalName
        $this.SourceDistinguishedName  = $SourceDistinguishedName
        $this.SourceSid                = $SourceSid
        $this.HasSidToSidHistoryMap = $False
    }
}


Class Test
{
    # Properties
    [string] $SubjectType
    [string] $Subject
    [string] $Test
    [string] $Target
    [String] $Result

    # Constructors
    Test() {}

    Test($SubjectType, $Subject, $Test, $Result)
    {
        $this.SubjectType = $SubjectType
        $this.Subject     = $Subject
        $this.Test        = $Test
        $this.Result      = $Result
    }
}




foreach ($SUser in $SourceUsers)
{
    foreach ($SUGroupMembership in $SourceUserMemberOf)
    {
        $Test = [test]::new()

        $Test.Subject     = $SUser.SourceSAMAccountname
        $Test.SubjectType = 'User'
        $Test.Test        = 'Is member of'
        $Test.Target      = $(Split-ADDNPath $SUGroupMembership -leaf)
        $Test.Result      =  'Fail'

        if ($SUser.ExistsInTarget)
        {
            $Test.Subject     = $SUser.TargetSAMAccountname
            foreach ($SUserTGroupMembership in $SUserTargetMemberOf)
            {
                if ($(Split-ADDNPath $SUGroupMembership -leaf) -eq $(Split-ADDNPath $SUserTGroupMembership -leaf))
                {
                    $Test.Result = 'Success'
                    Break
                }
            }

            if ($Test.Result -ne 'Success')
            {
                Results.Add($Test)
            }
        }
        else
        {
            $Test.Result = 'Fail'
            Results.Add($Test)
        }
    }
}