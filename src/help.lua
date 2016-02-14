local composer = require( "composer" )
local scene = composer.newScene()

local widget = require( "widget" )
local utility = require( "utility" )
 
local params 

local scrollView
local icons = {}


local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        composer.gotoScene("menu", { effect = "crossFade", time = 333 })
    end
    return true
end

local function buttonListener( event )
    local id = event.target.id

    if event.phase == "moved" then
        local dx = math.abs( event.x - event.xStart ) -- Get the x-transition of the touch-input
        if dx > 5 then
            scrollView:takeFocus( event ) -- If the x- or y-transition is more than 5 put the focus to your scrollview
        end
    elseif event.phase == "ended" then
        -- do whatever you need to do if the object was touched
        print("object",id, "was touched")
        timer.performWithDelay( 10, function() scrollView:removeSelf(); scrollView = nil; end)
    end
    return true
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
    -- local screen_adjustment = 0.4
    -- --local background = display.newRect( 0, 0, 570, 360 )
    -- local background = display.newImage("images/background3.jpg",true)
    -- background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
    -- background.yScale = background.xScale
    -- background.x = display.contentWidth / 2
    -- background.y = display.contentHeight / 2
    -- background.alpha = 0.1
    -- sceneGroup:insert( background )
    local screen_adjustment = 1
    local background = display.newRect( 0, 0, 570, 360 )
    background.xScale = (screen_adjustment  * background.contentWidth)/background.contentWidth
    background.yScale = background.xScale
    background.x = display.contentWidth / 2
    background.y = display.contentHeight / 2
    background:setFillColor( 1 )
    sceneGroup:insert( background )

    --local title = display.newBitmapText( titleOptions )
    -- local title = display.newText("Prime Ritual", 125, 32, native.systemFontBold, 32)
    -- title.x = display.contentCenterX
    -- title.y = 40
    -- title:setFillColor( 0 )
    -- sceneGroup:insert( title )

    local helpScreen = display.newImage("images/helpScreen.png")
    helpScreen.x = display.contentCenterX - 5
    helpScreen.y = display.contentCenterY - 10
    sceneGroup:insert( helpScreen )

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
