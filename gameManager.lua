local composer = require("composer")
local enemy = require("enemy")
local soundTable = require("soundTable")

local gameManager = {}

local spawnEnemy, gameOver, randomizePosition, increaseDifficulty, 
	newSpawnTimer, newDifficultyTimer, randomizeType, destroyEnemies, changeBgm

local ENM_MIN_SPEED = 5
local ENM_MAX_SPEED = 20
local ENM_SPEED_STEP = 5

local DIFFICULTY_DELAY = 10000
local SPAWN_DELAY = 3000
local SPAWN_DELAY_STEP = 500
local MIN_SPAWN_DELAY = 500

local BGM_SWITCH_DELAY_VALUE = 1000

function gameOver(gm)

	audio.play( soundTable.death )

	composer.removeScene( "gameScene" )
	composer.gotoScene( "gameover" )

	gameManager.destroy(gm)
end

function increaseDifficulty(event)

	local gm = event.source.params.gm

	gm.spawnDelay = gm.spawnDelay - SPAWN_DELAY_STEP

	changeBgm(gm)

	if gm.spawnDelay < MIN_SPAWN_DELAY then
		gm.spawnDelay = MIN_SPAWN_DELAY
	end

	gm.enmMinSpeed = gm.enmMinSpeed + ENM_SPEED_STEP
	gm.enmMaxSpeed = gm.enmMaxSpeed + ENM_SPEED_STEP

	timer.cancel(gm.spawnTimer)
	newSpawnTimer(gm)

	print(gm.enmMinSpeed, gm.enmMaxSpeed, gm.spawnDelay)
end

function changeBgm(gm)

	if gm.bgmType == "slow" and gm.spawnDelay <= BGM_SWITCH_DELAY_VALUE then

		gm.bgmType = "fast"
		audio.stop(gm.bgm)
		gm.bgm = audio.play(audio.loadStream("audio/fast.wav"), {loops = -1})
	end
end

function newDifficultyTimer(gm)

	gm.difficultyTimer = timer.performWithDelay( DIFFICULTY_DELAY, increaseDifficulty, -1 )
	gm.difficultyTimer.params = {gm = gm}
end

function newSpawnTimer(gm)

	gm.spawnTimer = timer.performWithDelay( gm.spawnDelay, spawnEnemy, -1 )
	gm.spawnTimer.params = {gm = gm}
end

function destroyEnemies(gm)

	print("destroy enemies")
	print(gm.group.numChildren)

	for i = gm.group.numChildren, 1, -1 do

		print(i)

		if gm.group[i].id == "enemy" then

			enemy.destroy(gm.group[i])
			print("destroyed")
		end
	end
end

function gameManager.new()
	
	local gm = {}

	gm.bgm = audio.play(audio.loadStream("audio/slow.wav"), {loops = -1})

	gm.isPaused = false

	gm.enmMinSpeed = ENM_MIN_SPEED
	gm.enmMaxSpeed = ENM_MAX_SPEED
	gm.spawnDelay = SPAWN_DELAY

	gm.bgmType = "slow"

	gm.zoneR = 45

	gm.group = display.newGroup( )

	local bg = display.newImageRect( gm.group, "images/terrain_grass.png", 480, 370)

	bg.x, bg.y = 0.5*display.contentWidth, 0.5*display.contentHeight 

	local ritualImg = display.newImageRect( gm.group, "images/ritual_symbol.png", 2 * gm.zoneR, 2 * gm.zoneR )
	ritualImg.x = 0.5 * display.contentWidth
	ritualImg.y = 0.5 * display.contentHeight

	newDifficultyTimer(gm)
	newSpawnTimer(gm)

	gm.gameOver = gameOver

	return gm
end

function gameManager.destroy(gm)

	audio.stop(gm.bgm)
	gm.bgm = nil
	destroyEnemies(gm)
	timer.cancel( gm.spawnTimer )
	timer.cancel( gm.difficultyTimer )
	gm.group:removeSelf( )
end

function gameManager.pause(gm)

	gm.isPaused = true
	timer.pause( gm.difficultyTimer )
	timer.pause( gm.spawnTimer)
end

function gameManager.resume(gm)

	gm.isPaused = false
	timer.resume( gm.difficultyTimer )
	timer.resume( gm.spawnTimer )
end


function spawnEnemy(event)

	local gm = event.source.params.gm

	local x, y = randomizePosition()

	enemy.new(gm, x, y, 0.1 * math.random( ENM_MIN_SPEED, ENM_MAX_SPEED ), math.random(1,3))
end

function randomizePosition()

	local dice = math.random()

	-- left edge
	if  dice < 0.25 then

		return -100, math.random(0, display.contentHeight)

	-- top edge
	elseif dice >= 0.25 and dice < 0.5 then

		return math.random(0, display.contentWidth), -100

	-- right edge
	elseif dice >= 0.5 and dice < 0.75 then

		return display.contentWidth + 100, math.random(0, display.contentHeight)

	-- bottom edge
	else

		return math.random(0, display.contentWidth), display.contentHeight + 100

	end
end


return gameManager