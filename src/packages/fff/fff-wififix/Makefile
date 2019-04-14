include $(TOPDIR)/rules.mk

PKG_NAME:=fff-wififix
PKG_RELEASE:=2

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:= Freifunk-Franken WiFiFix
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+fff-network fff-wireless
endef

define Package/$(PKG_NAME)/description
	This is a package to fix idle 2.4 GHz WiFi
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
