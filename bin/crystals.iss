
[Setup]
;
;Adjust the program names and version here as appropriate:
;
AppVerName=CRYSTALS 14.52 (Sept 2012)
AppVersion=14.52
OutputBaseFilename=crystals-a1452-Sep12-setup

AppName=CRYSTALS
OutputDir=..\installer
AppCopyright=Copyright (c) University of Oxford, 20 October 2009. All rights reserved.
AppPublisher=Chemical Crystallography Laboratory, University of Oxford
AppPublisherURL=http://www.xtl.ox.ac.uk/
BackSolid=0
ChangesAssociations=Yes

SolidCompression=yes
Compression=bzip

DisableDirPage=0
DisableStartupPrompt=yes
CreateAppDir=1
DisableProgramGroupPage=yes
Uninstallable=1
AllowNoIcons=0
DefaultDirName={sd}\Wincrys
DefaultGroupName=Crystals
;These files display during the installation:
DiskSpanning=0
WizardImageFile=..\bin\instimage.bmp
LicenseFile=..\bin\licence.txt
InfoAfterFile=..\bin\postinst.txt

[Dirs]
Name: {app}\Manual
Name: {app}\Manual\analyse
Name: {app}\Script
Name: {app}\user
Name: {app}\user\Script
Name: {app}\demo
Name: {app}\mce
Name: {app}\MCE\mce_manual_soubory

[Files]                                                     
Source: ..\build\*.*; DestDir: {app}\; Excludes: "make*,buildfile.bat,code.bat";
Source: ..\build\script\*.*; DestDir: {app}\script\;
Source: ..\build\mce\*.*; DestDir: {app}\mce\;  Flags: ignoreversion;            
Source: ..\build\mce\mce_manual_soubory\*.*; DestDir: {app}\mce\mce_manual_soubory\;
Source: ..\build\manual\*.*; DestDir: {app}\manual\;
Source: ..\build\manual\analyse\*.*; DestDir: {app}\manual\analyse\;
Source: ..\build\demo\*; DestDir: {app}\demo\; Flags: recursesubdirs; Excludes: "*.doc";

[Icons]
Name: "{userdesktop}\Crystals";                 Filename: "{app}\crysload.exe";        WorkingDir: "{app}"; IconFilename: "{app}\crystals.exe"; IconIndex: 0
Name: "{userdesktop}\Crystals Getting Started"; Filename: "{app}\manual\readme.html";  WorkingDir: "{app}"
Name: "{group}\Crystals";                       Filename: "{app}\crysload.exe";        WorkingDir: "{app}"; IconFilename: "{app}\crystals.exe"; IconIndex: 0
Name: "{group}\HTML help";                      Filename: "{app}\Manual\Crystcon.htm"; WorkingDir: "{app}"
Name: "{group}\Getting Started";                Filename: "{app}\manual\readme.html";  WorkingDir: "{app}"

[INI]
;
; This ini file is kept for backwards compatibilty. WinGX uses it.
;
Filename: wincrys.ini; Section: Setup; Key: Location; String: "{app}"; Flags: uninsdeleteentry
Filename: wincrys.ini; Section: Setup; Key: Crysdir; String: "{app}\user\,{app}\"; Flags: uninsdeleteentry
Filename: wincrys.ini; Section: Latest; Key: Strdir; String: "{app}\demo\demo"; Flags: uninsdeleteentry

[Registry]
Root: HKLM; Subkey: "Software\Chem Cryst"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\Chem Cryst\Crystals"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "Location"; ValueData: "{app}"
Root: HKLM; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "Crysdir"; ValueData: "{app}\user\,{app}\"

Root: HKCU; Subkey: "Software\Chem Cryst"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; Flags: uninsdeletekey

Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "Location"; ValueData: "{app}"
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "Crysdir"; ValueData: "{app}\user\,{app}\"

Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "Strdir"; ValueData: "{app}\demo\demo"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "FontHeight"; ValueData: "8"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "FontWidth"; ValueData: "0"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "FontFace"; ValueData: "Lucida Console"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "Software\Chem Cryst\Crystals"; ValueType: string; ValueName: "PLATONDIR"; ValueData: "{app}\platon.exe"; Flags: createvalueifdoesntexist

Root: HKCR; SubKey: .dsc; ValueType: STRING; ValueData: CrystalsFile; Flags: uninsdeletevalue
Root: HKCR; SubKey: CrystalsFile; ValueType: STRING; ValueData: Crystals Data File; Flags: uninsdeletevalue
Root: HKCR; SubKey: CrystalsFile\Shell; ValueType: NONE; Flags: uninsdeletevalue
Root: HKCR; SubKey: CrystalsFile\Shell\Open; ValueType: NONE; Flags: uninsdeletevalue
Root: HKCR; SubKey: CrystalsFile\Shell\Open\Command; ValueType: STRING; ValueData: """{app}\crystals.exe"" ""%1"""; Flags: uninsdeletevalue
Root: HKCR; SubKey: CrystalsFile\DefaultIcon; ValueType: STRING; ValueData: {app}\crystals.exe,1; Flags: uninsdeletevalue

;These were only to correct v11.99 error, now removed.
;
; Root: HKCR; SubKey: Directory\shell; ValueType: STRING; ValueData: none; MinVersion: 5,5
; Root: HKCR; SubKey: Directory\shell; ValueType: NONE;  OnlyBelowVersion: 5,5; Flags: deletevalue

Root: HKCR; SubKey: Directory\shell\crystals; ValueType: STRING; ValueData: Open Crystals Here;  Flags: uninsdeletekey
Root: HKCR; SubKey: Directory\shell\crystals\command; ValueType: STRING; ValueData: """{app}\crystals.exe"" ""%L\crfilev2.dsc""";  Flags: uninsdeletekey
