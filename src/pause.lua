local composer = require( "composer" )
local widget = require("widget")

local scene = composer.newScene()

local resume

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------




-- "scene:create()"
function scene:create( event )

    print("creating pause screen")

    local sceneGroup = self.view

    local overlay = display.newImageRect( sceneGroup, "images/pauseOverlay.png", 380, 290 )
    overlay.x = 0.5 * display.contentWidth
    overlay.y = 0.5 * display.contentHeight


    local resumeButton = widget.newButton( 
    {
        onPress = function() composer.gotoScene( "gameScene", {effect = "slideLeft"} ) end,
        emboss = false,
        defaultFile = "images/resumeButton.png",
        overFile = "images/resumeButton.png",
        width = 60,
        height = 60
    } )

    sceneGroup:insert(resumeButton)

    resumeButton.x = 0.3 * display.contentWidth
    resumeButton.y = 0.5 * display.contentHeight

    resumeButton.params = {gm = gm}

    local resetButton = widget.newButton( 
    {
        onPress = function() 
            composer.removeScene( "gameScene" )
            composer.gotoScene( "gameScene")
        end,
        emboss = false,
        defaultFile = "images/resetButton.png",
        overFile = "images/resetButton.png",
        width = 65,
        height = 65
    } )

    sceneGroup:insert(resetButton)

    resetButton.x = 0.5 * display.contentWidth
    resetButton.y = 0.5 * display.contentHeight

    local exitButton = widget.newButton( 
    {
        onPress = function() 
            composer.removeScene( "gameScene" )
            composer.gotoScene( "menu", {effect = "fade"})
        end,
        emboss = false,
        defaultFile = "images/exitButton.png",
        overFile = "images/exitButton.png",
        width = 60,
        height = 60
    } )

    sceneGroup:insert(exitButton)

    exitButton.x = 0.7 * display.contentWidth
    exitButton.y = 0.5 * display.contentHeight


    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
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