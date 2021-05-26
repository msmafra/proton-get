# Proton Get

![Proton GE Downloader](proton-get.png)

Gets the latest version, compares with the installed one(s) of [Proton GE](https://github.com/GloriousEggroll/proton-ge-custom), downloads it and extracts to $HOME/.local/share/Steam/compatibilitytools.d/.

It uses [Xidel](https://github.com/benibela/xidel/) which is downloaded to a temporary folder and run from it if xidel is not installed. To be less invasive it won't install xidel.

- https://github.com/GloriousEggroll/proton-ge-custom
- https://github.com/benibela/xidel/

## Install
To install it. Clone, get into its folder and run ./setup.sh.:

```
❯ git clone https://gitlab.com/msmafra/proton-get
❯ cd proton-get
❯ ./setup.sh
```
## Also install Xidel
If you wish to install xidel too, not just use it from the temporary directory add 1 as a parameter for setup.sh

```
❯ git clone https://gitlab.com/msmafra/proton-get
❯ cd proton-get
❯ ./setup.sh 1
```

## Usage
As setup.sh will install the proton-get into ~/.local/bin and make it executable, it will be in your user $PATH, so can be executed from any place.
```
❯ proton-get
```
