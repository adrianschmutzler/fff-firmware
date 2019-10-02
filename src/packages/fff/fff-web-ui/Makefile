include $(TOPDIR)/rules.mk

PKG_NAME:=fff-web-ui
PKG_VERSION:=8
PKG_RELEASE:=4

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:= Freifunk-Franken Webinterface
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+@BUSYBOX_CONFIG_WGET \
	         +@BUSYBOX_CONFIG_FEATURE_WGET_TIMEOUT \
	         +haserl \
	         +libustream-mbedtls \
	         +px5g \
	         +fff-boardname \
	         +fff-config \
	         +fff-network \
	         +fff-hoodutils \
	         +fff-simple-tc \
	         +fff-web-hood
endef

define Package/$(PKG_NAME)/description
	This is the web-based user interface for the Freifunk Franken Firmware
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
ifeq ($(CONFIG_PACKAGE_fff-nodewatcher),y)
	ln -s ../../tmp/crawldata/node.data $(1)/www/public/node.data
endif
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
