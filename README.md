<b>Space invader game</b>

Tutorial series: https://www.youtube.com/watch?v=FUiz1kL0QtI

Language: Lua

Engine: love 2D

Artwork: Mrinal Pande

Sound: Create your own sound at http://www.bfxr.net/

This is a basic space invader game. Learning the basics of game development and learning the engine and its capabilities.
All the images imported are in images folder. The sounds used are in the sounds folder. To run you'll have to download love2d engine and just drop the folder onto the love2d.

<b>Global Section:</b>

	love.graphics.setDefaultfilter(min,max)
		This is the filter funtion available in love. What this do is simple it filters the images or other 
		visual media so i it doesn't get pixelated or looks torn basically it makes the image smooth.

	enemy ={}
		Enemy table which will contain all the enemies which are spawned. This table is redelared in 
		section 1.3.1 and is not really used globally but declared so as to tell love that it exists. There
		are two function which help enemy to spawn(see section 1.3 & 1.4).
	
	enemies_controller={}
		Basic table which contains data of all the enemies like size and where to spawn.

	enemies_controller.enemies={}
		This table contains the data of all the 'spawned' enemies.



<b>Section 1:</b>

	function love.load: 
		Function is used to load any necessary variables structures etc, which will be used in the 
		development of the programs(game).


Section 1.1

Information about the player 

	player = {}
		Player table. It is used to contain player information such as position bullet etc.

	player.x/y :
		x/y location for the player who is spawned by default 0 (set)

	player.bullets:
		For bullets

	player.cooldown:
		Cooldown timer for the bullets when bullets are fired else there will be stream of bullets 
		and the bullets fired will not be checked

	player.speed:
		Variable to set speed of the character going left right up or down

	player.image = love.graphics.newImage('location')
		This imports the image for the player in the game. Should be done in the love.load 
		function so that the image is ready to go when it is in game.

	player.fire_sound= love.audio.newSource('location')
		This is the love function that helps to import the sounds for the game any sound can 
		be added to the game with this function.
		The sound function is initialized in the love.load() function so as to avoid memory 
		leaks in the game. It should not be used in a loop as it will initialize the sound 
		again and again making the game heavy.

 
Section 1.1.1

	player.fire = function() 
		This is the funcion that allows the player to fire it contains the code for cooldown 
		timer, bullet creation where should the bullet spawn and inserting the bullet into the 
		bullet table when the bullet is made.

	player.cooldown <=0 
		checking if the player cooldown is zero or not and if the player cooldown should be reset or not.

	love.audio.play()
		This is the function that plays the sound whenever the bullet is fired it is put inside 
		the player.fire function so as to sync the sound with the bullet fired.
	bullet{}
		bullet table the contain bullets when they are made

	bullet.x/y
		where the bullet should spawn

	table.insert
		inserting the bullet into the player.bullets table 


Section 1.2

	
	enemies_controller.image= love.graphics.newImage('location')
		Enemy image location

	enemies_controller:spawnEnemy(x,y)
		Spawning enemies at x and y position using enemies_controller function(see section 1.3)

Section 1.3

	function enemies_controller:spawnEnemy(x,y)
		Enemies main function which help them to spawn. The colon signifies that it is a 
		self referencing function i.e. it can insert into the same table which it is 
		referencing to table enemy (see section 1.3.1).

Section 1.3.1

	enemy ={}
		Redeclated enemy table that contains all the enemies which are created.

	enemy.x
		x location of the enemy given by 'x' parameter in enemies_controller:spawnEnemy
		(see section 1.2)

	enemy.y
		y location of the enemy given by 'y' parameter in enemies_controller:spawnEnemy
		(see section 1.2)
	
	enemy.bullets={}
		when enemy will fire bullets (under development).

	enemy.speed
		To set the speed at which the enemy will decend. Same as player speed.

	table.insert(self.enemies, enemy)
		This is the self referencing declaration here we are adding the enemy which we 
		created to the the enemies_controller.enemies table.


Section 1.4

	Still working on it. Come back soon.



<b>Section 2:</b>

Definitions:

dt: dt is the delta time variable which checks for very small amount of changes. 

tick: running 60 times / second 

	function love.upadate:
		This is the primary function which is used for input function. The reason it is 
		used for the input function is that function love.update is run first in every 
		tick and then the frame is drawn and this process continues.

	player.cooldown:
		decreasing the cooldown in every tick


Section 2.1

	love.keyboard.isDown("key")
		Inbuilt function in love to check if there is a keypress. key is the key which is 
		pressed. The if...else logic works like if the key is pressed it does something 
		like move or fire bullet. For key="right" it moves the player to the right by adding 
		to its x position from player.x with the speed assigned(see section 1.1).Similarly for 
		left it subtracts from the players x position with player.speed. key="space" fires the 
		bullet by calling the player.fire funtion(see section 1.1.1).


