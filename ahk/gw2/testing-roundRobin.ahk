#Requires AutoHotkey v2.0

#Include roundRobin.ahk

testRoundRobin := RoundRobin()

testRoundRobin.Waypoints

    s := (s := "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z й,ц,у,к,е,н,г,ш,щ,з,х,ъ,ф,ы,в,а,п,р,о,л,д,ж,я,ч,с,м,и,т,ь,б,ю.") "," s "," s
    while (A_Index < Random(0, 100 ))
    s := s "," s

    StrSplit


Sort s, Random D,
i := SubStr(StrReplace(s, ","), 1, 4)
MsgBox, % i