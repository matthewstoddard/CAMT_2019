-- ©2019 Matthew Stoddard.  All rights reserved.

platform.apiLevel = '2.7'
local screen = platform.window
local giveGC = platform.withGC
local width, height

function setFontSize(size, gc)
    local fontSize
    if size == 'h1' then
        fontSize = math.floor(width/15)
    elseif size == 'lg' then
        fontSize = math.floor(width/24)
    elseif size == 'md' then
        fontSize = math.floor(width/32)
    elseif size == 'sm' then
        fontSize = math.floor(width/40)
    else
        fontSize = 12
    end
    return fontSize
end

function on.resize()
    width = screen:width()
    height = screen:height()
end

function on.paint(gc)
    local str = 'Quiz Template'
    gc:setFont('sansserif','b',setFontSize('h1',gc))
    local sw = gc:getStringWidth(str)
    local sh = gc:getStringHeight(str)
    gc:drawString(str,(width - sw)/2, height*0.30)
    gc:setFont('sansserif','r',setFontSize('sm',gc))
    str = '©2019 Matthew Stoddard'
    local sw = gc:getStringWidth(str)
    local sh = gc:getStringHeight(str)
    gc:drawString(str,(width - sw)/2, height - (sh + 3))
end