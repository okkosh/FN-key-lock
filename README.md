# FN Key Lock
A Script to simulate custom hardware (F1-F12) FN key lock on windows

![Screenshot](https://i.imgur.com/54YAxSS.png)

## Installation:
Press  `Ctrl`+`Alt`+`L` to toggle Lock.

**How to Install**
- Download the [fnlock.exe](https://github.com/okkosh/FN-key-lock/raw/master/bin/fnlock.exe) file.
- Place it anywhere on your system.
- *Double Click* **fnlock.exe** and It will show up in your tray.
- Enjoy!

**How to Remove**
- Exit `fnlock.exe` from the tray (If it is already running).
- Delete `fnlock.exe` file and optionally delete `config.ini` file from `Documents` directory of your windows.

**Starting Automatically with Windows**
- Place the file inside *C:\Users\[Username]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup* folder
- That's it!

**Notes**
- The GUI shows up only for the first time and for the subsequent runs it will start in the tray mode.
- You can always access the GUI using `tray->right-click->Show`

## Building
- Clone the Repo
- Download Autohotkey (AHK) from https://www.autohotkey.com
- Use `ahk2exe` tool and add `fn-lock` script into it
- Compile

## Credits:
Icon by - [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/)
