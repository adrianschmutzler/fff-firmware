include $(TOPDIR)/rules.mk

PKG_NAME:=fff-network
PKG_RELEASE:=12.15

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:= Freifunk-Franken network configuration
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+fff-boardname
endef

define Package/$(PKG_NAME)/description
	This package configures the network interfaces
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
