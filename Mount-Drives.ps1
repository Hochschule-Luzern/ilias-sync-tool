.\HSLUDriveConfig.ps1

$Mounts | ForEach-Object{

    Write-Host "Mount WebDav folder for: $($_.Name) to: $($_.DriveLetter)"
    
    $Net = $(New-Object -ComObject WScript.Network);
    $Net.MapNetworkDrive($($_.DriveLetter + ":"), $($IliasUrl + $_.WebDavID + "/"), $true, $User, $Password);
    #New-PSDrive -Name $_.DriveLetter -PSProvider FileSystem -Root $($IliasUrl + $_.WebDavID + "/") -Persist
    #& net use $($_.DriveLetter + ":") $($IliasUrl + $_.WebDavID + "/") /User:$User $Password
}
