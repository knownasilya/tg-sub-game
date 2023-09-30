pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
--tg diver
--by tg devs

#include src/utils.lua
#include src/shark.lua
#include src/collisions.lua
#include src/world.lua
#include src/particles.lua
#include src/player.lua
#include src/sub.lua
#include src/camera.lua
#include src/ui.lua


function _init()
  class = { init = function()end; extend = function(self, proto) local meta = {}
    local proto = setmetatable(proto or {},{__index=self, __call=function(_,...) local o=setmetatable({},meta) return o,o:init(...) end})
    meta.__index = proto ; for k,v in pairs(proto.__ or {}) do meta['__'..k]=v end ; return proto end }
  setmetatable(class, { __call = class.extend })


  --screen shake variables
  shake_int = 0
  shake_control = 5

  i_shark()
  i_world()
  i_sub()
  i_player()
  i_camera()
  i_particles()
  i_ui()
end

function _update60()
  u_world()
  u_player()
  u_sub()
  u_camera()
  u_particles()
  u_ui()
end

function _draw()
  d_world()
  d_player()
  d_sub()
  d_particles()
  d_ui()
end
__gfx__
000000000000000000000000000aa000000aa00000000000000aa000000aa000000aa00050505050505050500000000000000000000000000000666666660000
0000000000000000aaaaaaa00099970000999900000aa0000099990000999900009999000505050505050500007777000000000000000000066d6d6d6d6d6660
0070070000000aaaaa5555500a9559a0099a959000999900099a9590099a9790099a9790005050505050500007000070000000000000000066d7d7d7d7d7d766
000770000000a999956666000a9ff9a0099a9f90099a9590099a9f90099a9f90099a9f900005050505050500070000000000000000000000667d7d7d7d7d7d66
000770009a0a9aaaa60000600099990000999900099a9f90009999000099940000999400005050505050500007000000000000000000000066d7d7d7d7d7d766
007007009a09aaaaa655b076077447700077740000999900007774000d77777d007d770000050505050505000700007000000000000000000676767676767660
000000009aaaaaaaa655c0060d7777d000d777d0007d7d000077d00007777000007777d000505050505050500077770000000676676000000667676767676760
000000009aaaaaaaa655750600600600006006000006600000600600660660000660060005050505050505050000000000067767767760000066767676767600
ddd555609aaaaaaaa64ff0069fffff9f9fffff9f9ffff99544444444044444405ddddddd50505050000000005000000000677677776776000006666666666000
ddddd5559a0a999996550006f9fff9f9f9fff9f9f9ff9550444444440004400005dddddd05050505000000050500000006776777677677600000666666660000
dddd55550009aaaaad55f06059f9995959f55959559955404444444400000000505dddd000505050000000505050000067767767677767760077eeeddeee7700
ddd555550000999977666660055f954545544545455544404444444400000000050dddd5000005000000050505050000677676776767677667eeeeeeeeeeee76
dd5d5d55000000097799977004455544444444444444440044444444000000005050dd50000000000000505050505000d67d76d767d76d7dd77777777777777d
dd5d55dd00000000000000000444444444444444444444004444444400000000050505050000000000050505050505000dd6d6d6d6d6d6d00dd6d6d6d6d6d6d0
dddd555d000000000000000004444444444444444444440044444444000000005050505000000000005050505050505000dd6d6d6d6d6d0000dd6d6d6d6d6d00
dddd555500000000000000000444444444444444444444004444444400000000050505050000000005050505050505050000dddddddd00000000dddddddd0000
00000000000660000000000000000000000000dd44444440044444440e02e00e0000000000000000505050505050505000cccc0000cccc000000000000000000
0000000000d56000000000000000000000000dd54444444004444444e002e0e00000000000000000050505050505050006c6cc6006c6cc600000000000000000
0000000000d5600000560000006600000000ddd544444440004444442e0ee00e000000000000000000505050505050000cccccc00cccccc00000000000000000
0000000000d560000056600000d66000000ddd5544444400004444440ee0e0e000050500000000000005050505050000c0c00c0cc0c00c0c0000000000000000
000030000dd566000dd566000dd5560000ddd5554444440000444444002e0e00005050505000000000005050505000000c00c0c00c00c0c00000000000000000
000030000dd566000dd566600dd555600dddd5554444440000444444000ee2000505050505050000000005050500000000000000000000000000000000000000
000300000d5556000d5566600d5556600dddd55544444440004444440e2eeee0505050505050500000000050500000000c00c0c00c00c0c00000000000000000
000330000d555560d5555566dd555560dddd555544444440044444442eee22ee0505050505050500000000050000000000000000000000000000000000000000
00033000660000005555555565555566000000000002000000300030000000005050505000000000000000000000000099956999000000000000000000000000
000030005660000055555555665555666000000000e0000000300030000000000505050500000000000000000000000091212129000000000000000000000000
000033005566000055555555555555565600000000e000000033033000000000505050500000000000000000a4a44a4a92121219000000000000000000000000
0000330055566000555555555555655656000000002e0e0000030300003000000505050500000000000000009494494991212129000000000000000000000000
00033000555666005555555555566656566000000002e00000030033003000005050505000000000505000000555a55005555550000000000000000000000000
003300005556666055555555555555655566000000000e003033000303300030050505050005050505050505a445644aa445644a000000000000000000000000
00330000555566605555555555d555555556660000e0e20003300030030000305050505000505050505050509444444994444449000000000000000000000000
000330005555666655555555555d5555555555550002e00000300300003003000505050505050505050505059444444994444449000000000000000000000000
00000066000000000000006600000000000000660000000000000066000000000000000000000000000000000000000000000000000000000000000000000000
00000666000000000000066600000000000006660000000000000666000000000000000000000000000000000000000000000000000000000000000000000000
66666666600000666666666660000600666666666000006666666666600006000000000000000000000000000000000000000000000000000000000000000000
66616666666006606661666666600600666166666660066066616666666006000000000000000000000000000000000000000000000000000000000000000000
07666e666666666006666e666666660006666e666666666006666e66666666000000000000000000000000000000000000000000000000000000000000000000
00766666666666000666666666666600066666666666660006666666666666000000000000000000000000000000000000000000000000000000000000000000
00666fffff0006600066ffffff000600006fffffff000660006fffffff0006000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616152626161616161616161616152616161616161616161616161616161616261616161616161616162
61616161626161616161616161616152626161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161615262616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
61616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161616161
61616161616161616161616161616161616161616161616161616161616161610000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001100000000000000000000100010001000100010001000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001000100000000000100010001000100010001000100010001000000000000000000000000000000000000000000000
00000000000000000000000000000000001000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001101100000100010001000100010001000100010001000100010001000000000000000000000000000000000000000
00000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000100110010001000100010001000100010001000100010001000100010000000000000000000000000000000000000
00000000000000000000000000000000101100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000011000101000100010001000100010001000100010001000100010001000100000000000000000000000000000000000
00000000000000000000000000000000001001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001000300010001000100010001000100010001000100010001000100010001000000000000000000000000000000000
00000000000000000000000000000000001000100000000000000000000001111111111100000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000001111101000100010001000111111111111111111111000100010001000100010000000000000000000000000000000
00000000000000000000000000000000000101000000000000000111111111111111111111111111000000000000000000000000000000000000000000000000
00000000000000000000000000000000001100310010001000111111111111111111111111111111111000100010001000100000000000000000000000000000
00000000000000000000000000000000101100010000000001111111111111111111111111111111111100000000000000000000000000000000000000000000
00000000000000000000000000000000111010101000100111111111111111111111111111111111111111001000100010001000000000000000000000000000
00000000000000000000000000000000001001000000001111111111111111111111111111111111111111100000000000000000000000000000000000000000
00000000000000000000000000000010003000300010011111111111111111111111111111111111111111110010001000100010000000000000000000000000
00000000000000000000000000000000001000100001111111111111111111111111111111111111111111111100000000000000000000000000000000000000
00000000000000000000000000001000101111101011111111111111111111111111111111111111111111111110100010001000100000000000000000000000
00000000000000000000000000000000000101000111111111111111111111111111111111111111111111111111000000000000000000000000000000000000
00000000000000000000000000100010001100311111111111111111111111111111111111111111111131111111101000100010001000000000000000000000
00000000000000000000000000000000101100031111111111111111111111111111111111111111111131111111110000000000000000000000000000000000
00000000000000000000000010001000111010311111111111111111111111111111111111111111111311111111111010001000100010000000000000000000
00000000000000000000000000000000001001111111111111111111111111111111111111111111111331111111111000000000000000000000000000000000
00000000000000000000000000100010003001311111111111111111111111111111111111111111111111111111111100100010001000000000000000000000
00000000000000000000000000000000001011311111111111111111111111111111111111111111111111111111111110000000000000000000000000000000
00000000000000000000000010001000101313311111111111111111111111111111111111111111111111111111111111001000100010000000000000000000
00000000000000000000000000000000000313111111111111111111111111111111111111111111111111111111111111000000000000000000000000000000
00000000000000000000001000100010001311331111111111111111111111111111111111111111111111111111111111100010001000100000000000000000
00000000000000000000000000000000103311131111111111111111111111111111111111111111111111111111111111100000000000000000000000000000
00000000000000000000100010001000133111311111111111111111111111111111111111111111111111111111111111111000100010001000000000000000
00000000000000000000000000000000013113111111111111111111111111111111111111111111111111111111111111110000000000000000000000000000
00000000000000000000001000100010113111311111111111111111111111111111111111111111111111111111111111111010001000100000000000000000
00000000000000000000000000000000113111311111111111111111111111111111111111111111111111111111111111111000000000000000000000000000
00000000000000000000100010001000113313311111111111611111111111111111aa7797711111111111111111111111111000100010001000000000000000
00000000000000000000000000100001111313111111111116161111111111111aaaaa7797711111111111111111111111111100000000000000000000000000
0000000000000000000000100030001111131133111131111161111111111111a999996666111111111111111111111111111110001000100000000000000000
0000000000000000000000000110001131331113111131111111111111119a1a9aaaa61111611111111111111111111111111100000000000000000000000000
0000000000000000000010001100101113311131111311111111111111119a19aaaaa655b1761111111111111111111111111100100010001000000000000000
0000000000000000000000000010010111311311111331111111111111119aaaaaaaa655c1161111111111111111111111111100000000000000000000000000
0000000000000000001000100030003111311131111331111111111111119aaaaaaaa65575161111111111111111111111111110001000100010000000000000
0000000000000000000000000010003111311131111131111111111111119aaaaaaaa64ff1161111111111111111111111111110000000000000000000000000
0000000000000000000010001011113111331331111133111111111111119a1a9999965511161111111111111111111111111110100010001000000000000000
0000000000000000000000000001011111131311111133111111111111111119aaaaad55f1611111111111111111111111111110000000000000000000000000
00000000000000000010001000110033111311331113311111111111111111119999996666111111111111111111111111111110001000100010000000000000
00000000000000000000000010110013313311131133111111111111111111111119999991111111111111111111111111111110000000000000000000000000
00000000000000000000100011101031133111311133111111111111111111111111111111111111111111111111111111111110100010001000000000000000
00000000000000000000000000100111113113111113311111111111111111111111111111111111111111111111111111111110000000000000000000000000
00000000000000000010001000300031113111311113311111111111111111111111111111111111111111111111111111111110001000100010000000000000
00000000000000000000000000100031113111311111311111111111111111111111111111111111111111111111111111111110000000000000000000000000
00000000000000000000100010111131113313311111331111111111111111111111111111111111111111111111111111111110100010001000000000000000
00000000000000000000000000010101111313111111331111111111111515111111111111111111111111111115151111111100000000000000000000000000
00000000000000000000001000510033511311331113311111111111115151515111111111111111111111111151515151111110001000100000000000000000
00000000000000000000000010110003353311131133111111151515151515151515111111111111111515151515151515151100000000000000000000000000
00000000000000000000500051105011533151311133111111515151515151515151511111111111115151515151515151515100100010001000000000000000
00000000000000000000000000100105153513111113311115151515151515151515151111111111151515151515151515151500000000000000000000000000
00000000000000000000005000300030513151315153315151515151515151515151515151515151515151515151515151515050005000500000000000000000
00000000000000000000000000100010153515351515351515151515151515151515151515151515151515151515151515151000000000000000000000000000
00000000000000000000500050115110513353315151335151515151515151515151515151515151515151515151515151515000500050005000000000000000
00000000000000000000000000010100051313151515331515351515151515151515151515151515151515151515151515150000000000000000000000000000
00000000000000000000005000510031015351335153315151315151515151515151515151515151515151515151515151510050005000500000000000001000
00000000000000000000000010110001103315131533151513351535151515151515151515151515151515151515151515100000000000000000000000001000
00000000000000000000000051105010513151315133515153515131515151515151515151515151515151515151515151505000500050000000000000010000
00000000000000000000000000100100001513151513351515351315151515151515151515151515151515151515151515000000000000000000000000011000
00000000000000000001005000300030003151315153315151315131515151515151515151515151515151515151515151500050005000500000000000011000
00000000000000000020000000100010001015351515351515351535151515151515151515151515151515151515151510000000000000000000000000001000
00000000000000000020000050115110501153315151335151335331515151515151515151515151515151515151515150005000500050000000000000001100
00000000000000000012020000010100000101151515331515131315151515151515151515151515151515151515151000000000000000000000000000001100
00000000000000000001200000510031005100335153315151535133515151515151515151515151515151515151515000500050005000000000000000011000
00000000000000000000020010110001101100031533151535331513151515151515151515151515151515151515150000000000000000000000000000110000
00000000000000000020210001105010511050105133515153315131515151515151515151515151515151515151500050005000500000000000000000110000
00000000000000000001200000100100001001000513351515351315151515151515151515151515151515151515000000000000000000000000000000011000
0000000000010000020120020030003000300030005331515131513151515151515151dd51515151515661515150005000510050005000000000000000011000
500000000020000020012020001000100010001000053515153515351515151515151dd56515151515d565151500000000200000000000000000000000001000
05000000002000001202200200115110501151105000335151335331515151515151ddd55651515151d561515005500050205000500000000000000000001100
0500000000120200022020200001010000010100000011151513131515351515151ddd555615151515d565100005500000120200001000000010000000001100
055000000001200000120200000100310051003100511051515351335131515151ddd555566151515dd5665001d0555000512050001000000010000000011000
00550000000002000002210010110001101100010011000015331513133515351dddd555556615151dd555000110555000000200011000100110001000110000
00055500002021000212222001100010511050105011500051115131535151315dddd555555666515d005500510065505020e100010000100100001000110000
0000000000012000122211220010010000100100000110000010031515351315dddd555555555555010000501000005500012000001001000010010000011000
5ddddd5d5ddddd5d5ddddd5d5ddddd5d5dfddd9d5dfddd9d5dfddd9d9fffff9f9fffff9f9ffffd9d5dfddd9d5dfddd9d5dfddd5d5ddddd5d5ddddd5d5ddddd5d
d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd9f9f9fff9f9d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5d5ddd5d5
05d0050505d0050505d0050505d0050505d0550555d0550555d0550555d0550555d0550555d0550555d0550555d0550555d0050505d0050505d0050505d00505
20022020200220202002202020022020200220202002202020022020200220202002202020022020200220202002202020022020200220202002202020022020
22222222222222222222222222222222222222422242224222422242224222422242224222422242224222422242224222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222422242224222422242224222422242224222422242224222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222224222422242224222422242224222422242224222422222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222224222422242224222422242224222422222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222224222422242224222422222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222

