-- Shitting dog

debug = true

dog = { x = 200, y = 210, speed = 150, img = nil}

function love.load()
	x, y, w, h = 20, 20, 60, 20
	love.graphics.setColor(100, 100, 100)
	dog.img = love.graphics.rectangle("fill", 0, 0, 100, 100)
end

function love.update(dt)
	w = w + 1
	h = h + 1
end

function love.draw()
	love.graphics.print('Hello World', 400, 300)
	love.graphics.setColor(0, 100, 100)
	love.graphics.rectangle("fill", x , y , w, h)
	love.graphics.setColor(100, 0, 0)
	love.graphics.rectangle("fill", dog.x, dog.y, 100, 100)
end