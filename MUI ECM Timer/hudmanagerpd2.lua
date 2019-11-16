

	HUDECMCounter = HUDECMCounter or class()

	function HUDECMCounter:init(hud)
		self._hud_panel = hud.panel
			self._panel = self._hud_panel:panel({
			name = "ecm_counter_panel",
			visible = false,
			w = 200,
			h = 200,
			x = self._hud_panel:w() - 200,
			y = 10,
		})
			
		local box = HUDBGBox_create(self._panel, { w = 28, h = 28, },  {})
		
		self._text = box:text({
			name = "text",
			text = "0",
			valign = "center",
			align = "center",
			vertical = "center",
			w = box:w(),
			h = box:h(),
			layer = 1,
			color = Color.white,
			font = tweak_data.menu.pd2_large_font,
			font_size = 18
		})
		
		local ecm_icon = self._panel:bitmap({
			name = "ecm_icon",
			texture = "guis/textures/pd2/skilltree/icons_atlas",
			texture_rect = { 1 * 64, 4 * 64, 64, 64 },
			valign = "center",
			align = "center",
			layer = 1,
			h = box:w(),
			w = box:h()
		})
		ecm_icon:set_right(self._panel:w())
		ecm_icon:set_center_y(box:h() / 2)
		box:set_right(ecm_icon:left())
	end
	
    function HUDECMCounter:update(t)
		    self._panel:set_visible(managers.groupai:state():whisper_mode() and t > 0)	
		    if t > 0 then
			    self._text:set_text(string.format("%.fs", t))
				self._text:set_color(Color(1, 1, 1))
	        end

    end
 
	local _setup_player_info_hud_pd2_original = HUDManager._setup_player_info_hud_pd2
 
	function HUDManager:_setup_player_info_hud_pd2(...)
		_setup_player_info_hud_pd2_original(self, ...)
		self._hud_ecm_counter = HUDECMCounter:new(managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2))
	end
	
	function HUDManager:update_ecm(t)
		self._hud_ecm_counter:update(t)
	end
		
	local orig = HUDBGBox_create
	
    function HUDBGBox_create(panel, params, config)
	    config = config or {}
	    config.color = Color.white:with_alpha(0)
	    config.bg_color = Color.white:with_alpha(0)				
	    local box_panel = orig(panel, params, config) return box_panel
    end