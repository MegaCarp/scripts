$sourcePath = "C:\Users\" + $env:USERNAME + "\Documents\Guild Wars 2\InputBinds"

$fileNames = (Get-ChildItem -Path $sourcePath -File).Name

foreach ($xml in $fileNames) {
    $sourcePath = "C:\Users\stash\Documents\scripts\ahk\gw2\InputBinds\" + $xml
    $targetPath = "C:\Users\stash\Documents\Guild Wars 2\InputBinds\" + $xml

    new-Item -ItemType HardLink -Path $sourcePath -Target $targetPath
}