pico-8 cartridge // http://www.pico-8.com
version 43
__lua__
function _init()
 player_x = 64
 player_y = 100
 bullets = {}
 enemies = {}
 score = 0
 game_over = false
 lives = 3
 game_start = true
 stars = {}
 
 for i=1, 30 do
  add(stars, {x = rnd(120), y = rnd(120), speed = rnd(1)+0.5})
 end
end

function _update()
 
 if game_over then 
  if btnp(5) then _init() end
  return
 end
 
 for s in all(stars) do
  s.y += s.speed
  if s.y > 128 then
   s.y = 0
   s.x = rnd(128)
  end
 end
 
 if btn(0) then player_x -= 3 end
 if btn(1) then player_x += 3 end
 if btnp(4) then add(bullets, {x = player_x + 4, y = player_y}) end
 for b in all(bullets) do
  b.y -= 4
  if b.y < 0 then del(bullets, b) end
 end
 
 if rnd(100) < 2 then
 	add(enemies, {x = rnd(120), y = 0})
	end
	
	for e in all(enemies) do
	 e.y += 1
	 if e.y > 120 then 
	  lives -= 1
	  del(enemies, e) end
	end 
 
 if lives <= 0 then
  game_over = true
 end
 
	for b in all(bullets) do
	 for e in all(enemies) do
	  if abs(b.x-e.x) < 6 and abs(b.y-e.y) < 6 then
	   del(bullets, b)
	   del(enemies, e)
	   score += 1
	  end
	 end
	end
end

function _draw()
 cls()
 
 for s in all(stars) do
 pset(s.x, s.y, 7)
 end
  
 if game_over then
 	print("game over!", 40, 55, 8)
 	print("score: "..score, 40, 65, 7)
 	print("press 'x' to play again.", 22, 80, 6)
 	return
 end
 
 
 spr(1, player_x, player_y)
 for b in all(bullets) do
 pset(b.x, b.y, 4)
 end
 
 for e in all(enemies) do
  spr(2, e.x, e.y)
 end
 
 print("score: "..score, 2, 2, 7)
 print("lives: "..lives, 2, 10, 8)
end
__gfx__
00000000000ee000000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000eeee0000bbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000ee22ee00bbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ee2222eebbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000e2e22e2e0bbbbbb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000000000000bbbb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000bb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
