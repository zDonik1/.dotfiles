# winterm

Windows Terminal and Cmd/Powershell configuration using Clink and Starship.

## For Cmd

Set the environment variable `CLINK_PROFILE` to `%userprofile%\.config\winterm`.

Open Cmd (without launching Windows Terminal) to make a hard link for Windows Terminal settings.

```
cd %localappdata%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState
mklink /H settings.json %userprofile%\.config\winterm\settings.json
```

## For Powershell

Enter `$profile` in Powershell to find the profile script and add the line:

```
. $HOME\.config\winterm\profile.ps1
```

If execution policy doesn't allow for script executions, update the policy:

```
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
```

Open Powershell as administrator to open the shell without the Terminal (and make sure that the Terminal is closed). Make a soft link to the Terminal settings

```
cd $env:localappdata\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState
New-Item -ItemType SymbolicLink -Name settings.json -Value $HOME\.config\winterm\settings.json
```
