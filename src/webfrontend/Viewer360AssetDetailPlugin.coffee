class Viewer360AssetDetailPlugin extends AssetDetail

	getButtonLocaKey: (asset) ->
		version360 = @__get360Version(asset)
		if not version360
			return
		return "viewer-360.asset.detail.plugin.button"

	start: (asset, mouseWheelstart) ->
		super(asset, mouseWheelstart)
		version360 = @__get360Version(asset)
		if not version360?.url
			return

		url = Session.addToken(version360.url)

		panorama = new PANOLENS.ImagePanorama(url);
		viewer = new PANOLENS.Viewer
			container: @__container
			controlButtons: ['setting', 'video']
			cameraFov: 120
		viewer.add(panorama);

		return

	createMarkup: ->
		super()
		@__container = CUI.dom.div("viewer-360-asset-detail-plugin-container")
		CUI.dom.append(@outerDiv, @__container)
		return

	__get360Version: (asset) ->
		if not asset
			return
		for value in asset.values or []
			for _, _value of value.versions
				if _value.height * 2 == _value.width
					return _value
		return

ez5.session_ready =>
	AssetBrowser.plugins.registerPlugin(Viewer360AssetDetailPlugin)
