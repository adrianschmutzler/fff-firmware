include $(TOPDIR)/rules.mk

PKG_NAME:=fff
PKG_VERSION:=7
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/fff

include $(INCLUDE_DIR)/package.mk

define Package/fff-base
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:=Freifunk-Franken Base
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+iptables \
			 +ip6tables \
			 +micrond \
			 +odhcp6c \
			 +kmod-ifb \
			 +kmod-sched-connmark \
			 +fff-config \
			 +fff-network \
			 +fff-nodewatcher \
			 +!TARGET_ath79_tiny:fff-simple-tc \
			 +fff-support \
			 +fff-sysupgrade \
			 +fff-timeserver \
			 +fff-web-ui \
			 +fff-wireless
endef

define Package/fff-base/description
	This is the Freifunk Franken Firmware Base package
endef

$(eval $(call BuildPackage,fff-base))

include $(TOPDIR)/variant.mk
