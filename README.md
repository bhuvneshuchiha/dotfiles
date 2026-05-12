# Eh i like tmux 3.5a... you wont understand fuck off

# 1. Remove the source-installed tmux 3.1 binary
sudo rm /usr/local/bin/tmux

# 2. Install dependencies
brew install libevent ncurses utf8proc

# 3. Download and extract tmux 3.5a source
curl -LO https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz
tar -xzf tmux-3.5a.tar.gz
cd tmux-3.5a

# 4. Set PKG_CONFIG_PATH for utf8proc
export PKG_CONFIG_PATH="$(brew --prefix utf8proc)/lib/pkgconfig:$PKG_CONFIG_PATH"

# 5. Configure with Homebrew libs and utf8proc enabled
./configure CFLAGS="-I$(brew --prefix libevent)/include -I$(brew --prefix ncurses)/include -I$(brew --prefix utf8proc)/include" \
            LDFLAGS="-L$(brew --prefix libevent)/lib -L$(brew --prefix ncurses)/lib -L$(brew --prefix utf8proc)/lib" \
            --enable-utf8proc

# 6. Build and install
make
sudo make install

# 7. Verify
tmux -V  # tmux 3.5a
