# myUtilities

PowerShell Module that contains a collection of personal and gathered ease of life functions.

## :books: File Structure

The module manifest [MyUtilites.psd1](1.0.0/MyUtilities.psd1) imports submodules divided by target
| **Submodule**                           | **Description**                                                                                                                                                                      |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| :newspaper: char                        | Char functions (E.g. Unicode conversion)                                                                                                                                             |
| :chocolate_bar: chocolatey              | [Chocolatey software manager](https://chocolatey.org/) functions                                                                                                                     |
| :speech_balloon: command                | Meta-command functions (E.g. *nix like `which`)                                                                                                                                      |
| :earth_africa: environment              | Environment variables management                                                                                                                                                     |
| :open_file_folder: filesystem           | Files and directories management (E.g. creation, find, metadata)                                                                                                                     |
| :notebook_with_decorative_cover: module | Powershell Modules management functions (E.g. remove all old versions)                                                                                                               |
| :surfer: navigation                     | Ease of life navigation between folders functions                                                                                                                                    |
| :satellite: network                     | Ip and Http Rest request functions                                                                                                                                                   |
| :factory: process                       | Process functions (E.g. *nix like `pgrep`, `ptop`)                                                                                                                                   |
| :space_invader: pwsh                    | [Powershell Profile](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.1) management functions (E.g. edit, reload) |
| :computer: system                       | General System functions (E.g. shutdown, reboot ecc ...)                                                                                                                             |
| :pushpin: wt                            | [Windows Terminal](https://github.com/microsoft/terminal) function to create an elevated shortcut                                                                                    |

## :tada: Installation


### With my Dotfiles

The complete use of this module alongside others is managed by my personal [Dotfile configuration](https://github.com/LeoCalbi/dotfiles) managed with [Chezmoi](https://www.chezmoi.io/)

### With git and Powershell Core

Execute:

```powershell
git clone https://github.com/LeoCalbi/myUtilities.git
$ModuleFolder = ($Env:PSModulePath | Split-String -Separator ";")[0]
Move-Item -Path myUtilities\MyUtilities -Destination $ModuleFolder
```

Then add to your Powershell Profile (Path at `$Profile`):

```powershell
Import-Module MyUtilities
```

## :bulb: Inspirations

* [Jay Harris Dotfiles](https://github.com/jayharris/dotfiles-windows)
* [René-Marc Dotfiles](https://github.com/renemarc/dotfiles)
* Other dotfiles and functions from the web.
