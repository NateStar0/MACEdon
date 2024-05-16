/// @description 

if(place_meeting(x, y, oPlayer))
{
	oPlayer.addFlail();
	instance_destroy();	
}

y = ystart + sin(current_time * pi * 0.0001) * 2
