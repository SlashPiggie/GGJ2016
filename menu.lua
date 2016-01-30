local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "utility" )
local ads = require( "ads" )

local params

local myData = require( "mydata" )

local function handlePlayButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.removeScene( "levelselect", false )
        composer.gotoScene("levelselect", { effect = "crossFade", time = 333 })
    end
end

local function handleHelpButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene("help", { effect = "crossFade", time = 333, isModal = true })
    end
end

local function handleCreditsButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("gamecredits", { effect = "crossFade", time = 333 })
    end
end

local function handleSettingsButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("gamesettings", { effect = "crossFade", time = 333 })
    end
end

--
-- Start the composer event handlers
--
function scene:create( event )
    local sceneGroup = self.view

    params = event.params
        
    --
    -- setup a page background, really not that important though composer
    -- crashes out if there isn't a display object in the view.
    --
    local background = display.newRect( 0, 0, 570, 360 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert( background )

    local title = display.newText("Prime Ritual", 100, 32, native.systemFontBold, 32 )
    title.x = display.contentCenterX + 10
    title.y = 30
    title:setFillColor( 0 )
    sceneGroup:insert( title )

    -- Create the widget
    local playButton = widget.newButton({
        id = "button1",
        --label = "Play",
        defaultFile = "button/playButton.png",
        --overFile = "left.png",
        width = 300,
        height = 300,
        onEvent = handlePlayButtonEvent
    })
    
    -- local playButton = display.newImage("button/playButton.png")
    playButton.x = display.contentCenterX - 120
    playButton.y = display.contentCenterY - 10
    sceneGroup:insert( playButton )

    -- Create the widget
    local settingsButton = widget.newButton({
        id = "button2",
        defaultFile = "button/settingsButton.png",
        --overFile = "left.png",
        width = 300,
        height = 300,
        onEvent = handleSettingsButtonEvent
    })
    
    settingsButton.x = display.contentCenterX + 120
    settingsButton.y = display.contentCenterY + 25
    sceneGroup:insert( settingsButton )

    -- Create the widget
    local helpButton = widget.newButton({
        id = "button3",
        defaultFile = "button/helpButton.png",
        --overFile = "left.png",
        width = 300,
        height = 300,
        onEvent = handleHelpButtonEvent
    })

    helpButton.x = display.contentCenterX - 125
    helpButton.y = display.contentCenterY + 100
    sceneGroup:insert( helpButton )

    -- Create the widget
    local creditsButton = widget.newButton({
        id = "button4",
        defaultFile = "button/creditsButton.png",
        --overFile = "left.png",
        width = 300,
        height = 300,
        onEvent = handleCreditsButtonEvent
    })
    
    creditsButton.x = display.contentCenterX + 95
    creditsButton.y = display.contentCenterY + 120
    sceneGroup:insert( creditsButton )

end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params
    utility.print_r(event)

    if params then
        print(params.someKey)
        print(params.someOtherKey)
    end

    if event.phase == "did" then
        composer.removeScene( "game" ) 
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
    end

end

function scene:destroy( event )
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
