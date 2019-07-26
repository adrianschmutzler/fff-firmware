include $(TOPDIR)/rules.mk

PKG_NAME:=fff-web-hood
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:= Freifunk-Franken web server for hood file
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+uhttpd
endef

define Package/$(PKG_NAME)/description
	This is a tiny web server to serve the hoodfile for
	other nodes
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
