include $(TOPDIR)/rules.mk

PKG_NAME:=fff-radvd
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=base
    CATEGORY:=Freifunk
    TITLE:=Freifunk-Franken radvd
    URL:=http://www.freifunk-franken.de
    DEPENDS:=+radvd
endef

define Package/$(PKG_NAME)/description
    This is the fff-radvd for the Freifunk Franken Firmware
    It is used to configure radvd for use as gateway.
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