Section 2.2

	For loop
		This for loop is used to make bullets move also there is a clean up code so that there 
		are no memory leaks. Memory leaks are possible since we were making bullets with our 
		space bars but we were not cleaning them up since the bullet we made first is still in 
		the memory it can lead to memory leaks if the memory is not delocated. Before the loop 
		ends there is a variable decrement "b.y =b.y - 10"(refer code line 50) this helps the 
		movement of the bullet bby decreasing the y axis by 10 pixels in dt time.


Section 2.3

	For loop 
		This loops makes the spawned enemy move towards the character. This uses the 
		enemies_controller.enemies table to see all the spawned enemies. All the enemies 
		present in the enemies_controller.enemies will then move to the player at 0.5 px in dt.



<b>Section 3</b>

	function checkCollision()
		This is the main function that checks collision and applies physics so as to remove the 
		enemy from the table when the bullet hits the enemy. This takes up two parameters that 
		are enemy and the bullet that are spawned.
	
	Basic Idea
		The idea is that when the bullet hits the enemy it should disappear. Now to do that we need 
		to check for the collision point at the base of the enemy and the top points of the bullets. 
		Also we have to check for the bullet to be in a boundary of the enemy.

	Algorithm
		for i, e in ipairs(enemies) do
		for _, b in pairs(bullets) do
		if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
		table.remove(enemies, i)

	Explanation
		The first for loop is the loop for all the enemies that are there in the enemy table
		(see global section). We take ipairs because we need the index of the enemies. The index 
		is the reason that we are able to remove specific enemy when the bullet hits it. The second 
		loop is for all the bullets spawned by the user which are there in the bullet table
		(section 1.1.1). If logic consists of the basic idea discussed above. It firsts checks 
		for the y coordinate of the bullet which should be less than or equal to the y cordinate 
		of the base of the enemy which is calculated by y coordinate of enemy plus the height of 
		the enemy. Then it checks for the x boundary that the bullet hits in between the boundaries 
		of the enemy in width by checking if the x-coordinate of the bullet is greater than 
		x-coordinate of the enemy and also less than x-coordinate of enemy plus its width.

	table.remove
		The reason for using index is simple it makes it easier to remove elements i.e. 
		enemies and bullets from the screen with the index which collides. Table dot remove 
		does that. It removes the bullets and enemies with the index which collides.



<b>Section 4</b>

	love.draw()
		This is the main funtion that helps in placing the character or other stuff. This 
		is where the things shape, size and color are set.

	love.graphics.scale(#)
		I have not really used it but was used in the tutorial video but sometimes it is 
		useful. '#' is the times you want to increase the scale by. For #=5 makes the scale 
		of the axis 5 times more than the origional. So if the player was 100px by 100px after 
		this function it will be 500px by 500px. All the existing values must be adjusted accordingly.

Seciton 4.1

	love.graphics.setColor(r,g,b)
		This is the predefined love function used before making any shape which will determine 
		the color of the shape. It takes three argument which are the color codes in rgb mode 
		ranging from 0 to 255.

	love.graphics.draw()
		This helps in drawing the image of the player mentioned in the section 1.1. The usual 
		parameters are image name, rotation, width, height,skew.

	love.graphics.rectangle()
		NOTE: It is not used now but can be helpful in starting development to get basic idea 
		where things will spawn.		
		
		This is the predefined love function used for the development of a rectangle on a canvas. 
		It takes up 5 arguments. first argument is fill or line which gives a solid block or 
		line drawing of the shape. Second and Third arguments are x and y location of the block 
		where it should be placed on canvas. Fourth and fifth arguments are width and height of 
		the of the shape. eg: love.graphics.rectangle("fill/line",x,y location,width,height) all in px.


Section 4.2

	love.graphics.setColor(r,g,b)
		This is set to white so that it doen't mess with the color of the model that we are 
		using section 1.3.1.
	
	For loop and love.graphics.draw
		For loop to generate the enemy image at a location of spawned enemy. The usual parameters 
		are image name, rotation, width, height,skew. Here image name is taken from the variable 
		enemies_controller.image which was declared in section 1.3.1, the rotation is set to 0 and 
		the width and height is set to 2 which is 2 times the origional width and height.

		NOTE: If only one parameter is given for width and height like in this case the engine 
		will multiply the parameter to both width and height else individual width and height 
		multipliers can be given. 
	

Section 4.3
	
	For loop
		This for loop is used to grnerate the bullets on canvas. How it will look where it will 
		spawn are all defined here. Since we don't care about the number of bullets the first 
		argument is an "_"(underscore). The function love.graphics.rectangle tells us to draw 
		a 10 x 10 pixel size bullet which spawns at b.x and b.y place.
