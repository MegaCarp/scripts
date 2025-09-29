$sourcePath = "C:\Users\" + $env:USERNAME + "\Documents\Guild Wars 2\InputBinds"

$fileNames = (Get-ChildItem -Path $sourcePath -File).Name

foreach ($xml in $fileNames) {
    $whereToPutLink = "C:\Users\stash\Documents\scripts\ahk\gw2\InputBinds\" + $xml
    $LinkFrom = "C:\Users\stash\AppData\Roaming\Gw2Launcher\data\1\Documents\Guild Wars 2\InputBinds\" + $xml

    New-Item -ItemType HardLink -Path $whereToPutLink -Target $LinkFrom
}