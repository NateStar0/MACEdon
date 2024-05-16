/*
		--- AUTODEF ---
		
		* Defines servel globals, macros and enums
*/

/// Misc

game_set_speed(60, gamespeed_fps)

randomize();

/// Display

#macro GAMENAME "MACEdon"

window_set_caption(GAMENAME);

// Dimensions

#macro DISPLAY_WIDTH 960
#macro DISPLAY_HEIGHT 540

#macro VIEW_WIDTH 320 / 2
#macro VIEW_HEIGHT (180 / 2)

display_set_gui_size(VIEW_WIDTH, VIEW_HEIGHT);
surface_resize(application_surface, VIEW_WIDTH, VIEW_HEIGHT)

// Text

global.fMain = font_add_sprite_ext(sFont, " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^`_{|}~abcdefghijklmnopqrstuvwxyz", false, 0);
draw_set_font(global.fMain);

/// Audio

global.muted = false;

/// Misc

global.isDependent = false;

// Enums
