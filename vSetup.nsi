Name "V"

Icon "vlang.ico"

OutFile "VSetup.exe"

InstallDir %LocalAppData%\Programs\V\v.${__version__}-{x}-bit\
InstallDirRegKey HKLM "Software\"

RequestExecutionLevel admin
