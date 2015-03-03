.\HSLUDriveConfig.ps1
.\Dismount-Drives.ps1
.\Mount-Drives.ps1

$Syncs | ForEach-Object{

    Write-Host "`nRun sync for: $($_.Name)"

    $SourcePath = $_.SourcePath
    $DestinationPath = $_.DestinationPath
    $Exclude = $_.Exclude

    # Get directories
    $SourceDirectories = Get-ChildItem $SourcePath -Directory -Recurse -PipelineVariable Directory | ForEach-Object{ 
            $ignore = $false
            if($Exclude | Where {$Directory.FullName -like $_}){
                $ignore = $true
            }
            if(-not $ignore){$Directory}
        } |
        select @{L="RelativePath";E={$_.FullName -replace [regex]::Escape($SourcePath),""}}

    $DestinationDirectories = Get-ChildItem $DestinationPath -Directory -Recurse -PipelineVariable Directory | ForEach-Object{ 
            $ignore = $false
            if($Exclude | Where {$Directory.FullName -like $_}){
                $ignore = $true
            }
            if(-not $ignore){$Directory}
        } |
        select @{L="RelativePath";E={$_.FullName -replace [regex]::Escape($DestinationPath),""}}

    # create new directories

    $NewDirectories = @()
    if($SourceDirectories -eq $null){

    }elseif($DestinationDirectories -eq $null){

        $NewDirectories += $SourceDirectories | ForEach-Object{
            Join-Path $DestinationPath $_.RelativePath
        }
    }else{

         Compare-Object $DestinationDirectories $SourceDirectories -Property "RelativePath" | where{$_.SideIndicator -eq "=>"} | ForEach-Object{
    
            $NewDirectories += Join-Path $DestinationPath $_.RelativePath
        }
    }

    $NewDirectories | where{$_ -ne $null} | ForEach-Object{

        Write-Host "Create new directory: $_"
        New-Item -Type Directory -Path $_ -Confirm | Out-Null
    }

    # sync files for every directory

    $SyncDirectories = @()
    $SyncDirectories += $SourceDirectories | ForEach-Object{$_.RelativePath}
    $SyncDirectories += "\"

    $NewFiles = @()
    $SyncDirectories | where{$_ -ne $null} | ForEach-Object{
        
        # get files

        $SourceDirectory = Join-Path $SourcePath $_
        $DestinationDirectory = Join-Path $DestinationPath $_

        $SourceFiles = Get-ChildItem $SourceDirectory -File -PipelineVariable File | ForEach-Object{ 
                $ignore = $false
                if($Exclude | Where {$File.FullName -like $_}){
                    $ignore = $true
                }
                if(-not $ignore){$File}
            } |
            select @{L="RelativeFilePath";E={$_.FullName -replace [regex]::Escape($SourcePath),""}},LastWriteTime
        
        $DestinationFiles = Get-ChildItem $DestinationDirectory -File -ErrorAction Continue -PipelineVariable File | ForEach-Object{ 
                $ignore = $false
                if($Exclude | Where {$File.FullName -like $_}){
                    $ignore = $true
                }
                if(-not $ignore){$File}
            } |
            select @{L="RelativeFilePath";E={$_.FullName -replace [regex]::Escape($DestinationPath),""}},LastWriteTime
        
        # sync files

        if($SourceFiles -eq $null){

        }elseif($DestinationFiles -eq $null){

            $NewFiles += $SourceFiles | ForEach-Object{
                @{
                    Source = Join-Path $SourcePath $_.RelativeFilePath
                    Destination = Join-Path $DestinationPath $_.RelativeFilePath
                }
            }
        }else{

            $NewFiles += Compare-Object $DestinationFiles $SourceFiles -Property "RelativeFilePath","LastWriteTime" | where{$_.SideIndicator -eq "=>"} | ForEach-Object{

                # compare time stamp if file already exists

                $SourceFile = Get-ChildItem (Join-Path -Path $SourcePath -ChildPath $_.RelativeFilePath)
                $DestinationFile = Join-Path -Path $DestinationPath -ChildPath $_.RelativeFilePath
                if(Test-Path($DestinationFile)){
                    $DestinationFile = Get-ChildItem $DestinationFile
                }

                if(Test-Path($DestinationFile)){

                    # if source file is newer create a time stamp copy in order not to overwrite the edited file

                    if($DestinationFile.LastWriteTime -lt $SourceFile.LastWriteTime){

                        # create new file path
                        $TempDestinationFilePath = Join-Path (Split-Path $DestinationFile -Parent) $($SourceFile.Name + "#" + $((Get-date $SourceFile.LastWriteTime -Format s) -replace ":","-") + $SourceFile.Extension)
                    
                        # output copy job if destination file not already exists
                        if(-not (Test-Path $TempDestinationFilePath)){

                            @{
                                Source = $SourceFile.FullName
                                Destination = $TempDestinationFilePath
                            }
                        }                    
                    }else{
                        
                        # do not copy as my files are newer
                    }

                }else{
                    @{
                        Source = $SourceFile.FullName
                        Destination = $(if($DestinationFile.GetType().Name -eq "String"){$DestinationFile}else{$DestinationFile.FullName})
                    }
                }
            }

            # Add file containing list of files only existing in the local drive

            $LocalFiles = @()
            $LocalFiles += Compare-Object $DestinationFiles $SourceFiles -Property "RelativeFilePath" | where{$_.SideIndicator -eq "<="} | ForEach-Object{
                (Get-ChildItem (Join-Path -Path $DestinationPath -ChildPath $_.RelativeFilePath)).Name
            }
            $LocalFilePath = (Join-Path $DestinationDirectory "LocalFiles.md")
            if($LocalFiles -ne $null){
                Write-Host "Update: $LocalFilePath"
                Set-Content -Path $LocalFilePath -Value ($LocalFiles | ForEach-Object{"* $_"})
            }elseif(($LocalFiles -eq $null) -and (Test-Path $LocalFilePath)){
                Write-Host "Remove: $LocalFilePath"
                Remove-Item -Path $LocalFilePath
            }
        }
    }
    # copy files

    $NewFiles | ForEach-Object{

        Write-Host "Copy file from: $($_.Source) to: $($_.Destination)"
        Copy-Item -Path $_.Source -Destination $_.Destination -Confirm | Out-Null
    }
}