# Proton Get

![Proton GE Downloader](images/proton-get.png)

Gets the latest version, compares with the installed one(s) of [Proton GE](https://github.com/GloriousEggroll/proton-ge-custom), downloads it and extracts to $HOME/.local/share/Steam/compatibilitytools.d/. It requires __wget__ and __xidel__. [Xidel](https://github.com/benibela/xidel/) is to avoid messy, unpredictable regex inside a Bash script. To be less invasive it won't install Xidel. It is by default downloaded to a temporary folder to be used from there. Passing "1" as an argument for __setup.sh__, will install __xidel__ in $HOME/.local/bin.

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
If you wish to install xidel too, not just use it from the temporary directory add "1" as a parameter for setup.sh

```
❯ git clone https://gitlab.com/msmafra/proton-get
❯ cd proton-get
❯ ./setup.sh 1
```

## Usage
As setup.sh will install the proton-get into *$HOME/.local/bin* and make it executable. If it is in your user's **$PATH** variable, it will be executed from any place.
```
❯ proton-get
```
## PATH
Check if *$HOME/.local/bin* is in your path:
```
cat $HOME/.profile
```

This part indicates a conditional inclusion of *$HOME/.local/bin*. So as soon as the **setup.sh** creates it, the reopening of the terminal window or the usage of **source $HOME/.profile** will enable it.

```
...
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
...
```
