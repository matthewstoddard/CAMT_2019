-- ©2019 Matthew Stoddard.  All rights reserved.

-- standard opening code
platform.apiLevel = '2.7'
local screen = platform.window
local width, height

local stage -- used to control what is printed on the screen (questions or results)


-- question-related variables
local qNum, qAns, nCor
local qTot = 3 -- number of questions.  must be set here to properly initialize the question data table

-- initialize question data table
local qData = {}
for i = 1, qTot do
    qData[i] = {}
end

-- Since the question data does not change, it is loaded in main instead of the init function.
-- If the questions are to be generated randomly, then they need to be generated in the init function.

-- question data
qData[1]['stem'] = 'An acute angle is an angle with a measurement ___.'
qData[1]['A'] = 'equal to pi'
qData[1]['B'] = 'less than 90°'
qData[1]['C'] = 'greater than 90°'
qData[1]['D'] = 'equal to 90°'
qData[1]['correct'] = 'B'
qData[1]['points'] = 1

qData[2]['stem'] = '7 + 4 = ?'
qData[2]['A'] = '3'
qData[2]['B'] = '-3'
qData[2]['C'] = '11'
qData[2]['D'] = '-11'
qData[2]['correct'] = 'C'
qData[2]['points'] = 1

qData[3]['stem'] = 'Why should you come to the math side?'
qData[3]['A'] = 'We don\'t care how you spell 4 in your head.'
qData[3]['B'] = 'We\'ll sell you 65 watermelons, no questions asked.'
qData[3]['C'] = 'We\'re atually bad at fractions too.'
qData[3]['D'] = 'We have pi.'
qData[3]['correct'] = 'D'
qData[3]['points'] = 1
-- end question data

function init()
    stage = 1
    qNum, qAns = 1, 0
    for i = 1, qTot do
        qData[i]['answered'] = false
        qData[i]['stuAns'] = 'na'
    end
end


function checkAnswers()
    nCor = 0
    for i = 1, qTot do
        if qData[i]['stuAns'] == qData[i]['correct'] then
            nCor = nCor + 1
        end
    end
end



function getFontSize(size, gc)
    local fontSize
    if size == 'h1' then
        fontSize = math.floor(width/16)
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

function printNav(gc)
    local sw, sh, str

    if qNum == 1 then
        str = '[N]ext     [S]ubmit'
    elseif qNum == qTot then
        str = '[P]revious     [S]ubmit'
    else
        str = '[P]revious     [N]ext     [S]ubmit'
    end
    
    gc:setFont('sansserif','r',getFontSize('md'))
    sh = gc:getStringHeight('X')
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,height-(sh+4))
end

function printQuestion(gc)
    local sh, sw, yText, str
    local header = 'Question '..qNum
    
    gc:setFont('sansserif','b',getFontSize('md'))
    gc:drawString(header,4,4)
    yText = 8 + gc:getStringHeight(header) -- sets margins of 4 px on top and bottom
    
    gc:setFont('sansserif','r',getFontSize('md'))
    gc:drawString(qData[qNum]['stem'],4,yText)
    yText = yText + gc:getStringHeight(qData[qNum]['stem']) + 12
    
    gc:setFont('sansserif','b',getFontSize('md'))
    gc:drawString('A',4,yText)
    gc:setFont('sansserif','r',getFontSize('md'))
    gc:drawString(qData[qNum]['A'],24,yText)
    yText = yText + 4 + gc:getStringHeight(qData[qNum]['A'])

    gc:setFont('sansserif','b',getFontSize('md'))
    gc:drawString('B',4,yText)
    gc:setFont('sansserif','r',getFontSize('md'))
    gc:drawString(qData[qNum]['B'],24,yText)
    yText = yText + 4 + gc:getStringHeight(qData[qNum]['B'])

    gc:setFont('sansserif','b',getFontSize('md'))   
    gc:drawString('C',4,yText)
    gc:setFont('sansserif','r',getFontSize('md'))
    gc:drawString(qData[qNum]['C'],24,yText)
    yText = yText + 4 + gc:getStringHeight(qData[qNum]['C'])

    gc:setFont('sansserif','b',getFontSize('md'))
    gc:drawString('D',4,yText)
    gc:setFont('sansserif','r',getFontSize('md'))
    gc:drawString(qData[qNum]['D'],24,yText)
    yText = yText + 12 + gc:getStringHeight(qData[qNum]['D'])

    if qData[qNum]['stuAns'] == 'na' then
        str = 'Not Answered'
    else
        str = 'Your Answer:  '..qData[qNum]['stuAns']
    end
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,yText)
    yText = yText + 6 + gc:getStringHeight(str)
    
    str = qAns..' out of '..qTot..' answered'
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,yText)
end

function printResults(gc)
    local sh,sw
    local str, yText = "Results",4
    gc:setFont('sansserif','b',getFontSize('lg'))
    sh = gc:getStringHeight(str)
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,yText)
    yText = sh + 4
    
    str = 'Score:  '..nCor..' out of '..qTot
    gc:setFont('sansserif','r',getFontSize('md'))
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,yText)
    
    str = '[T]ry again'
    sw = gc:getStringWidth(str)
    gc:drawString(str,(width-sw)/2,height-(sh+5))
    
end


function on.charIn(char)
    local str = string.upper(char)
    
    if stage == 1 then
        if str == 'N' then
            if qNum < qTot then
                qNum = qNum + 1
            end
        elseif str == 'P' then
            if qNum > 1 then
                qNum = qNum - 1
            end
        elseif str == 'A' or str == 'B' or str == 'C' or str == 'D'then
            qData[qNum]['stuAns'] = str
            if qData[qNum]['answered'] == false then
                qData[qNum]['answered'] = true
                qAns = qAns + 1
            end
        elseif str == 'S' then
            stage = 2
            checkAnswers()
        end
    else
        if str == 'T' then
            init()
        end
    end
    screen:invalidate()
end

function on.construction()
    init()
end

function on.resize()
    width = screen:width()
    height = screen:height()
    screen:invalidate()
end

function on.paint(gc)

    if stage == 1 then
        printQuestion(gc)
        printNav(gc)
    else
        printResults(gc)
    end
end

