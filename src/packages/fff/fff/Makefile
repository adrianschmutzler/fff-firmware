include $(TOPDIR)/rules.mk

PKG_NAME:=fff
PKG_VERSION:=0.0.2-5
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/fff

include $(INCLUDE_DIR)/package.mk

define Package/fff/base
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:=Freifunk-Franken Base
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+iptables \
			 +ip6tables \
			 +micrond \
			 +odhcp6c \
			 +kmod-ifb \
			 +kmod-ledtrig-heartbeat \
			 +kmod-ledtrig-netdev \
			 +kmod-nls-base \
			 +kmod-sched-connmark \
			 +tc \
			 +fff-config \
			 +fff-network \
			 +fff-nodewatcher \
			 +fff-support \
			 +fff-sysupgrade \
			 +fff-timeserver \
			 +fff-web \
			 +fff-wireless \
			 +simple-tc
endef

define Package/fff/base/description
	This is the Freifunk Franken Firmware Base package
endef

define Package/fff-node
	$(call Package/fff/base)
	TITLE+=(Home node)
	DEPENDS+=+fff-batman-adv \
			 +fff-fastd \
			 +fff-firewall \
			 +fff-hoods \
			 +fff-uradvd
	VARIANT:=homenode
endef

define Package/fff-node/description
	$(call Package/fff/base/description)
endef

define Package/fff-layer3
	$(call Package/fff/base)
	TITLE+=(Layer 3 Gateway)
	DEPENDS+=+arptables \
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
			 +kmod-wireguard \
			 +wireguard-tools \
			 +fff-alfred-monitoring-proxy \
			 +fff-babeld \
			 +fff-batman-adv-server \
			 +fff-dhcp \
			 +fff-gateway \
			 +fff-gwinfo \
			 +fff-ra
	VARIANT:=layer3
endef

define Package/fff-layer3/description
	$(call Package/fff/base/description)
endef

$(eval $(call BuildPackage,fff-node))
$(eval $(call BuildPackage,fff-layer3))

include $(TOPDIR)/variant.mk
