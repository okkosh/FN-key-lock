#InstallKeybdHook
#Persistent
#SingleInstance Force

; Total number of Fn Keys
F_KEYS := 12
; Lock Status
global is_Locked := false
; Startup link
LINK_NAME := "\fnlock.lnk"
GUI_NAME := "FN Lock"
CONFIG_PATH :=  % A_MyDocuments . "\config.ini"

if FileExist(A_Startup . LINK_NAME)
	is_auto_start:= "checked"


Gui, Add, Text, x0 y10 w272 h20 +Center vStatus, (FN Keys Status: Unlocked)
Gui, Add, Text, x32 yp+25 w100 hp , Toggle Lock
Gui, Add, Edit, x100 yp w100 ReadOnly, Ctrl+Alt+L

loop, %F_KEYS%
{
	Gui, Add, Text, x32 yp+25 w50 hp , F%A_Index%
	Gui, Add, ComboBox, x100 yp w150 vA%A_index%, Browser_Forward|Brightness_up|Brightness_down|Brightness_default|Browser_Back|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Help|Sleep|PrintScreen|CtrlBreak|Break|AppsKey|NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|NumpadEnter|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|sc145|sc146|sc046|sc123
}

Gui, Add, Button, x82 yp+35 w100 gApply, Apply

Gui, Add, CheckBox, x82 yp+35 w220 h20 von_start %is_auto_start% gAutoStart, Automatically run on startup
Gui, Add, CheckBox, x82 yp+25 w220 h20 venabled_start gAutoEnable, Start in Enabled Mode

Menu, Tray, NoStandard
Menu, Tray, Add, Show, onShow
Menu, Tray, Add, Exit, OnExit
Menu, Tray, Tip, % GUI_NAME

; Shows GUI iff not configured (For the first time)
IfExist , % CONFIG_PATH
{
	loop, %F_KEYS%
		{
			IniRead, sett_Val, % CONFIG_PATH, Keys, F%A_index%,
			GuiControl, ChooseString, A%A_index%, %sett_val%
		}

	IniRead, enabled_mode, % CONFIG_PATH, Preferences, AutoEnabled, 0
	if (enabled_mode){
		GuiControl, , enabled_start, 1
	}
} else {
	Gui, Show, w260 h450, % GUI_NAME
}

Increments := 5 ; < lower for a more granular change, higher for larger jump in brightness
CurrentBrightness := GetCurrentBrightness()
; Handles Tray clicks
OnMessage(0x404, "AHK_NOTIFYICON")

if (enabled_mode){
	is_locked := true
	goto, Apply
}
return

; Toggle Lock
^!l::
	is_locked := !is_locked

Apply:
	Gui, submit, NoHide
	; Loop through all the keys
	loop, %F_KEYS%
	{
		GuiControlGet, ControlVal, , A%A_Index%
		if ((ControlVal <> "") and (is_Locked = true)){
			Hotkey , F%A_index%, OnKeyPress, On
		} else {
			Hotkey , F%A_index%, OnKeyPress, Off
		}
	}

	;Show tray notification according to the `is_locked` value
	if is_Locked {
		TrayTip, % GUI_NAME, FN Keys are Locked`nYou can now access the functions, 20, 17
		GuiControl, , status, (FN Keys Status: Locked)
	} else {
		TrayTip,% GUI_NAME , FN Keys are Unlocked`nWe've disabled the function keys, 20, 17
		GuiControl, , status, (FN Keys Status: Unlocked)
	}
	return


; label for whenever a key is pressed
OnKeyPress:
	str_press := SubStr(A_ThisHotkey, 2)
	GuiControlGet, str_val, , A%str_press%

	switch str_val
	{
		case "Brightness_up":
				ChangeBrightness( CurrentBrightness += Increments )
				return
		case "Brightness_down":
				ChangeBrightness( CurrentBrightness -= Increments )
				return
		case "Brightness_default":
				ChangeBrightness( CurrentBrightness := 50 )
				return
		default:
			send, {%str_val%}
			return
	}

OnExit:
	ExitApp

; Auto Start on Startup
AutoStart:
	Gui, submit, NoHide
	if on_start {
		FileCreateShortcut, %A_ScriptFullPath%, %A_Startup%\%LINK_NAME%, %A_ScriptDir%
	} else {
		FileDelete, %A_Startup%\%LINK_NAME%
	}
	return

; Auto Enable on start
AutoEnable:
	Gui, submit, NoHide
	IniWrite, %enabled_start%, % CONFIG_PATH, Preferences, AutoEnabled
	return

OnShow:
	Gui, Show, , % GUI_NAME
	return

;Save all the settings when the gui is closed
GuiClose:
	Gui, submit, NoHide
		loop, %F_KEYS%
		{
			GuiControlGet, str_val, , A%A_Index%
			IniWrite, %str_val%, % CONFIG_PATH, Keys, F%A_index%
		}
	Gui, hide
	return

;Clicking the icon will lead to Main window
AHK_NOTIFYICON(wParam, lParam, uMsg, hWnd)
{
	global gui_name
	if (lParam = 0x0201)
		Gui, Show, , % GUI_NAME
}

ChangeBrightness( ByRef brightness := 50, timeout = 1 ){
	if ( brightness >= 0 && brightness <= 100 ){
		For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightnessMethods" )
			property.WmiSetBrightness( timeout, brightness )
	} else if ( brightness > 100 ){
		brightness := 100
	} else if ( brightness < 0 ){
		brightness := 0
	}
}

GetCurrentBrightness(){
	For property in ComObjGet( "winmgmts:\\.\root\WMI" ).ExecQuery( "SELECT * FROM WmiMonitorBrightness" )
		currentBrightness := property.CurrentBrightness

	return currentBrightness
}
