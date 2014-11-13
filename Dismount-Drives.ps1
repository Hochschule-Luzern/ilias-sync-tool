.\HSLUDriveConfig.ps1

$Mounts | ForEach{

    Write-Host "Dismount WebDav folder for: $($_.Name) on: $($_.DriveLetter)"

    net use $($_.DriveLetter + ":") /Delete
}