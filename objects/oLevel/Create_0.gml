/// @description 

global.wave = 0;

hiddenWave = function(n)
{
	return 
}

getPrimes = function(n)
{
	var factors = [1];
	var divisor = 2;
	
	while(n >= 2)
	{
		if(n % divisor == 0)
		{
			array_push(factors, divisor);
			n /= divisor;
		}
		else
		{
			divisor++;	
		}
	}
	
	return factors
}

isActive = true;
waveTimer = seconds(2);
waveTimerReset = waveTimer;

currentWave = [];

enemyMap = 
[
	{ prime : 1, object : oPacer },
	{ prime : 2, object : oSeagull },
	{ prime : 3, object : oJumpy },
	{ prime : 5, object : oFlock }
]

nextWave = function()
{
	global.wave++;
	currentWave = getPrimes((power(global.wave, 2) - 1) + ((global.wave < 5) ? 0 : choose(-1, 0, 1)));
	isActive = true;
}

