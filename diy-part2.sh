#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds 更新feeds后运行part2.sh)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

# 添加主题&调用diy目录下的文件，包括zzz-default-settings文件
#cd openwrt
git clone https://github.com/jerrykuku/luci-theme-argon -b 19.07_stable ./package/feeds/luci/themes
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git ./package/feeds/luci/themes
git clone https://github.com/rosywrt/luci-theme-rosy.git ./package/feeds/luci/themes
git clone https://github.com/apollo-ng/luci-theme-darkmatter.git ./package/luci-theme-darkmatter
./scripts/feeds update -a
./scripts/feeds install -a

# 调用diy目录下的文件，包括zzz-default-settings文件
#cd openwrt
cp -Rf ../diy/* ./
cp -f default-settings package/*/*/default-settings/files/zzz-default-settings
if [ -n "$(ls -A "patches" 2>/dev/null)" ]; then
   find "patches" -type f -name '*.patch'| xargs -i git apply {}
fi

