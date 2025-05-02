#Requires AutoHotkey v2.0

; ----------------------------------------------------------------------------------------------------------------------
; Name .........: Mutex class
; Description ..: Implement a simple mutex management system.
; AHK Version ..: 1.1.30.1 x32/64 ANSI/Unicode
; Author .......: cyruz - http://ciroprincipe.info
; License ......: WTFPL - http://www.wtfpl.net/txt/copying/
; Changelog ....: Jul. 21, 2019 - v0.1 - First version.
; ----------------------------------------------------------------------------------------------------------------------

; Name .........: ClassHook - PUBLIC CLASS
; Description ..: Manages Mutex creation, wait, release and destroy.
Class Mutex
{
	Static MutexPfx := "Global_AHK_Mutex_"

    ; Name .........: __New - PRIVATE CONSTRUCTOR
    ; Description ..: Create the Mutex, setup and return the object.
	; Parameters ...: sId     = ID of the Mutex, it will be appended to the prefix to create the name.
    ; ..............: msWait  = How many milliseconds to wait before timing out.
    ; ..............: msSleep = How many milliseconds to sleep between MsgWaitForMultipleObjectEx calls.
	__New(sId, msWait:=-1, msSleep:=100)
	{	
		this.MutexId      := sId
		this.MutexName    := Mutex.MutexPfx sId
		this.MutexWaitMs  := msWait
		this.MutexSleepMs := msSleep
		this.MutexHandle  := DllCall( "CreateMutex"
		                            ,  'Ptr', 0
									,  'Int', False
									,  'Str', this.MutexName
                                    ,  'Ptr' )
		Return this.MutexHandle ? this : 0
	}

	; Name .........: __Delete - PRIVATE DESTRUCTOR
    ; Description ..: Close Mutex handle.
	__Delete()
	{
		DllCall( "CloseHandle"
		       ,  'Ptr', this.MutexHandle )
	}

 	; Name .........: Wait
	; Description ..: Wait for the Mutex to be in signaled state and take ownership.
	; Return .......: -1 - Wait function failed.
	; ..............:  0 - Timeout.
	; ..............:  1 - Mutex in signaled state. Not owned. Calling thread will own it.
	; ..............:  2 - Abandoned mutex. Calling thread will own it. *** POTENTIALLY DANGEROUS ***
	Wait()
	{
		While ( True )
		{
			nWait := DllCall( "MsgWaitForMultipleObjectsEx"
		                    ,  'UInt', 1
		                    ,  'PtrP', this.MutexHandle
					        ,  'UInt', this.MutexWaitMs
					        ,  'UInt', 0x04FF ; QS_ALLINPUT = 0x04FF
					        ,  'UInt', 0 )
			If      ( nWait == -1  ) ; WAIT_FAILED = -1
				Return -1
			Else If ( nWait == 258 ) ; WAIT_TIMEOUT = 258
				Return  0
			Else If ( nWait == 0   ) ; WAIT_OBJECT_0 = 0
				Return  1
			Else If ( nWait == 128 ) ; WAIT_ABANDONED_0 = 128
				Return  2
			Else Sleep this.MutexSleepMs
		}
	}

	; Name .........: Release
    ; Description ..: Release Mutex.
	Release()
	{
		Return DllCall( "ReleaseMutex"
		              ,  'Ptr', this.MutexHandle )
	}
}