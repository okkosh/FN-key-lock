# FN Key Lock
A Script to simulate custom hardware (F1-F12) FN key lock on windows

![Screenshot](https://i.imgur.com/rE8klvT.jpg)

**Features**
- Simple and Quick
- Launch custom hotkeys or any apps with FN
- Auto-enable or Auto-start on boot

## Installation:
Press  `Ctrl`+`Alt`+`L` to toggle Lock.

**How to Install**
- Download [fnlock.exe](https://github.com/okkosh/FN-key-lock/releases) file from releases.
- Place it anywhere on your system.
- *Double Click* **fnlock.exe** and It will show up in your tray.
- Enjoy!

**How to Remove**
- Exit `fnlock.exe` from the tray (If it is already running).
- Delete `fnlock.exe` file and optionally delete `config.ini` file from `Documents` directory of your windows.

**Starting Automatically with Windows**
1. Open the UI via tray->FN Lock->Right-Click->Show
2. Enable the `Automatically run on startup` option
3. Voila!

**Notes**
- The GUI shows up only for the first time. For the subsequent runs -- it will start in the tray mode.
- You can always access the GUI using `tray->right-click->Show` or by clicking the tray icon

## Building
- Clone the Repo
- Download Autohotkey (AHK) from https://www.autohotkey.com
- Use `ahk2exe` tool and add `fn-lock` script into it
- Compile

## Contribute
- Clone this project (Note: Follow the Commit guidelines from https://cbea.ms/git-commit/)
- Make changes and create a PR
- Yup! That's it!

## Credits:
Icon by - [Papirus Development Team](https://github.com/PapirusDevelopmentTeam/)
