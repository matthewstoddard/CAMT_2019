-- ©2019 Matthew Stoddard.  All rights reserved.

-- standard opening code
platform.apiLevel = '2.7'
local screen = platform.window
local width, height

local nxt, prv, smt = {},{},{}

local message = 'click a button'

-- import images
local nextButton = image.new(_R.IMG.nextButton)
local prevButton = image.new(_R.IMG.prevButton)
local submitButton = image.new(_R.IMG.submitButton)


function drawNav(gc)
    gc:drawImage(nxt.image,nxt.x,nxt.y)
    gc:drawImage(prv.image,prv.x,prv.y)
    gc:drawImage(smt.image,smt.x,smt.y)    
end

function pressCheck(x,y)
    if x >= 5 and x <= (5 + prv.width) and y >= prv.y and y <= (height-3) then
        return 'prev'
    elseif x >= nxt.x and x <= (nxt.x + nxt.width) and y >= nxt.y and y <= (height-3) then
        return 'next'
    elseif x >= smt.x and x <= (smt.x + smt.width) and y >= smt.y and y <= (height-3) then
        return 'submit'  
    end
end

function on.resize()
    local nxtBtn, prvBtn, smtBtn  -- used for scaled copies of images
    width = screen.width()
    height = screen.height()

    nxtBtn = image.copy(nextButton,0.16*width,0.14*height)
    prvBtn = image.copy(prevButton,0.16*width,0.14*height)
    smtBtn = image.copy(submitButton,0.22*width,0.14*height)
    
    nxt.image = nxtBtn
    nxt.width = image.width(nxt.image)
    nxt.height = image.height(nxt.image)
    nxt.x = width - (5 + nxt.width)
    nxt.y = height - (nxt.height + 3)
    
    prv.image = prvBtn
    prv.width = image.width(prv.image)
    prv.height = image.height(prv.image)
    prv.x = 5
    prv.y = height - (prv.height + 3)
    
    smt.image = smtBtn
    smt.width = image.width(smt.image)
    smt.height = image.height(smt.image)
    smt.x = (width - smt.width)/2
    smt.y = height - (smt.height + 3)
    
    screen:invalidate()
end

function on.mouseDown(x,y)
    local pressed = pressCheck(x,y)
    
    if pressed == 'next' then
        message = 'next clicked'
    elseif pressed == 'prev' then
        message = 'prev clicked'
    elseif pressed == 'submit' then
        message = 'submit clicked'
    else
        message = 'click a button'
    end
    screen:invalidate()
end


function on.paint(gc)
    drawNav(gc)
    gc:setFont('sansserif','r',math.floor(width/24))
    gc:drawString(message, (width - gc:getStringWidth(message))/2, height * 0.3)
end