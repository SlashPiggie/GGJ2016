local composer = require( "composer" )
local gameManager = require("gameManager")
local widget = require("widget")

local scene = composer.newScene()

local pause, newPauseButton


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

function pause(event)

    local gm = event.target.params.gm

    gameManager.pause(gm)
end

function newPauseButton(gm)

    pauseButton = widget.newButton( 
    {
        label = "pause",
        onPress = pause,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 50,
        height = 20,
        cornerRadius = 2,
        fillColor = { default={1,0,0,1}, over={1,0.1,0.7,0.4} },
        strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
        strokeWidth = 4
    } )

    pauseButton.x = display.contentWidth - pauseButton.width
    pauseButton.y = 20

    pauseButton.params = {gm = gm}

    return pauseButton
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    self.gm = gameManager.new()
    sceneGroup:insert(self.gm.group)

    self.pauseButton = newPauseButton(self.gm)
    sceneGroup:insert(self.pauseButton)
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    gameManager.destroy(self.gm)

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene