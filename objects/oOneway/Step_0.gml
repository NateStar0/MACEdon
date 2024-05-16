/// @description 

if(instance_exists(oPlayer))
{
	if(round(oPlayer.y + (oPlayer.sprite_height / 2)) > y) || keyboard_check(ord("S"))
	{
		mask_index = -1;	
	}
	else
	{
		mask_index = sWall;	
	}
}






