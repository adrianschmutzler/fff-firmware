include $(TOPDIR)/rules.mk

PKG_NAME:=fff-gateway
PKG_VERSION:=4
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/fff-gateway

include $(INCLUDE_DIR)/package.mk

define Package/fff-gateway
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:=Freifunk-Franken gateway configuration
	URL:=https://www.freifunk-franken.de
	DEPENDS:=+arptables \
	         +ebtables \
	         +ebtables-utils \
	         +kmod-ebtables-ipv4 \
	         +kmod-ebtables-ipv6 \
	         +gre \
	         +@PACKAGE_grev4 \
	         +@PACKAGE_grev6 \
	         +iperf3 \
	         +iptables-mod-filter \
	         +iptables-mod-ipopt \
	         +iptables-mod-conntrack-extra \
	         +tcpdump \
	         +fff-alfred-monitoring-proxy \
	         +fff-babeld \
	         +fff-batman-adv-server \
	         +fff-dhcp \
	         +fff-gwinfo \
	         +fff-network \
	         +fff-macnock \
	         +fff-fixmtu \
	         +fff-ra \
	         +fff-web-hood \
	         +fff-wireguard
endef

define Package/fff-gateway/description
	This package configures the gateway
endef

define Build/Prepare
	echo "all: " > $(PKG_BUILD_DIR)/Makefile
endef

define Build/Configure
	# nothing
endef

define Build/Compile
	# nothing
endef

define Package/fff-gateway/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,fff-gateway))
