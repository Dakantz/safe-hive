#!/bin/bash
mkdir $HOME/bin
# CHROME_DRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`
# echo "Downloading ChromeDriver version $CHROME_DRIVER_VERSION"
# echo "$HOME is the home directory"
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
echo "Platform: $PLATFORM"
# curl -O https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip
# unzip chromedriver_linux64.zip
# chmod +x chromedriver
GECKO_VERSION=0.37.1
curl -L -O https://github.com/mozilla/geckodriver/releases/download/v$GECKO_VERSION/geckodriver-v$GECKO_VERSION-linux-aarch64.tar.gz
tar xv -f geckodriver-v$GECKO_VERSION-linux-aarch64.tar.gz -C $HOME/bin
curl -fsSL https://bun.com/install | bash
curl -LsSf https://astral.sh/uv/install.sh | sh


# add to bashrc or zshrc:
for binpath in "$HOME/.bun/bin" "$HOME/.uv/bin" "$HOME/bin" "$HOME/.local/bin"; do
    if ! grep -q "$binpath" ~/.bashrc; then
        echo "export PATH=\"$binpath:\$PATH\"" >> ~/.bashrc
    fi
    if ! grep -q "$binpath" ~/.zshrc; then
        echo "export PATH=\"$binpath:\$PATH\"" >> ~/.zshrc
    fi
done