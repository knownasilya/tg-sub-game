function i_shark()
  shark_timing=.05
  patrol_time=120
  shark = class {
    state='patrol'; -- patrol, chase, attacking, dead
    x=20;
    y=20;
    speed=.3;
    flip_x=true; -- left
    patrol_t=0;
    swim_frames={68, 70, 68};
    attack_frames={64, 66, 64};
    fr=1;

    init=function(self, x, y)
      self.x=x or self.x
      self.y=y or self.y
    end;

    animate=tick_frames;

    update=function(self)
      local dist_to_player = dst(self, tgsub)
      local collide_with_sub_left = check_collision(self.x-1, self.y, 16, 8, tgsub.x, tgsub.y, 16, 16)
      local collide_with_sub_right = check_collision(self.x+1, self.y, 16, 8, tgsub.x, tgsub.y, 16, 16)
      local collide_with_sub_top = check_collision(self.x, self.y-1, 16, 8, tgsub.x, tgsub.y, 16, 16)
      local collide_with_sub_bottom = check_collision(self.x, self.y+1, 16, 8, tgsub.x, tgsub.y, 16, 16)

      -- check for collision with world tiles


      -- check for collision with player
      if (dist_to_player < 8) then
        if (not player.dead) then
          player.dead = true
          sfx(1)
        end
      end

      if (self.state == 'patrol') then
        if (self.patrol_t < patrol_time) then
          if (self.flip_x) then
            self.x+=self.speed
          elseif (not self.flip_x) then
            self.x-=self.speed
          end
        elseif (self.patrol_t >= patrol_time) then
          self.patrol_t = 0
          self.flip_x = not self.flip_x
        end
        self.patrol_t+=1
      end

      if (self.state == 'chase' or self.state == 'attacking') then
        if (self.x < tgsub.x) then
          self.flip_x = true
          if (not collide_with_sub_right) then
            self.x+=self.speed
          else
            self.state = 'attacking'
            self.x-=self.speed+5
            tgsub.crash()
          end
        elseif (self.x > tgsub.x) then
          self.flip_x = false
          if (not collide_with_sub_left) then
            self.x-=self.speed
          else
            self.state = 'attacking'
            self.x+=self.speed+5
            tgsub.crash()
          end
        end

        if (self.y < tgsub.y and not collide_with_sub_bottom) then
          self.y+=self.speed
        elseif (self.y > tgsub.y and not collide_with_sub_top) then
          self.y-=self.speed
        end

      end

      -- watch for tgsub and give chase
      if (dist_to_player < 45) then
        self.state = 'chase'
      else
        self.state = 'patrol'
      end

      self:animate(3)
    end;

    draw=function(self)

      -- DEBUGGING
      -- print('state: '..self.state, self.x-2, self.y-10, 11)
      -- print('dist: '..dst(self, tgsub), self.x-2, self.y-2, 11)
      -- print('patrol_t: '..self.patrol_t, self.x-2, self.y-2, 11)

      -- draw shark animated sprite
      if (self.state == 'attacking') then
        spr(self.attack_frames[flr(self.fr)], self.x, self.y, 2, 1, self.flip_x)
      elseif (self.state == 'chase' or self.state == 'patrol') then
        spr(self.swim_frames[flr(self.fr)], self.x, self.y, 2, 1, self.flip_x)
      end
    end;
  }
end

function tick_frames(self, frame_count)
	self.fr += shark_timing
	if (self.fr > frame_count) then
		self.fr = 1
	end
end