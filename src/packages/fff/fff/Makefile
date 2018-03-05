include $(TOPDIR)/rules.mk

PKG_NAME:=fff
PKG_VERSION:=0.0.2
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
             +odhcp6c \
             +micrond \
             +fff-config \
             +fff-nodewatcher \
             +fff-web \
             +fff-batman-adv \
             +fff-support \
             +fff-network \
             +fff-sysupgrade \
             +fff-wireless \
             +fff-timeserver \
             +simple-tc
endef

define Package/fff/base/description
    This is the Freifunk Franken Firmware Base package
endef

define Package/fff-node
    $(call Package/fff/base)
    TITLE+=(Home node)
    DEPENDS+=+fff-fastd \
             +fff-firewall \
             +fff-vpn-select \
             +fff-uradvd \
             +fff-hoods \
             +fff-adsc
    VARIANT:=homenode
endef

define Package/fff-node/description
    $(call Package/fff/base/description)
endef

define Package/fff-layer3
    $(call Package/fff/base)
    TITLE+=(Layer 3 Gateway)
    DEPENDS+=+fff-gateway \
             +fff-dhcp \
             +fff-odhcpd \
             +fff-babeld \
             +fff-openvpn \
             +arptables \
             +ebtables \
             +ebtables-utils \
             +kmod-ebtables-ipv4 \
             +kmod-ebtables-ipv6 \
             +iptables-mod-filter \
             +iptables-mod-ipopt \
             +iptables-mod-conntrack-extra \
             +kmod-ipt-nat \
             +gre \
             +@PACKAGE_grev4 \
             +@PACKAGE_grev6 \
             +fff-alfred-monitoring-proxy \
             +fff-gwinfo \
             +fff-batman-adv-server \
             +@FASTD_ENABLE_METHOD_NULL \
             +@FASTD_ENABLE_CIPHER_NULL \
             +@FASTD_WITH_STATUS_SOCKET \
             +fastd \
             +kmod-wireguard \
             +wireguard-tools \
             +iperf3 \
             +tcpdump \
             +fff-gw
    VARIANT:=layer3
endef

define Package/fff-layer3/description
    $(call Package/fff/base/description)
endef

$(eval $(call BuildPackage,fff-node))
$(eval $(call BuildPackage,fff-layer3))

include $(TOPDIR)/variant.mk
