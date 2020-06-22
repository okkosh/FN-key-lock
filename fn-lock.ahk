#InstallKeybdHook
#Persistent
#SingleInstance Force

global is_Locked := false

Gui, Add, Text, x0 y10 w272 h20 +Center vStatus, (FN Keys Status: Unlocked)
Gui, Add, Text, x32 yp+25 w100 hp , Toggle Lock
Gui, Add, Edit, x100 yp w100 ReadOnly, Ctrl+Alt+L

loop, 12
{
	Gui, Add, Text, x32 yp+25 w50 hp , F%A_Index%
	Gui, Add, ComboBox, x100 yp w150 vA%A_index%, Browser_Forward|Browser_Back|Browser_Refresh|Browser_Stop|Browser_Search|Browser_Favorites|Browser_Home|Volume_Mute|Volume_Down|Volume_Up|Media_Next|Media_Prev|Media_Stop|Media_Play_Pause|Launch_Mail|Launch_Media|Launch_App1|Launch_App2|Help|Sleep|PrintScreen|CtrlBreak|Break|AppsKey|NumpadDot|NumpadDiv|NumpadMult|NumpadAdd|NumpadSub|NumpadEnter|Tab|Enter|Esc|BackSpace|Del|Insert|Home|End|PgUp|PgDn|Up|Down|Left|Right|ScrollLock|CapsLock|NumLock|Pause|sc145|sc146|sc046|sc123
}

Gui, Add, Button, x82 yp+35 w100 gApply, Apply

Menu, Tray, NoStandard
Menu, Tray, Add, Show, onShow
Menu, Tray, Add, Exit, OnExit


; Shows GUI iff not configured (For the first time)
IfExist , %A_MyDocuments%\config.ini
{
	loop, 12
		{
			IniRead, sett_Val, %A_MyDocuments%\config.ini, Keys, F%A_index%,
			GuiControl, ChooseString, A%A_index%, %sett_val%
		}
}else{
	Gui, Show, w272 h400, FN Lock
}
return
Apply:	return