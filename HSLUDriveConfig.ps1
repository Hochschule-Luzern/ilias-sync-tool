$global:User = ""
$global:Password = ""
$global:IliasUrl = "https://elearning.hslu.ch/ilias/webdav.php/hslu/ref_"
$global:Credential = $(New-Object –TypeName System.Management.Automation.PSCredential –ArgumentList $User, $(ConvertTo-SecureString –String $Password –AsPlainText -Force))

$global:Mounts = @{
    Name = "Datenmanagement"
    WebDavID = "2618825 "
	DriveLetter = "S"
},@{
    Name = "Kommunikation"
    WebDavID = "2618801"
	DriveLetter = "K"
},@{
    Name = "Volkswirtschaftslehre2"
    WebDavID = "2618953"
    DriveLetter = "V"
},@{
    Name = "Management1"
    WebDavID = "2618805"
    DriveLetter = "M"
},@{
    Name = "ERP-Systeme"
    WebDavID = "2618829"
    DriveLetter = "E"
},@{
    Name = "Wirtschaftsmathematik2"
    WebDavID = "2618793"
    DriveLetter = "W"
},@{
    Name = "Softwarekomponenten"
    WebDavID = "2618821"
    DriveLetter = "J"
},@{
    Name = "English"
    WebDavID = "2618929"
    DriveLetter = "H"
}

$global:Syncs = @{
    Name = "Datenmanagement"
    SourcePath = "S:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Datenmanagement\"
    Exclude = "S:\W.WIINM22.F1571*"
},@{
    Name = "Kommunikation"
    SourcePath = "K:\W.WIDEU02.F1571\Dokumente\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Kommunikation\"
    Exclude = ""
},@{
    Name = "Volkswirtschaftslehre2"
    SourcePath = "V:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Volkswirtschaftslehre2\"
    Exclude = "V:\Briefkasten", "V:\Dateiaustausch", "V:\Foren"
},@{
    Name = "Management1"
    SourcePath = "M:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Management1\"
    Exclude = "M:\W.WIMGT02.F1571*"
},@{
    Name = "ERP-Systeme"
    SourcePath = "E:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\ERP-Systeme\"
    Exclude = "E:\W.WIPRM02.F1571*", "E:\ blau_SemesterProgramm-PRM02-FS15.pdf", "E:\ rosa_stoff_abgr_PRM02-FS15.pdf"
},@{
    Name = "Wirtschaftsmathematik2"
    SourcePath = "W:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Wirtschaftsmathematik2\"
    Exclude = "W:\W.WIMAT02.F1571*"
},@{
    Name = "Softwarekomponenten"
    SourcePath = "J:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\Softwarekomponenten\"
    Exclude = "J:\W.WIINM21.F1571*","J:\EES\ESS-B1 JUnit_TDD_Testen_selbständig\Unterlagen\TotalBeginnersAll.zip","J:\Praxisprojekt\06. Mögliche Tools\easetupfull_20140916.exe",
    "J:\EES\ESS-B3 Softwarearchitektur_Dokumentation\Video_42 für Architekten.mp4", "J:\EES\ESS-B3 Softwarearchitektur_Dokumentation\Video_Wo Softwarearchitekten lernen.mp4"
},@{
    Name = "English"
    SourcePath = "H:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Semester2\English\"
    Exclude = ""
}