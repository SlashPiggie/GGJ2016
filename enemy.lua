local enemy = {}

enemy.TAP_1HP = 1
enemy.TAP_5HP = 2
enemy.HOLD = 3



local calcDir, setVel, updatePosition, onTouch, checkInZone, setType, checkDeath, setHold, drainHP, removeHold

function calcDir(x, y)

	return math.atan2( 0.5 * display.contentHeight - y, 0.5 * display.contentWidth - x  )
end

local function setVel(enm)
	enm.vx = enm.speed * math.cos(enm.dir)
	enm.vy = enm.speed * math.sin(enm.dir)
end

function updatePosition(enm)
	enm.x = enm.x + enm.vx
	enm.y = enm.y + enm.vy
end

function checkInZone(enm)

	if ((0.5 * display.contentWidth - enm.x)^2 + (0.5 * display.contentHeight - enm.y)^2) <= enm.gm.zoneR^2 then

		enm.gm:gameOver()
	end
end

function enemy.destroy(enm)

	if enm.holdTimer then
		timer.cancel( enm.holdTimer )
	end
	
	Runtime:removeEventListener( "enterFrame", enm )
	enm:removeSelf( )
	enm = nil
end

function onTouch(event)

	local enm = event.target

	if event.phase == "began" then

		if enm.type == enemy.HOLD then

			setHold(enm, event)

		else

			removeHP(enm)
		end

	elseif event.phase == "ended" or event.phase == "cancelled" then

		print(enm.touchID, event.id)

		if enm.type == enemy.HOLD and enm.touchID == event.id then

			removeHold(enm)
		end
	end
end


function removeHP(enm)

	enm.hp = enm.hp - 1
	checkDeath(enm)
end

function setHold(enm, event)

	enm.touchID = event.id

	enm.holdTimer = timer.performWithDelay( 1, 
						function() 
							enm.hp = enm.hp - 1 
							checkDeath(enm)
						end, -1 )
end

function removeHold(enm)

	timer.cancel(enm.holdTimer)
	enm.touchID = nil
end

function checkDeath(enm)

	if enm.hp <= 0 then
		enemy.destroy(enm)
	end
end

function enemy.new(gm, x, y, speed, type)

	local enm = display.newRect( gm.group, x, y, 50, 50 )

	enm.gm = gm

	enm.type = type
	setType(enm)

	enm.id = "enemy"

	enm.speed = speed or 100
	enm.dir = calcDir(x,y)
	setVel(enm)

	enm.rotation = enm.dir / math.pi * 180

	function enm:enterFrame ()
		if not gm.isPaused then
			updatePosition(self)
			checkInZone(self)
		end
	end

	enm:addEventListener( "touch", onTouch )
	Runtime:addEventListener( "enterFrame", enm )

	return enm
end

function setType(enm)

	if enm.type == enemy.TAP_1HP then

		enm.hp = 1
	elseif enm.type == enemy.TAP_5HP then

		enm.hp = 5
		enm:setFillColor( 1, 0, 0 )

	elseif enm.type == enemy.HOLD then

		enm.hp = 20
		enm:setFillColor( 0, 1, 0 )
		enm.isHeld = false
	end
end

return enemy
