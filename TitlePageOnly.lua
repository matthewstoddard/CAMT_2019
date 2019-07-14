-- ©2019 Matthew Stoddard.  All rights reserved.

platform.apiLevel = '2.7'
local screen = platform.window
local width, height

-- text strings
-- change as appropriate for your quiz
local title = 'Quiz Template'
local copyright = '©2019 Matthew Stoddard'


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

function on.resize()
    width = screen.width()
    height = screen.height()
    screen:invalidate()
end

function on.paint(gc)
    -- set font color
    gc:setColorRGB(48,85,240)
    -- set font style and size
    gc:setFont('sansserif','b',getFontSize('h1',gc))
    -- get information for text positioning
    local sw = gc:getStringWidth(title)
    local sh = gc:getStringHeight(title)
    -- draw title string
    gc:drawString(title,(width - sw)/2, height*0.30)
    -- set font style and size
    gc:setFont('sansserif','r',getFontSize('s',gc))
    -- get information for text positioning
    local sw = gc:getStringWidth(copyright)
    local sh = gc:getStringHeight(copyright)
    -- draw copyright string
    gc:drawString(copyright,(width - sw)/2, height - (sh + 3))
end