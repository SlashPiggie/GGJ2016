local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "utility" ) 

local params

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("menu", { effect = "crossFade", time = 333 })
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
    local screen_adjustment = 0.4
    --local background = display.newRect( 0, 0, 570, 360 )
    local background = display.newImage("images/background3.jpg",true)
    background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
    background.yScale = background.xScale
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background.alpha = 0.4
    sceneGroup:insert( background )

    --local title = display.newText("Prime Ritual", 125, 32, native.systemFontBold, 32 )
    local title = display.newImage("images/gameTitle.png", true)
    title.x = display.contentCenterX + 10
    title.y = 40
    --title:setFillColor( 0 )
    sceneGroup:insert( title )

    local creditText = display.newText( "Team Rejects!", 250, 250, native.systemFont, 16 )
    creditText:setFillColor( 1 )
    creditText.x = display.contentCenterX
    creditText.y = display.contentCenterY 
    sceneGroup:insert(creditText)

    -- http://www.freesfx.co.uk
    -- http://www.freesound.org

    local doneButton = widget.newButton({
        id = "button1",
        label = "Done",
        width = 100,
        height = 32,
        onEvent = handleButtonEvent
    })
    doneButton.x = display.contentCenterX
    doneButton.y = display.contentHeight - 40
    sceneGroup:insert( doneButton )

end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params

    if event.phase == "did" then
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
