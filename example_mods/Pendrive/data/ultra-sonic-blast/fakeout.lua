function onCreate()
makeLuaSprite('blackSquare', '', 0, 0)
makeGraphic('blackSquare', 3840, 3840, '000000')
setObjectCamera('blackSquare', 'game')
screenCenter('blackSquare')
setObjectOrder('blackSquare', 50)
addLuaSprite('blackSquare', true)
setProperty('blackSquare.alpha', 0)
end

function onBeatHit()



if curBeat == 584 then
doTweenAlpha('blackSquare', 'blackSquare', 1, 0.8)
end

if curBeat == 593 then
makeLuaSprite('sonic/rip', 'sonic/rip', -650, -50);
addLuaSprite('sonic/rip', true)
scaleObject('sonic/rip', 2.0, 2.0)
setProperty('sonic/rip.visible', true);
end

if curBeat == 597 then
doTweenAlpha('blackSquare', 'blackSquare', 0, 1)
end

if curBeat == 600 then
makeLuaSprite('sonic/rip', 'sonic/rip', -650, -50);
addLuaSprite('sonic/rip', true)
scaleObject('sonic/rip', 0.6, 0.6)
setProperty('sonic/rip.visible', false);

end

if curBeat == 980 then
doTweenAlpha('blackSquare', 'blackSquare', 1, 0.1)

end 

if curBeat == 984 then
doTweenAlpha('blackSquare', 'blackSquare', 0, 1)
end

if curBeat == 996 then
doTweenAlpha('blackSquare', 'blackSquare', 1, 0.1)

end



end


