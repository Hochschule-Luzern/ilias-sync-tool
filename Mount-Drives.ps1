.\HSLUDriveConfig.ps1

$Mounts | ForEach-Object{

    Write-Host "Mount WebDav folder for: $($_.Name) to: $($_.DriveLetter)"

    $IliasUrl + $_.WebDavID + "/"

    $Net = $(New-Object -ComObject WScript.Network);
    $Net.MapNetworkDrive($($_.DriveLetter + ":"), $($IliasUrl + $_.WebDavID + "/"), $true, $User, $Password);
}