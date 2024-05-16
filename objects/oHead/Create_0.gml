/// @description 

// Init

hsp = 0;
vsp = 0;

x = xstart;
y = ystart;

canJump = false;

depth = -999;

// Behaviour

run = function()
{
	if(global.isDependent)
	{
		// feather ignore GM1050 once
		var endNode = oVerlet.nodes[array_length(oVerlet.nodes) - 1].position;
		x = endNode[0];
		y = endNode[1]
		
		hsp = x - xprevious
	}
	else
	{
		var onGround = place_meeting(x, y+1, oCollision);
	
		hsp = clamp(hsp, -10, 10)
	
		if(!onGround) vsp += oPlayer.grav;
		
		move();
	}
}

