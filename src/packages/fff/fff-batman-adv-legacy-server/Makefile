include $(TOPDIR)/rules.mk

PKG_NAME:=fff-batman-adv-legacy-server
PKG_VERSION:=1
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
    SECTION:=base
    CATEGORY:=Freifunk
    TITLE:=Freifunk-Franken batman-adv-legacy-server
    URL:=http://www.freifunk-franken.de
    DEPENDS:=+fff-batman-adv-legacy
endef

define Package/$(PKG_NAME)/description
    This is the batman-adv-legacy-server for the Freifunk Franken Firmware
    It is used to re-configure batman-adv-legacy package as used in a server.
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
