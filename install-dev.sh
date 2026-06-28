#!/usr/bin/env bash
set -e

echo "==> Updating system..."
sudo apt update

echo "==> Installing base packages..."
sudo apt install -y \
    git \
    curl \
    wget \
    unzip \
    zip \
    tar \
    gzip \
    xz-utils \
    build-essential \
    software-properties-common \
    ca-certificates \
    gnupg \
    ripgrep \
    fd-find \
    fzf \
    zsh \
    ninja-build \
    gettext \
    cmake \
    pkg-config \
    libtool \
    autoconf \
    automake \
    g++ \
    gcc \
    make \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    tk-dev \
    uuid-dev

#####################################################
# fd alias
#####################################################
if ! command -v fd >/dev/null 2>&1; then
    sudo ln -sf /usr/bin/fdfind /usr/local/bin/fd
fi

#####################################################
# kitty
#####################################################
if ! command -v kitty >/dev/null 2>&1; then
    echo "==> Installing kitty..."
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    mkdir -p "$HOME/.local/bin"
    ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/kitty"
    ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/kitten"

    mkdir -p "$HOME/.local/share/applications"
    cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
    cp "$HOME/.local/kitty.app/share/applications/kitty-open.desktop" "$HOME/.local/share/applications/"

    sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$HOME"/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=$HOME/.local/bin/kitty|g" "$HOME"/.local/share/applications/kitty*.desktop

    update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true
fi

mkdir -p "$HOME/.config/kitty"

if [ ! -f "$HOME/.config/kitty/kitty.conf" ]; then
    cat > "$HOME/.config/kitty/kitty.conf" <<'EOF'
confirm_os_window_close 0
enable_audio_bell no
shell zsh
EOF
fi

#####################################################
# neovim build from source
#####################################################
if ! command -v nvim >/dev/null 2>&1; then
    echo "==> Building Neovim from source..."

    TMP=$(mktemp -d)
    git clone https://github.com/neovim/neovim "$TMP/neovim"

    cd "$TMP/neovim"

    git checkout stable

    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install

    cd "$HOME"
    rm -rf "$TMP"
fi

#####################################################
# delta
#####################################################
if ! command -v delta >/dev/null 2>&1; then
    echo "==> Installing delta..."

    TMP=$(mktemp -d)
    cd "$TMP"

    FILE=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest \
        | grep browser_download_url \
        | grep x86_64-unknown-linux-gnu.tar.gz \
        | cut -d '"' -f4 \
        | head -n 1)

    wget "$FILE" -O delta.tar.gz
    tar xf delta.tar.gz
    sudo mv */delta /usr/local/bin/

    cd "$HOME"
    rm -rf "$TMP"
fi

#####################################################
# lazygit
#####################################################
if ! command -v lazygit >/dev/null 2>&1; then
    echo "==> Installing lazygit..."

    TMP=$(mktemp -d)
    cd "$TMP"

    VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
        | grep tag_name \
        | cut -d '"' -f4 \
        | sed 's/v//')

    curl -Lo lazygit.tar.gz \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${VERSION}_Linux_x86_64.tar.gz"

    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin

    cd "$HOME"
    rm -rf "$TMP"
fi

#####################################################
# lazydocker
#####################################################
if ! command -v lazydocker >/dev/null 2>&1; then
    echo "==> Installing lazydocker..."

    TMP=$(mktemp -d)
    cd "$TMP"

    VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazydocker/releases/latest \
        | grep tag_name \
        | cut -d '"' -f4 \
        | sed 's/v//')

    curl -Lo lazydocker.tar.gz \
        "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${VERSION}_Linux_x86_64.tar.gz"

    tar xf lazydocker.tar.gz lazydocker
    sudo install lazydocker /usr/local/bin

    cd "$HOME"
    rm -rf "$TMP"
fi

#####################################################
# nvm
#####################################################
if [ ! -d "$HOME/.nvm" ]; then
    echo "==> Installing nvm..."
    curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
fi

#####################################################
# sdkman
#####################################################
if [ ! -d "$HOME/.sdkman" ]; then
    echo "==> Installing SDKMAN..."
    curl -fsSL https://get.sdkman.io | bash
fi

#####################################################
# pyenv
#####################################################
if [ ! -d "$HOME/.pyenv" ]; then
    echo "==> Installing pyenv..."
    curl https://pyenv.run | bash
fi

#####################################################
# oh-my-zsh
#####################################################
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "==> Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#####################################################
# zsh default shell
#####################################################
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "==> Changing default shell to zsh..."
    chsh -s "$(command -v zsh)"
fi

#####################################################
# zsh config
#####################################################
touch "$HOME/.zshrc"

grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" || cat <<'EOF' >> "$HOME/.zshrc"

# Local bin
export PATH="$HOME/.local/bin:$PATH"
EOF

grep -q 'NVM_DIR' "$HOME/.zshrc" || cat <<'EOF' >> "$HOME/.zshrc"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
EOF

grep -q 'sdkman-init.sh' "$HOME/.zshrc" || cat <<'EOF' >> "$HOME/.zshrc"

# SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
EOF

grep -q 'PYENV_ROOT' "$HOME/.zshrc" || cat <<'EOF' >> "$HOME/.zshrc"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

#####################################################
# git delta config
#####################################################
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global merge.conflictstyle zdiff3
git config --global diff.colorMoved default

echo
echo "======================================="
echo "Done!"
echo
echo "Restart terminal, then run:"
echo
echo "nvm install --lts"
echo "sdk install java"
echo "pyenv install 3.13"
echo "pyenv global 3.13"
echo
echo "Check versions:"
echo "nvim --version"
echo "kitty --version"
echo "lazygit --version"
echo "lazydocker --version"
echo "delta --version"
echo "rg --version"
echo "fd --version"
echo "fzf --version"
echo
echo "======================================="
