/// @description 

if(place_meeting(x, y, oHead)) instance_destroy(); // Maybe add hitpoints.

if(x > room_width + buffer || x < -buffer)
{
	hsp = -hsp
}

image_xscale = sign(hsp)
x += hsp;

timer = max(timer - 1, 0)

if(!timer)
{
	offset = !offset;
	timer = timerReset;	
}

y = ystart + offset * 2;
