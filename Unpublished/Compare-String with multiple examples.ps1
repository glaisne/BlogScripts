$forward = new-object System.Collections.Generic.List[psobject]
$forward.Add($(New-Object PSObject -Property @{
    Before = "gene.laisne@cushwake.com"
    After  = "laisne.gene@cushwake.com"
}))

$forward.Add($(New-Object PSObject -Property @{
    Before = "gene.x.laisne@cushwake.com"
    After  = "laisne.x.gene@cushwake.com"
}))


$Backward = new-object System.Collections.Generic.List[psobject]
$Backward.Add($(New-Object PSObject -Property @{
    Before = "laisne.gene@cushwake.com"
    After  = "gene.laisne@cushwake.com"
}))

$Backward.Add($(New-Object PSObject -Property @{
    Before = "laisne.x.gene@cushwake.com"
    After  = "gene.x.laisne@cushwake.com"
}))


gc C:\temp\CWRelaxedPasswordUsers_11152016.txt | convert-string -Example $forward | out-file c:\temp\pre-sortedC.txt
gc c:\temp\pre-sortedC.txt | sort | convert-string -Example $Backward | out-file C:\temp\CWRelaxedPasswordUsers_11152016_sortedD.txt -append


