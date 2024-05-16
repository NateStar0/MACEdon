/// @description 

if(place_meeting(x, y, oHead)) instance_destroy(); // Maybe add hitpoints.

if(x > room_width + buffer || x < -buffer)
{
	hsp = -hsp
}

image_xscale = sign(hsp)
x += hsp;

if(place_meeting(x, y + 1, oFloor)) vsp = -4;

vsp += oPlayer.grav;

if(place_meeting(x, y + vsp, oFloor))
{
	while(!place_meeting(x, y + sign(vsp), oFloor))
	{
		y += sign(vsp)	
	}
	
	vsp = 0;
}

y += vsp;