__gff__
0002020202000202020000000000000000020201010101000000000004040000000000000001010000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000026260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000026260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000026260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000026260000000000000000000000000000000000000000000000000000000000000000
0000000000002000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000203036141414141400000000000000000000000000000026260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000014141414141414141414141414141414141414141414141414141500000016260000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002616161616161616161616161616161616161616161616161616161b000016260000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000001616161616161616161616161616161616161616161616161616381b0026260000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001616161616161616161616161616161616161616161616161616382b1a26260000000000000000000000000000000000000000000000000000000000000000
000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000261616161616161616161616161616161616161616161616162b1a0a16260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000002a1616161616161616161616171616161616161616161616251a093816260000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000026161616161616161616161a382b1a38381616161616161a38383816260000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003b001314161616252616161618382b1a38383819183838191a3838383816160000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000000000000013141414141414161616161616382b1a383838383738382b1a383838383816160000000000000000000000000000000000000000000000000000000000000000
00000000000000002000000000000000000000000000000000000000000000000000000000002000000000000000200000000000000000000000000000000000001717171717172616161616162b1a380a09382b362a191a3838380a093816160000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000170a261616161a3838383838131414141414141414141416160000000000000000000000000000000000000000000000000000000000000000
0000002000000000000000000000000000000000000000000000000000303035000b00000000000000000000000000000000000000000000000000000000000000000036000000001909261616143838383838161616252616161616161616160000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000013141414141500000000000000000000000000000000000000000000000000000000000000003000000000002a261616261438383838181716161616161616161616160000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000002000000000000000001616161616250000000000000000000000000000000000000000000000000000000000000000300000000000001700090a16143838382b1a16161616161625261616160000000000000000000000000000000000000000000000000000000000000000
00000000000000000037000000000000000000000000000000000000002616161616160000000000000000000000000000000000000000000000000000000000000037300000000000000000192a161619382b1a3818183838171616161616160000000000000000000000000000000000000000000000000000000000000000
000000000000000000300000000000200000000000000000000000000017181838182b000000300000000000000000000000000000000000000020000000000000003630002800000000000000002a16142b1a38383838382b1a3838161616160000000000000000000000000000000000000000000000000000000000000000
000000002000000000300000000000000000000000000000000000000000090a09380000000036000000000000000000000000000000000000000000000000000000363000091b000000000000000016161438383838382b1a380a09171616160000000000000000000000000000000000000000000000000000000000000000
000000000000000000300000000000000000000000000000000000000000383838380000000036000000000000000000000000000000000000000000000000000000363000192a1b00280000000000171616383838382b1a383838381b1716162000000000000000000000000000000000000000000000000000000000000000
00000000000000000030000000000000000000000000000000000000000038383838000000003600000000002000000000000000000000000000000000000000000036303500002a1b38290000000000161614141414141409383838381b16160000000000000000000000000000000000000000000000000000000000000000
0000000000000000003000370000000000000000000000000000003000003838380a000000003600000000000000000000000000000000000000000000000000000013152737001a3838382900000000183838381838381838383838380a16160000000000000000000000000000000000000000000000000000000000000000
000000000000000000300030000000000000000000003700000000300000090938380000003736200000000000000000000000000000000000000000000000000000261614151a38381909381b000000383838383838383838383838383816160000000000000000000000000000000000000000000000000000000000000000
0000000037000000003000300000000000000000000036000000003000000938383800000036363000000000000000000000000000000000000000003500000000002625162538383838382b000000000a380a09383838380a383838383816160000000000000000000000000000000000000000000000000000000000000000
23000000300000000030003000000000000000000000360000003736000009380a380000003636300000000000000000000000000000000000002137350000000000261616252b193838380000000000093838383838193838383838381416160000000000000000000000000000000000000000000000000000000000000000
32310000300000000030003000000000000000000000363700003636000038383838000000363630370000000000000000200000000000000000131415000000000026162525220019192221000000001314383838381a2b19193838381616163928290000000000000000000000000000000000000000000000000000000000
3232310030370000353036300000002300000000003713150000303600000a38380a000035363630360000000000000000300000000000000000262525003500000026161616320000243232310035002616143838382b0000001913141414143838383800000000000000000000000000000000000000000000000000000000
323232343036373b3530363024342432313735233713162535373036211a383838381b3b2736363036372434212235373730373737373621222416161631353b2434161616163234243232323331352426161638380a000000000016161616163838383800000000000000000000000000000000000000000000000000000000
1414141414141414141414141414141414141414141414161414141414141414141414141414141414141414141414141414141414141414141414141414141414141414161414141414141414141414141414141414141414141416161616163838383800000000000000000000000000000000000000000000000000000000
__sfx__
b30500001751418524005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504
ca0c01001751400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704
cb0c01001751400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704007040070400704
69030000185141a524005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504005040050400504
181100000662500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605006050060500605
000300001d623006030c603006030060300603006030e653006030060300603006030060300603006030060300603006030060300603006030060300603006030060300603006030060300603006030060300603