Start-Sleep -Seconds 60

wsl --mount \\.\PHYSICALDRIVE0 --partition 1 --type ext4 # newest
wsl --mount \\.\PHYSICALDRIVE1 --partition 1 --type ext4 # 1123

"C:\Program Files\Docker\Docker\Docker Desktop.exe"