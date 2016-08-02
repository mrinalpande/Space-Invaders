--Simple Space invader game
--tutorial www.youtube.com/
--Author: Mrinal Pande
--Section reference: readme.txt 

--Global Section
--min max
love.graphics.setDefaultFilter('nearest','nearest')
enemy={}
enemies_controller = {}
enemies_controller.enemies ={}

--Section 1 
function love.load()
    
	--Section 1.1
	player ={}
	player.x=0
	player.y=450
	player.bullets={}
	player.cooldown = 20
	player.speed = 2
	player.image = love.graphics.newImage('images/player.png')
    	player.fire_sound=love.audio.newSource('sounds/laser.wav')

	--Section 1.1.1
	player.fire=function()
		if player.cooldown <= 0 then
		    love.audio.play(player.fire_sound)
		    player.cooldown=40        
		    bullet={}
		    bullet.x= player.x + 90
		    bullet.y= player.y + 85
		    table.insert(player.bullets,bullet)
		end
	end

	--Section 1.2	   
	enemies_controller.image= love.graphics.newImage('images/enemy.png')
	--don't forget the colen	
	enemies_controller:spawnEnemy(0,0)
	enemies_controller:spawnEnemy(100,0)
	
end

--Section 1.3 		
--colen passes self else use function fuction_name(self)
function enemies_controller:spawnEnemy(x,y)

	--Section 1.3.1	
	enemy ={}
	enemy.x=x
	enemy.y=y
	enemy.width= 75
	enemy.height= 75
		--enemy.bullets={}
	--enemy.cooldown = 20
	enemy.speed = 0.2
	table.insert(self.enemies, enemy)

end

--Section 1.4
--function enemy:fire()

	--Section 1.4.1
--	if self.cooldown <= 0 then
--		self.cooldown=20        
--		bullet={}
--		bullet.x= self.x + 35
--		bullet.y= self.y
--		table.insert(self.bullets,bullet)
--	end

--end


--Section 2
function love.update(dt)
	player.cooldown= player.cooldown - 0.8

	--Section 2.1
	if love.keyboard.isDown("right") then
		player.x= player.x + player.speed
	elseif love.keyboard.isDown("left") then
		player.x= player.x - player.speed
	end

	if love.keyboard.isDown("space")then
		player.fire()
	end

	--Section 2.2
	for i,b in ipairs(player.bullets) do
		if b.y < -10 then
			table.remove(player.bullets,i)
		end	
		b.y= b.y - 5
	end

	--Section 2.3
	for _,e in pairs(enemies_controller.enemies)do
		e.y=e.y+e.speed
	end

	checkCollisions(enemies_controller.enemies,player.bullets)
end


--Section 3
function checkCollisions(enemies, bullets)
	for i, e in ipairs(enemies) do
	    for _, b in ipairs(bullets) do
		if b.y <= e.y + e.height and b.x > e.x and b.x < e.x + e.width then
		    table.remove(enemies, i)
		    table.remove(bullets, i)
		end
	    end
	end
end


--Section 4
function love.draw()
	--Section 4.1
	love.graphics.setColor(255,255,255)		
	love.graphics.draw(player.image, player.x, player.y,0,3)
	
	--Section 4.2 first is rotation , width height ,skew
	love.graphics.setColor(255,255,255)
	for _,e in pairs(enemies_controller.enemies) do
		love.graphics.draw(enemies_controller.image, e.x,e.y,0,1.5)
	end

	--Section 4.3
	love.graphics.setColor(255,255,255)	
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end
end
