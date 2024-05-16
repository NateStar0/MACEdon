/// @description 

with(all)
{
	hasControl = false;	
	isActive = false;
}

oPlayer.hasControl = true;

if(instance_exists(oHead))
{
	with(all)
	{
		hasControl = true;	
		isActive = true;
	}

	instance_destroy();	
}




