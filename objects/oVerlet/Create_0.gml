/// @description 

// Init

x = oPlayer.ropeX;
y = oPlayer.ropeY;

depth = -998;

squaredSize = function(v)
{
	return v[0]*v[0] + v[1]*v[1];
}
	
sub = function(v, w)
{
	return [v[0] - w[0], v[1] - w[1]];
}
	
add = function(v, w)
{
	return [v[0] + w[0], v[1] + w[1]];
}

mul = function(v, k)
{ 
	return [v[0]*k, v[1]*k];
}

squaredDistance = function(a, b)
{ 
	return squaredSize(sub(a, b));
}

dot = function(v, w)
{
	return v[0]*w[0] + v[1]*w[1];
}

function closestPointOnSegment(a, b, p) {
    var ap = sub(p, a);
    var ab = sub(b, a);
    return add(a, mul(ab, clamp(dot(ap, ab) / squaredSize(ab), 0, 1)));
}

function closestPointOnPolygon(polygon, point)
{
	var points = [];
	var totalPoints = array_length(polygon);
	for(var i = 0; i < totalPoints; i++)
	{
		points[i] = closestPointOnSegment(polygon[i], polygon[(i + 1)%totalPoints], point)
	}
	
	var distances = [];
	var minimumIndex = 0;
	for(var i = 0; i < totalPoints; i++)
	{
		distances[i] = squaredDistance(point, points[i]);	
		
		if(distances[i] < distances[minimumIndex]) minimumIndex = i;
	}
	
	return points[minimumIndex];
}

stepTime = 0.01;
grav = [0, 0.3];
oldPosition = [x, y];

verletNode = function(position=[0,0]) constructor
{
	self.position = position;
	self.oldPosition = position;
	
	grav = [0, 0];
	stepTime = 1;
	fric = 0.95;
	
	static stepVerlet = function()
	{
		var temp = [position[0], position[1]];
		position[0] += (position[0] - oldPosition[0]) + grav[0] * stepTime * stepTime * fric;
		position[1] += (position[1] - oldPosition[1]) + grav[1] * stepTime * stepTime * fric;
		oldPosition = temp;
	}
}

touchInfo = function(index, position=[0,0], dimensions=[0,0], touchedNodes=[], scalar=[1,1]) constructor
{
	self.index = index;
	self.dimensions = dimensions;
	self.scalar = scalar;
	self.position = position;
	numberOfCollisions = 1;
	self.touchedNodes = touchedNodes;
	
	polygon = [
		[position[0], position[1]],
		[position[0] + dimensions[0], position[1]],
		[position[0] + dimensions[0], position[1] + dimensions[1]],
		[position[0], position[1] + dimensions[1]]
	]
	
	updatePosition = function(position=[0,0], dimensions=[0,0])
	{
		self.position = position;
		
		polygon = [
			[position[0], position[1]],
			[position[0] + dimensions[0], position[1]],
			[position[0] + dimensions[0], position[1] + dimensions[1]],
			[position[0], position[1] + dimensions[1]]
		]
	}
}

loops = 50;
nodeDistance = 3;

nodes = [];
length = 18;
position = [x, y];

maxTouches = 32;
touchRadius = 3;
touchesPerNode = 8;
currentTouches = 0;

touchInfoArr = []


for(var i = 0; i < length; i++)
{
	nodes[i] = new verletNode([x + i * nodeDistance, y]);
	nodes[i].grav = grav;
}

constrain = function()
{
	if(!global.isDependent)
	{
		nodes[length-1].position = [oHead.x, oHead.y]
	}
		
	for(var i = 0; i < length - 1; i++)
	{		
		if(i == 0)
		{
			nodes[i].position = [oPlayer.ropeX, oPlayer.ropeY];	
		}
		
		var dX = nodes[i].position[0] - nodes[i + 1].position[0] 
		var dY = nodes[i].position[1] - nodes[i + 1].position[1] 
		var dist = point_distance(nodes[i].position[0], nodes[i].position[1], nodes[i + 1].position[0], nodes[i + 1].position[1])
		var difference = (dist > 0) ? ((nodeDistance - dist) / dist): 0;
		
		var translate = [dX * 0.5 * difference, dY * 0.5 * difference];
		
		nodes[i].position[0] += translate[0];
		nodes[i].position[1] += translate[1];
		nodes[i + 1].position[0] -= translate[0];
		nodes[i + 1].position[1] -= translate[1];
		
	}
}

colliders = [];

colours = array_create(length, c_white)

getCollisions = function()
{
	currentTouches = 0;
	touchInfoArr = [];
	colliders = [];
	
	with(oCollision)
	{
		if(isEnabled)
		{
			array_push(other.colliders, id)	
		}
	}
	
	for(var i = 0; i < length; i++)
	{
		var node = nodes[i];
		var collisions = 0;
		
		for(var j = 0; j < array_length(colliders); j++)
		{
			var ind = -1;
			var oth = colliders[j];
			var img = oth.sprite_index;
			img = (img == -1) ? sWall : img;
			var position = [oth.x, oth.y]
			var dimension = [abs(oth.image_xscale) * sprite_get_width(img), abs(oth.image_yscale * sprite_get_height(img))]
			var half = [dimension[0] / 2, dimension[1] / 2];
			
			if(!point_in_rectangle(node.position[0], node.position[1],
											position[0], position[1], position[0] + dimension[0], position[1] + dimension[1]))
			{
				continue;
			}
			
			for(var k = 0; k < currentTouches; k++)
			{
				if(oth == touchInfoArr[k].index)
				{
					ind	= k;
				}
			}
			
			if(ind == -1)
			{
				array_push(touchInfoArr, new touchInfo(oth, position, dimension, [i], [abs(oth.image_xscale), abs(image_yscale)]))
				currentTouches++;
			}
			else
			{
				// Update the node;	
				touchInfoArr[ind].numberOfCollisions++;
				
				// feather ignore GM1041 once
				array_push(touchInfoArr[ind].touchedNodes, i);
				
				touchInfoArr[ind].updatePosition(position, dimension);
			}
		}
	}
}

collide = function()
{	
	for(var i = 0; i < currentTouches; i++)
	{
		var collision = touchInfoArr[i];
		
		for(var j = 0; j < collision.numberOfCollisions; j++)
		{
			var node = nodes[collision.touchedNodes[j]];
			
			if(point_in_rectangle(node.position[0], node.position[1], collision.position[0], collision.position[1], collision.position[0] + collision.dimensions[0], collision.position[1] + collision.dimensions[1]))
			{
				var out = closestPointOnPolygon(collision.polygon, node.position);
				var dist = sub(out, node.position);
				nodes[collision.touchedNodes[j]].position = out//[out[0] + lengthdir_x(0, ang), out[1] + lengthdir_y(0, ang)]			
			}
		}
	}
	
}

// Behaviour

run = function()
{
	getCollisions();
	
	for(var i = 0; i < length; i++)
	{
		nodes[i].stepVerlet();
	}
	
	for(var i = 0; i < loops; i++)
	{
		constrain();
		
		if(i % (loops / 5) == 0)
		{
			collide();	
		}
	}
	
}

draw = function()
{
	var dX = -sprite_width / 2;
	var dY = -sprite_height / 2;
	
	for(var i = 0; i < array_length(nodes); i++)
	{
		draw_sprite(sprite_index, 0, nodes[i].position[0] + dX, nodes[i].position[1] + dY);	
	}
}
