include $(TOPDIR)/rules.mk

PKG_NAME:=fff-boardname
PKG_VERSION:=5
PKG_RELEASE:=12

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=base
	CATEGORY:=Freifunk
	TITLE:=Freifunk-Franken boardname
	URL:=http://www.freifunk-franken.de
endef

define Package/$(PKG_NAME)/description
	This is the Freifunk Franken Firmware boardname package.
	This packages configures the boardname in the board config.
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
	printf "\toption target '$(BOARD)'\n" >> $(1)/etc/config/board
	printf "\toption subtarget '$(SUBTARGET)'\n" >> $(1)/etc/config/board
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
