/// @description 

if(place_meeting(x, y, oHead)) instance_destroy(); // Maybe add hitpoints.

if(x > room_width + buffer || x < -buffer)
{
	hsp = -hsp
}

image_xscale = sign(hsp)
x += hsp;






