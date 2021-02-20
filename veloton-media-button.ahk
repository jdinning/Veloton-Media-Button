/*

$Date: 2021/02/19 $
Version 1.0.0

Author:
John Dinning


I built this by modifying the great work done in the zwift-media-button script built by Jesper Rosenlund Nielsen, Jarl Petter Kvalsvik.
http://zwifthacks.com
License:
CC NY-NC
https://creativecommons.org/licenses/by-nc/4.0/


Script:
veloton-media-button

Functionality:
Maps keys on media-button to turn it into a Veloton game-controller.

Usage:
Script must be run as Administrator to work. If not it will try to launch itself in Administrator mode.

(An alternative solution would be to add the option 'Run with UI access' to context menus (via the AutoHotkey Setup) and use that option to launch the script)


Single Click functions:

  - Play/pause -> First Person View Toggles
  - Volume Up -> Drone View
  - Volume Down -> Chopper View
  - Previous -> Steer Left
  - Next -> Steer Right

Press and Hold Click Functions (press and hold button for a second or so then release)

  - Play/pause -> Look Back View Toggles
  - Volume Up -> Pace Command
  - Volume Down -> Revoke Commands
  - Previous -> Protect Command
  - Next -> Attack Command


*/


; Directives
; ==========

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; when load this script, automatically force load the new one


; Run as administrator automatically
 if not A_IsAdmin
    Run *RunAs "%A_ScriptFullPath%" ; (A_AhkPath is usually optional if the script has the .ahk extension.) You would typically check  first.


; MAIN ROUTINE
; =============== 

; Initialization
;KeyDelayFactor := 3 ; increase if some keypresses do not transmit properly
;SetKeyDelay, % KeyDelayFactor*10, % KeyDelayFactor*10


Media_Play_Pause::

  ; Click: F7 = First Person Views
  ; Hold-Click: Spacebar = Look Back

  KeyWait Media_Play_Pause, T0.5
  if (ERRORLEVEL = 1) {   
    ; press and hold detected, hit spacebar for look back
    Send {Space}
    keywait, Media_Play_Pause

  } else {
    ; single click detected, hit F7 to toggle first person views
    Send {F7}
    keywait, Media_Play_Pause
  }
Return


Media_Next::
  
  ; Click: Right Arrow = Steer Right
  ; Hold-Click: O+1 = Attack Command

  KeyWait Media_Next, T0.5
  if (ERRORLEVEL = 1) {   
    ; press and hold detected, hit O+1 for Attack Command
    Send o
    Sleep 15
    Send 1
    keywait, Media_Next

  } else {
    ; single click detected, hit Right Arrow to Steer Right
    loop 5 { ; adjust the loop number for steering sensitivity
    Send {Right down}
    Sleep 5
    Send {Right up}
    }
    keywait, Media_Next
  }
Return


Media_Prev::
  
  ; Click: Left Arrow = Steer Left
  ; Hold-Click: O+2 = Protect Command

  KeyWait Media_Prev, T0.5
  if (ERRORLEVEL = 1) {   
    ; press and hold detected, hit O+2 for Protect Command
    Send o
    Sleep 15
    Send 2
    keywait, Media_Prev

  } else {
    ; single click detected, hit Left Arrow to Steer Left
    loop 5 { ; adjust the loop number for steering sensitivity
    Send {Left down}
    Sleep 5
    Send {left up}
    }
    keywait, Media_Prev
  }
Return


Volume_Up::
  
  ; Click: F6 = Drone View
  ; Hold-Click: O+3 = Pace Command

  KeyWait Volume_Up, T0.5
  if (ERRORLEVEL = 1) {   
    ; press and hold detected, hit O+3 for Pace Command
    Send o
    Sleep 15
    Send 3
    keywait, Volume_Up

  } else {
    ; single click detected, hit F6 to go to Drone View
    Send {F6}
    keywait, Volume_Up
}
Return  


Volume_Down::
  
  ; Click: F8 = Chopper View
  ; Hold-Click: R = Revoke Command

  KeyWait Volume_Down, T0.5
  if (ERRORLEVEL = 1) {   
    ; press and hold detected, hit r for Revoke Command
    Send r
    keywait, Volume_Down

  } else {
    ; single click detected, hit F8 to show Chopper View
    Send {F8}
    keywait, Volume_Down
  }
Return  


+^Q::
    ; Quit the Autohotkey script Shift+Ctl+Q
  ExitApp
Return

