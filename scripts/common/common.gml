/*
		A number of common scripts for this game
		- Nahoo
*/

/// Seconds

/// @desc returns the number of frames which pass in n number of seconds
/// @param {Real} n
/// @returns {Real}

function seconds(n)
{
	return game_get_speed(gamespeed_fps) * n;	
}

/// Log

/// @desc logs all arguments to the console

function log() 
{
	var str = "";
	
	for(var i = 0; i < argument_count; i++)
	{
		str += string(argument[i]) + " ";
	}
	
	show_debug_message(str);
}

/// Approach

/// @desc
/// @param {Real} speed
/// @param {Real} max_speed
/// @param {Real} acceleration
/// @returns {Real}

function Approach(speed, max_speed, acceleration)
{
    if (speed < max_speed) {
        speed += acceleration;
        if (speed > max_speed) {
            return max_speed;
        }
    } else {
        speed -= acceleration;
    
        if (speed < max_speed) {
            return max_speed;
        }
    }
    
    return speed;
}

function move()
{
	if(place_meeting(x + hsp, y, oCollision))
	{
		while(abs(hsp) > 0.1)
		{
			hsp *= 0.5;
			if(!place_meeting(x + hsp, y, oCollision)) x += hsp
		}
		
		hsp = 0;
	}
	
	x += hsp;
	
	if(place_meeting(x, y + vsp, oCollision))
	{
		while(!place_meeting(x, y + sign(vsp), oCollision))
		{
			y += sign(vsp);	
		}
		
		vsp = 0;
	}
	
	y += vsp;
}

function chance(n)
{
	return irandom(100) < n;	
}
