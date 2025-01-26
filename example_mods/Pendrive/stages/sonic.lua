function onCreate()

makeLuaSprite('sonic/theycallme', 'sonic/theycallme', -100, 300);
addLuaSprite('sonic/theycallme', false)
scaleObject('sonic/theycallme', 2.0, 2.0)
setProperty('sonic/theycallme.visible', false);

makeLuaSprite('sonic/skybox2', 'sonic/skybox2', -650, -100);
addLuaSprite('sonic/skybox2')
scaleObject('sonic/skybox2', 2.0, 2.0)

makeLuaSprite('sonic/montana2', 'sonic/montana2', -1000, 220);
addLuaSprite('sonic/montana2')
scaleObject('sonic/montana2', 2.5, 2.5)


makeLuaSprite('sonic/piso3', 'sonic/piso3', -650, 950);
addLuaSprite('sonic/piso3')
scaleObject('sonic/piso3', 2.0, 2.8)

makeLuaSprite('sonic/skybox', 'sonic/skybox', -650, -150);
addLuaSprite('sonic/skybox')
scaleObject('sonic/skybox', 2.0, 2.0)

makeLuaSprite('sonic/montana', 'sonic/montana', -650, 420);
addLuaSprite('sonic/montana')
scaleObject('sonic/montana', 2.0, 2.0)

makeLuaSprite('sonic/pasto', 'sonic/pasto', -680, 700);
addLuaSprite('sonic/pasto')
scaleObject('sonic/pasto', 2.0, 2.0)

makeLuaSprite('sonic/clouds', 'sonic/clouds', -750, -200);
addLuaSprite('sonic/clouds')
scaleObject('sonic/clouds', 2.0, 2.0)


makeLuaSprite('sonic/piso', 'sonic/piso', -650, 1010);
addLuaSprite('sonic/piso')
scaleObject('sonic/piso', 2.0, 2.8)
setProperty('sonic/piso.visible', true);


setProperty('sonic/fondogif.visible', false);
makeAnimatedLuaSprite('sonic/fondogif','sonic/fondogif',-440, 80);
addAnimationByPrefix('sonic/fondogif', 'fondogif', 'fondogif', 60, true);
scaleObject('sonic/fondogif', 7.4, 7.4)
addLuaSprite('sonic/fondogif', false);
setProperty('sonic/fondogif.visible', false)





end

function onStepHit()

if curBeat == 600 then

setProperty('sonic/piso.visible', false);
setProperty('sonic/pasto.visible', false);
setProperty('sonic/montana.visible', false);
setProperty('sonic/clouds.visible', false);
setProperty('sonic/skybox.visible', false);

setProperty('sonic/piso3.visible', false);
setProperty('sonic/montana2.visible', false);
setProperty('sonic/skybox2.visible', false);

end

if curBeat == 664 then

setProperty('sonic/piso3.visible', true);
setProperty('sonic/montana2.visible', true);
setProperty('sonic/skybox2.visible', true);
end

if curStep == 3168 then
setProperty('sonic/fondogif.visible', true);

end

if curBeat == 920 then
setProperty('sonic/piso3.visible', false);
setProperty('sonic/montana2.visible', false);
setProperty('sonic/skybox2.visible', false);
setProperty('sonic/fondogif.visible', false);

end

if curBeat == 984 then

setProperty('sonic/piso3.visible', false);
setProperty('sonic/montana2.visible', false);
setProperty('sonic/skybox2.visible', false);
setProperty('sonic/theycallme.visible', true);

end



end
