include $(TOPDIR)/rules.mk

PKG_NAME:=fff-dhcp
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=base
    CATEGORY:=Freifunk
    TITLE:=Freifunk-Franken dhcp
    URL:=http://www.freifunk-franken.de
    DEPENDS:=+dnsmasq
endef

define Package/$(PKG_NAME)/description
    This is the fff-dhcp for the Freifunk Franken Firmware
    It is used to configure dnsmasq for use as gateway.
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

define Package/$(PKG_NAME)/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
