$global:User = ""
$global:Password = ""
$global:IliasUrl = "https://elearning.hslu.ch/ilias/webdav.php/hslu/ref_"
$global:Credential = $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $(ConvertTo-SecureString -String $Password -AsPlainText -Force))

$global:Mounts = @{
    Name = "English"
    WebDavID = "2394466"
	DriveLetter = "E"
},
@{
    Name = "Informationssysteme"
    WebDavID = "2394472"
	DriveLetter = "I"
},
@{
    Name = "Programmierung"
    WebDavID = "2394470"
	DriveLetter = "P"
},
@{
    Name = "Kommunikation"
    WebDavID = "2394468"
	DriveLetter = "K"
},
@{
    Name = "Rechnungswesen, Betriebswirtschaftslehre, Volkswirtschaftslehere"
    WebDavID = "2394462"
	DriveLetter = "V"
},
@{
    Name = "Web"
    WebDavID = "2394474"
	DriveLetter = "W"
},
@{
    Name = "Mathematik"
    WebDavID = "2394464"
	DriveLetter = "M"		
} 

$global:Syncs = @{
    Name = "English"
    SourcePath = "E:\W.WIWSP01_A.H1471\Foren\"
    DestinationPath = "C:\OneDrive\Education\HSLU\English\"
},
@{
    Name = "Web"
    SourcePath = "W:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Web\"
    Exclude = "W:\W.WITEM12.H1471"
},
@{
    Name = "Rechnungswesen"
    SourcePath = "V:\FRW\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Rechnungswesen\"
},
@{
    Name = "Mathematik"
    SourcePath = "M:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Mathematik\"
    Exclude = "M:\W.WIMAT01.H1471"
},
@{
    Name = "Volkswirtschaft"
    SourcePath = "V:\VWL\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Volkswirtschaftslehre\"
},
@{
    Name = "Betriebswirtschaftslehre"
    SourcePath = "V:\BWL\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Betriebswirtschaftslehre\"
},
@{
    Name = "Programmieren"
    SourcePath = "P:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Programmierung\"
    Exclude = "P:\W.WIINM11.H1471"
},
@{
    Name = "Kommunikation"
    SourcePath = "K:\W.WIDEU01.H1471_1\Dokumente\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Kommunikation\"
},
@{
    Name = "Informationssysteme"
    SourcePath = "I:\"
    DestinationPath = "C:\OneDrive\Education\HSLU\Informationssysteme\"
    Exclude = "I:\W.WITEM11.H1471"
}