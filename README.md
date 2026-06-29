
# 🛠️ Development Environment Setup (Linux Mint)

## Clone dotfile to new system

```bash
echo ".cfg" >> .gitignore
git clone --bare git@github.com:vietdang-2401/configs.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout <branch-name>
```

## Cài đặt

### 🖥️ Terminal

* ✅ Kitty
* ✅ Zsh
* ✅ Oh My Zsh
* ✅ zoxide
* ✅ zsh-autosuggestions
* ✅ fast-syntax-highlighting
* ✅ zsh-autocomplete
* ✅ xclip

### ✍️ Editor

* ✅ Neovim (build từ source, branch `stable`)

### 🌿 Git

* ✅ Git
* ✅ Delta (Git pager)
* ✅ LazyGit

### 🐳 Docker

* ✅ LazyDocker

### 🔍 Search / CLI Utilities

* ✅ ripgrep (`rg`)
* ✅ fd (`fd`)
* ✅ fzf

### 📦 Language Managers

* ✅ nvm (Node.js)
* ✅ SDKMAN! (Java, Maven, Gradle, Kotlin...)
* ✅ pyenv (Python)

### 🔨 Build Tools

* ✅ gcc
* ✅ g++
* ✅ make
* ✅ cmake
* ✅ ninja-build
* ✅ pkg-config
* ✅ autoconf
* ✅ automake
* ✅ libtool

### 🐍 Python Build Dependencies

* ✅ libssl-dev
* ✅ zlib1g-dev
* ✅ libbz2-dev
* ✅ libreadline-dev
* ✅ libsqlite3-dev
* ✅ libffi-dev
* ✅ liblzma-dev
* ✅ libncursesw5-dev
* ✅ tk-dev
* ✅ uuid-dev

### 🧰 Utilities

* ✅ curl
* ✅ wget
* ✅ unzip
* ✅ zip
* ✅ tar
* ✅ gzip
* ✅ xz-utils
* ✅ ca-certificates
* ✅ software-properties-common
* ✅ gnupg

---

## 🚀 Cài đặt

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/vietdang-2401/configs/pirago-desktop/install-dev.sh)
```

---

## ⚙️ Thiết lập sau khi cài

### Global `.gitignore`

```bash
git config --global core.excludesfile ~/.gitignore_global
```

### Hide untrack config files

```bash
config config status.showUntrackedFiles no
```

### Cài các runtime

Mở terminal mới rồi chạy:

```bash
nvm install --lts

sdk install java

pyenv install 3.13
pyenv global 3.13
```

Sau khi hoàn tất, bạn sẽ có:

* ✅ Node.js LTS
* ✅ npm
* ✅ Java (phiên bản được cài qua SDKMAN!)
* ✅ Python 3.13
