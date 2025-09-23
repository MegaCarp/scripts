#Requires AutoHotkey v2.0
#SingleInstance Force
#Include defaults-global.ahk

; Hardlink_RemoveTarget_HardlinkSource("C:\games\GuildWars2-arenanet","C:\games\GuildWars2",,'dewit')

hardlnkFile := A_Temp '\hardlink-test.txt'
try FileDelete(hardlnkFile)
FileAppend('test', hardlnkFile)
HardlinkA_File(hardlnkFile, hardlnkFile '2.txt')

run A_Temp