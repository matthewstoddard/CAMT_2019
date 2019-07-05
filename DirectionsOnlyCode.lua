-- ©2019 Matthew Stoddard.  All rights reserved.

-- standard opening code
platform.apiLevel = '2.7'
local screen = platform.window
local width, height, dBoxy

-- text box for directions
local dBox = D2Editor.newRichText()
dBox:setReadOnly(true)
dBox:setSelectable(false)

-- set text for page
local title = 'Directions'
local directions = 'For each question, choose the best answer.  When all questions have been answered, you will be able to submit the quiz and view feedback.'

-- gc functions
function getFontSize(size, gc)
    local fontSize
    if size == 'md' then
        fontSize = math.floor(width/32)
    else
        fontSize = 12
    end
    return fontSize
end

-- text box functions
function setBox(w,h,y)
    dBox:move(5,y)
    dBox:resize (w-10,(0.6*h)+5)
    dBox:setMainFont('sansserif', 'r', getFontSize('md'))    
end

-- event-driven functions
function on.resize()
    width = screen:width()
    height = screen:height()
    screen:invalidate()
end

function on.paint(gc)
    -- draw title
    gc:setFont('sansserif','b',getFontSize('md'))
    local sw,sh = gc:getStringWidth(title),gc:getStringHeight('X')
    gc:drawString(title,5,5)
    dBoxy = sh + 10
    setBox(width,height,dBoxy)
    dBox:setExpression(directions)
end