define Package/fff-default
	SECTION:=base
	CATEGORY:=Freifunk
	DEFAULT:=y
	TITLE:=Freifunk-Franken Base default switcher
	URL:=http://www.freifunk-franken.de
	DEPENDS:=+fff-node +fff-adsc +fff-wififix
endef

define Package/fff-default/description
	This package is used to switch on of the Freifunk Franken
	package on per default
endef

$(eval $(call BuildPackage,fff-default))
