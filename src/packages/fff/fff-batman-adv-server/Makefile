include $(TOPDIR)/rules.mk

PKG_NAME:=fff-batman-adv-server
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:=Freifunk-Franken batman-adv-server
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+kmod-batman-adv \
			 +@BATMAN_ADV_BATMAN_V \
			 +@BATMAN_ADV_NC \
			 +batctl
endef

define Package/$(PKG_NAME)/description
	This is the batman-adv-server for the Freifunk Franken Firmware
	It is used to configure batman-adv package as used in a server.
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
