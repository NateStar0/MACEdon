/// @description 

// Init

cam = view_camera[0];
view_enabled = true;

view_set_visible(0, true);
window_set_size(DISPLAY_WIDTH, DISPLAY_HEIGHT);
camera_set_view_size(cam, VIEW_WIDTH, VIEW_HEIGHT);

follow = oPlayer;

xTo = xstart;
yTo = ystart;

offsetX = 0;
offsetY = 0;

shakeMag = 0
shakeLength = 0
shakeRem = 0

run = function()
{
	window_set_caption(GAMENAME + " (" + string(fps_real) + "/" + string(fps) + ")")
	
	if(instance_exists(follow))
	{
		xTo = follow.x + offsetX
		yTo = follow.y + offsetY
	}
		
	x += ((xTo - x) / 6) + random_range(-shakeRem, shakeRem);
	y +=  ((yTo - y) / 6) + random_range(-shakeRem, shakeRem);
		
	shakeRem = max(0, shakeRem  - ((1 / shakeLength) * shakeMag));

	x = clamp(x, camera_get_view_width(cam) * 0.5, room_width - camera_get_view_width(cam) * 0.5)
	y = clamp(y, camera_get_view_height(cam) * 0.5, room_height - camera_get_view_height(cam) * 0.5)

	camera_set_view_pos(cam, x - camera_get_view_width(cam) * 0.5, y - camera_get_view_height(cam) * 0.5);
}
