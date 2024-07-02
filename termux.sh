#!/data/data/com.termux/files/usr/bin/bash

termux-setup-storage

# 换清华源，提升下载速度
sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list

# 安装基本工具和开发环境
cd
pkg update -y
pkg upgrade -y
pkg install -y wget vim curl git tar tree zsh clang python nodejs git

# 设置下载连接
url="https://file.techxf.com/d/linux"
# url="https://raw.githubusercontent.com/hugo-on/termux/main"

# 定制常用按键
mkdir -p ~/.termux
curl $url/termux.properties > ~/.termux/termux.properties
# 下载自定义脚本文件
curl $url/.myrc > ~/.myrc
curl $url/.zshrc > ~/.zshrc

# 安装其他软件
pkg install openssh nginx php php-fpm -y

# 安装zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1
chsh -s zsh

# 设置新的软链接
rm -rf ~/storage
[ ! -e ~/sdcard ] && ln -s /sdcard ~/sdcard

echo "Complete!Please restart Termux App..."
exit

