--Simple Space invader game
--tutorial www.youtube.com/
--Author: Mrinal Pande
--Section reference: readme.txt 


--Section 1 
function love.load()
    
	--Section 1.1
	player ={}
	player.x=0
	player.y=550
	player.bullets={}
	player.cooldown = 20
	player.speed = 2
    
	--Section 1.1.1
	player.fire=function()
		if player.cooldown <= 0 then
		    player.cooldown=20        
		    bullet={}
		    bullet.x= player.x + 35
		    bullet.y= player.y
		    table.insert(player.bullets,bullet)
		end
	end
end

--Section 2
function love.update(dt)
	player.cooldown= player.cooldown - 1

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
		b.y= b.y - 10
	end
end

--Section 3
function love.draw()
	
	--Section 3.1
	love.graphics.setColor(0,0,255)
	--drawing rectangle ("fill/line",x,y location,width,height) all in px
	love.graphics.rectangle("fill", player.x, player.y, 80, 30)
	love.graphics.setColor(255,255,255)

	--Section 3.2
	for _,b in pairs(player.bullets) do
		love.graphics.rectangle("fill", b.x, b.y, 10, 10)
	end
end
