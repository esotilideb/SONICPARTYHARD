local zoom = false --cam zooming

function onCreatePost()
for i = 0, 3 do
if not middlescroll then
scaleObject('strumLineNotes', 1.67, 1.6)
setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + -800)
end
end

for i = 4, 7 do
if not middlescroll then
setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') - 102)
setPropertyFromGroup('strumLineNotes', i, 'y', getPropertyFromGroup('strumLineNotes', i, 'y') - 0)
else
setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + 0)
end
end

for i = 2, 3 do
if middlescroll then
setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') - 0)
end
end

for i = 0, 1 do
if middlescroll then
setPropertyFromGroup('strumLineNotes', i, 'x', getPropertyFromGroup('strumLineNotes', i, 'x') + 0)
end
end


makeLuaSprite('borderLeft', 'sonic/fondo flechas', 610, -50); 
addLuaSprite('borderLeft', false); 
setProperty('borderLeft.antialiasing', true); 
setObjectCamera('borderLeft', 'camHUD'); 
setProperty('borderLeft.scale.x', 1.0);
setProperty('borderLeft.scale.y', 1.0);


setProperty('timeBar.y', 60075);
setProperty('timeBar.x', 1230);
setProperty('timeBarBar.scale.x', 0.6);
setProperty('timeBarBarBG.scale.x', 0.6);

setProperty('iconP1.y', 600);
setProperty('iconP2.y', 600);

setProperty('iconP2.visible', false)
setProperty('iconP1.visible', false)
end

function onUpdatePost()

end

