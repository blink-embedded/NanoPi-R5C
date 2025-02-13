#!/bin/bash

# mt7921
rm -rf package/kernel/rtl8821cu
rm -rf package/kernel/mac80211
rm -rf package/kernel/mt76
rm -rf package/network/services/hostapd

svn export https://github.com/openwrt/openwrt/trunk/package/kernel/mac80211 package/kernel/mac80211
svn export https://github.com/openwrt/openwrt/trunk/package/network/services/hostapd package/network/services/hostapd
cp -r ../package/kernel/mt76 ./package/kernel/mt76
rm package/kernel/mac80211/Makefile
cp -f ../package/kernel/mac80211/Makefile ./package/kernel/mac80211/Makefile
cp -f ../package/network/services/hostapd/patches/800-hostapd-2.10-lar.patch ./package/network/services/hostapd/patches/800-hostapd-2.10-lar.patch

# 重启概率卡死，暂时无解
#svn export https://github.com/coolsnowwolf/lede/trunk/package/kernel/mac80211 package/kernel/mac80211
#svn export https://github.com/coolsnowwolf/lede/trunk/package/kernel/mt76 package/kernel/mt76
#svn export https://github.com/coolsnowwolf/lede/trunk/package/network/services/hostapd package/network/services/hostapd

# alist
git clone https://github.com/DHDAXCW/luci-app-alist package/alist
rm -rf feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang

# speedtest
git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
 
# Clone community packages
mkdir package/community
pushd package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package
rm -rf openwrt-package/verysync
rm -rf openwrt-package/luci-app-verysync

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall2
svn export https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall

# Add luci-app-ssr-plus
git clone --depth=1 https://github.com/fw876/helloworld

# Add luci-app-unblockneteasemusic
git clone --branch master https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git

# Add luci-app-vssr <M>
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add luci-proto-minieap
git clone --depth=1 https://github.com/ysc3839/luci-proto-minieap

# Add OpenClash
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add luci-app-dockerman
rm -rf ../../customfeeds/luci/collections/luci-lib-docker
rm -rf ../../customfeeds/luci/applications/luci-app-docker
rm -rf ../../customfeeds/luci/applications/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-theme
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth=1 https://github.com/gngpp/luci-theme-design
git clone --depth=1 https://github.com/gngpp/luci-theme-atmaterial

# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add luci-app-smartdns & smartdns
svn export https://github.com/281677160/openwrt-package/trunk/luci-app-smartdns

# Add luci-app-services-wolplus
svn export https://github.com/msylgj/OpenWrt_luci-app/trunk/luci-app-services-wolplus

# Add luci-app-autotimeset
git clone --depth=1 https://github.com/sirpdboy/luci-app-autotimeset

# Add apk (Apk Packages Manager)
svn export https://github.com/openwrt/packages/trunk/utils/apk

# Add luci-app-poweroff
git clone --depth=1 https://github.com/esirplayground/luci-app-poweroff

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter

# Add luci-aliyundrive-webdav
rm -rf ../../customfeeds/luci/applications/luci-app-aliyundrive-webdav 
rm -rf ../../customfeeds/packages/multimedia/aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav
svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav
popd

# Add Pandownload
pushd package/lean
svn export https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server
popd

# Change default shell to zsh
sed -i 's/\/bin\/ash/\/usr\/bin\/zsh/g' package/base-files/files/etc/passwd

# Modify default IP
sed -i 's/192.168.1.1/10.0.2.1/g' package/base-files/files/bin/config_generate
rm ./target/linux/rockchip/modules.mk
cp ../target/linux/rockchip/modules.mk ./target/linux/rockchip/modules.mk

sed -i 's/5.4/6.1/g' ./target/linux/rockchip/Makefile
rm -rf target/linux/rockchip/image/armv8.mk
cp -f ../target/linux/rockchip/image/armv8.mk ./target/linux/rockchip/image/armv8.mk

rm ./package/kernel/linux/modules/video.mk
cp ../package/kernel/linux/modules/video.mk ./package/kernel/linux/modules/video.mk

# kernel-6.1 h264 h265 vp9
cp -r ../target/linux/rockchip/patches-6.1/ ./target/linux/rockchip/patches-6.1/