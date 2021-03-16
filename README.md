# myUtilities

PowerShell Module that contains a collection of personal and gathered ease of life functions.

## :books: File Structure

The module manifest [MyUtilites.psd1](MyUtilities/1.0.0/MyUtilities.psd1) imports submodules divided by target
| **Submodule**                                                                 | **Description**                                                                                                                                                                      |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| :newspaper: [char.psd1](MyUtilities/1.0.0/char.psm1)                          | Char functions (E.g. Unicode conversion)                                                                                                                                             |
| :chocolate_bar: [chocolatey.psd1](MyUtilities/1.0.0/chocolatey.psm1)          | [Chocolatey software manager](https://chocolatey.org/) functions                                                                                                                     |
| :speech_balloon: [command.psd1](MyUtilities/1.0.0/command.psm1)               | Meta-command functions (E.g. *nix like `which`)                                                                                                                                      |
| :earth_africa: [environment.psd1](MyUtilities/1.0.0/environment.psm1)         | Environment variables management                                                                                                                                                     |
| :open_file_folder: [filesystem.psd1](MyUtilities/1.0.0/filesystem.psm1)       | Files and directories management ( E.g. creation, find, metadata )                                                                                                                   |
| :notebook_with_decorative_cover: [module.psd1](MyUtilities/1.0.0/module.psm1) | Powershell Modules management functions (E.g. remove all old versions)                                                                                                               |
| :surfer: [navigation.psd1](MyUtilities/1.0.0/navigation.psm1)                 | Ease of life navigation between folders functions                                                                                                                                    |
| :satellite: [network.psd1](MyUtilities/1.0.0/network.psm1)                    | Ip and Http Rest request functions                                                                                                                                                   |
| :factory: [process.psd1](MyUtilities/1.0.0/process.psm1)                      | Process functions (E.g. *nix like `pgrep`, `ptop`)                                                                                                                                   |
| :space_invader: [pwsh.psd1](MyUtilities/1.0.0/pwsh.psm1)                      | [Powershell Profile](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.1) management functions (E.g. edit, reload) |
| :computer: [system.psd1](MyUtilities/1.0.0/system.psm1)                       | General System functions (E.g. shutdown, reboot ecc ...)                                                                                                                             |
| :pushpin: [wt.psd1](MyUtilities/1.0.0/wt.psm1)                                | [Windows Terminal](https://github.com/microsoft/terminal) function to create an elevated shortcut                                                                                    |

## :tada: Installation


### With my Dotfiles

The complete use of this module alongside others is managed by my personal [Dotfile configuration](https://github.com/LeoCalbi/dotfiles) managed with [Chezmoi](https://www.chezmoi.io/)

### With git and Powershell Core

Execute:

```powershell
$ModuleFolder = ($Env:PSModulePath | Split-String -Separator ";")[0]
git clone https://github.com/LeoCalbi/myUtilities.git $ModuleFolder
```

Then add to your Powershell Profile (Path at `$Profile`):

```powershell
Import-Module MyUtilities
```

## :bulb: Inspirations

* [Jay Harris Dotfiles](https://github.com/jayharris/dotfiles-windows)
* [René-Marc Dotfiles](https://github.com/renemarc/dotfiles)
* Other dotfiles and functions from the web.
