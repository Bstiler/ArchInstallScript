# Arch Installation Script

##  TLDR
Just a simple set of scripts to install Arch Linux. You need to set some variables before proceeding, you can doit automatically using a `env-setup.sh` file. This file will be called inside the main script. The necessary vaialbes are:
 - `USERNAME`: The main user of the installation.
 - `ROOFS`: The device you want to use for your main system.
 - `HOMEFS`: The device you want to use for your home folder. Please use a different device for the home folder. Please, provide one that's already formatted.
 - `EFIFS`: The device to install the EFI stuff. Please, provide one that's already formatted.

If you have all of this, just run as root:
```bash
./install.sh
```