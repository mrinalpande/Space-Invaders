Space invader game
Tutorial: https://www.youtube.com/watch?v=FUiz1kL0QtI
Written by: Mrinal Pande
Language: Lua
Engine: love 2D

This is a basic space invader game. Learning the basics of game development and learning the engine and its capabilities.


Section 1:

	function love.load: 
		Function is used to load any necessary variables structures etc, which will be used in the development of the programs(game).


Section 1.1

Information about the player 
	player = {}
		Player table. It is used to contain player information such as position bullet etc.

	player.x/y :
		x/y location for the player who is spawned by default 0 (set)

	player.bullets:
		For bullets

	player.cooldown:
		Cooldown timer for the bullets when bullets are fired else there will be stream of bullets and the bullets fired will not be 			checked

	player.speed:
		Variable to set speed of the character going left right up or down


Section 1.1.1

	player.fire = function() 
		This is the funcion that allows the player to fire it contains the code for cooldown timer, bullet creation where should the 			bullet spawn and inserting the bullet into the bullet table when the bullet is made.

	player.cooldown <=0 
		checking if the player cooldown is zero or not and if the player cooldown should be reset or not.

	bullet{}
		bullet table the contain bullets when they are made

	bullet.x/y
		where the bullet should spawn

	table.insert
		inserting the bullet into the player.bullets table 



Section 2:

Definitions:

dt: dt is the delta time variable which checks for very small amount of changes. 

tick: running 60 times / second 

	function love.upadate:
		This is the primary function which is used for input function. The reason it is used for the input function is that function 			love.update is run first in every tick and then the frame is drawn and this process continues.

	player.cooldown:
		decreasing the cooldown in every tick


Section 2.1

	love.keyboard.isDown("key")
		Inbuilt function in love to check if there is a keypress. key is the key which is pressed. The if...else logic works like if the key is pressed it does something like move or fire bullet. For key="right" it moves the player to the right by adding to its x position from player.x with the speed assigned(see section 1.1).
Similarly for left it subtracts from the players x position with player.speed. key="space" fires the bullet by calling the player.fire funtion(see section 1.1.1).


Section 2.2
	For loop
		This for loop is used to make bullets move also there is a clean up code so that there are no memory leaks. Memory leaks are 			possible since we were making bullets with our space bars but we were not cleaning them up since the bullet we made first is 			still in the memory it can lead to memory leaks if the memory is not delocated. Before the loop ends there is a variable 			decrement "b.y =b.y - 10"(refer code line 50) this helps the movement of the bullet bby decreasing the y axis by 10 pixels in 			dt time.



Section 3

	love.draw()
		This is the main funtion that helps in placing the character or other stuff. This is where the things shape, size and color 			are set.


Seciton 3.1

	love.graphics.setColor(r,g,b)
		This is the predefined love function used before making any shape which will determine the color of the shape. It takes three 			argument which are the color codes in rgb mode ranging from 0 to 255.

	love.graphics.rectangle()
		This is the predefined love function used for the development of a rectangle on a canvas. It takes up 5 arguments. first 			argument is fill or line which gives a solid block or line drawing of the shape. Second and Third arguments are x and y 		location of the block where it should be placed on canvas. Fourth and fifth arguments are width and height of the of the 			shape. eg: love.graphics.rectangle("fill/line",x,y location,width,height) all in px.


Section 3.2
	For loop
		This for loop is used to grnerate the bullets on canvas. How it will look where it will spawn are all defined here. Since we 			don't care about the number of bullets the first argument is an "_"(underscore). The function love.graphics.rectangle tells 			us to draw a 10 x 10 pixel size bullet which spawns at b.x and b.y place.
