# dotfiles

Workstation configuration, powered by [DotBot](https://github.com/anishathalye/dotbot).


## Setup

On a completely new system, the following should be installed manually:

  * [Homebrew](http://brew.sh/)

    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

  * [Oh My ZSH](https://ohmyz.sh/)

    ```shell
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

  * Python

    ```shell
    brew install pyenv
    pyenv install 3.12  # or latest
    pyenv global use 3.12
    ```

Thereafter, simply run the idempotent install script:

```shell
./install.sh
```
