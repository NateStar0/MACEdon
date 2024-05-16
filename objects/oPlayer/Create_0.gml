/// @description 

// Init

hasControl = true;

hsp = 0;
vsp = 0;

grav = 0.2;
jumpspd = -3;
movespd = 1.5;
vspMax = 10;

image_speed = 0;
image_xscale = 1;

// Flail

rodLength = sprite_get_width(sRod) - 3;
chainLength = 84;

rodAngle = 0;

ropeX = x + lengthdir_x(rodLength, rodAngle);
ropeY = y + lengthdir_y(rodLength, rodAngle);

hasFlail = false;
head = noone;
verlet = noone;

addFlail = function()
{
	hasFlail = true;
	verlet = instance_create_depth(x, y, depth, oVerlet);
	head = instance_create_depth(x + 1.2 * sprite_get_width(sHead), y, depth, oHead);
}

// Behaviour

run = function()
{
	if(!hasControl) return;
	
	var onGround = place_meeting(x, y + 1, oCollision)
	var moveX = keyboard_check(ord("D")) - keyboard_check(ord("A"));
	var moveY = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space) || mouse_check_button_pressed(mb_right);
	var isClicking = mouse_check_button(mb_left);
	
	y = floor(y)
	
	global.isDependent = !isClicking;
	
	hsp = moveX * movespd;
	
	if(!onGround) vsp += grav;
	
	if(moveY && onGround)
	{
		vsp += jumpspd;
	}
	
	rodAngle = point_direction(x, y, mouse_x, mouse_y)
	
	if(global.isDependent)
	{
		ropeX = x + lengthdir_x(rodLength, rodAngle);
		ropeY = y + lengthdir_y(rodLength, rodAngle);
	}
	else
	{
		ropeX = x + lengthdir_x(rodLength, rodAngle);
		ropeY = y + lengthdir_y(rodLength, rodAngle);
	}
	
	if(place_meeting(x, y, oEnemy)) room_restart();
	
	// Wrapping
	move_wrap(true, false, 16)
	
	image_xscale = (hsp != 0) ? ((hsp > 0) ? 1 : -1) : image_xscale;
	image_speed = (hsp != 0) ? 0.125 : 0;
	
	move();
}

draw = function()
{
	// Draw character
	draw_self();
	
	if(hasFlail) draw_sprite_ext(sRod, 0, x, y, 1, 1, rodAngle, c_white, 1)
}
