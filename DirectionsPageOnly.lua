-- ©2019 Matthew Stoddard.  All rights reserved.

-- standard opening code
platform.apiLevel = '2.7'
local screen = platform.window
local width, height
local dBoxy -- sets vertical position of directons text

-- create text box for directions
local dBox = D2Editor.newRichText() -- could also be done in on.construction
dBox:setReadOnly(true) -- prevent students from editing text
dBox:setSelectable(false) -- box cannot be selected

-- set text for page
local title = 'Directions'
local directions = 'For each question, choose the best answer.  When all questions have been answered, you will be able to submit the quiz and view feedback.'

-- gc functions
function getFontSize(size, gc)
    local fontSize
    if size == 'h1' then
        fontSize = math.floor(width * 0.057)
    elseif size == 'h2' then
        fontSize = math.floor(width * 0.045)
    elseif size == 'p' then
        fontSize = math.floor(width * 0.04)
    elseif size == 'm' then
        fontSize = math.floor(width * 0.033)
    elseif size == 's' then
        fontSize = math.floor(width * 0.028)
    else
        fontSize = 12
    end
    return fontSize
end

-- text box functions
function setBox(w,h,y)
    dBox:move(5,y)
    dBox:resize (w-10,(0.6*h)+5)
    dBox:setMainFont('sansserif', 'r', getFontSize('m'))    
end

-- event-driven functions
function on.resize()
    width = screen:width()
    height = screen:height()
    screen:invalidate()
end

function on.paint(gc)
    -- set font for title
    gc:setFont('sansserif','b',getFontSize('h2'))
    -- get information for text positioning
    local sw,sh = gc:getStringWidth(title),gc:getStringHeight(title)
    -- draw title string
    gc:drawString(title,5,5)
    
    -- draw directions
    dBoxy = sh + 10 -- allows for 5px above and below title
    -- set position of directions
    setBox(width,height,dBoxy)
    -- draw directions
    dBox:setExpression(directions)
end