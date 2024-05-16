/// @description 

if(!instance_exists(oEnemy) && !isActive && !instance_exists(oMenu))
{
	nextWave();	
}
	

if(!isActive) exit;

waveTimer = max(0, waveTimer - 1);

if(!waveTimer)
{
	if(array_length(currentWave) > 0)
	{
		var enemy = array_shift(currentWave);
		var enemyObject = oPacer;
	
		for(var i = 0; i < array_length(enemyMap); i++)
		{
			if(enemy == enemyMap[i].prime)
			{
				enemyObject = enemyMap[i].object;	
				i = array_length(enemyMap);
			}
		}
	
		if(enemyObject != oFlock)
		{
			if(choose(0, 1))
			{
				// Left	
				instance_create_layer(-24, 24, layer, enemyObject);
			}
			else
			{
				// Right	
				instance_create_layer(room_width + 24, 24, layer, enemyObject);
			}
		}
		else
		{
			if(choose(0, 1))
			{
				// Left	
				instance_create_layer(-24, 24, layer, oSeagull);
				instance_create_layer(-24, 36, layer, oSeagull);
				instance_create_layer(-24, 48, layer, oSeagull);
			}
			else
			{
				// Right	
				instance_create_layer(room_width + 24, 24, layer, oSeagull);
				instance_create_layer(room_width + 24, 36, layer, oSeagull);
				instance_create_layer(room_width + 24, 48, layer, oSeagull);
			}
		}
	}
	else
	{
		isActive = false;	
	}
	waveTimer = waveTimerReset;
}

log(instance_number(oEnemy), global.wave, isActive, currentWave, hiddenWave(global.wave), global.wave)
