menuButtons = {}
scoreButtons = {}
function menu_spawn(x,y,x2,y2,id)
  table.insert(menuButtons, {x = x ,y = y , x2 = x2, y2 = y2, id = id})
end

function gameover_spawn(x,y,x2,y2,id)
  table.insert(menuButtons, {x = x ,y = y , x2 = x2, y2 = y2, id = id})
end


 
function menu_click(x,y)
  for i,v in ipairs(menuButtons) do
    
    if x > v.x and
       y > v.y and 
       x < v.x2 and
       y < v.y2 then
         
      if v.id == "boulder" then
        boulder_reset()
        gamestate = 1
        previousGamemode = 1
      end
      if v.id == "goat" then
        goat_reset()
         gamestate = 2
         previousGamemode = 2
      end
      if v.id == "bird" then
        bird_reset()
        gamestate = 3
        previousGamemode = 3
      end
    end 
  end
end

function gameover_click(x,y)
  for i,v in ipairs(menuButtons) do
    
    if x > v.x and
       y > v.y and 
       x < v.x2 and
       y < v.y2 then
         
      if v.id == "retry" then
        deathMusic:stop()
        gamestate = previousGamemode
        boulder_reset()
        goat_reset()
        bird_reset()
      end
      if v.id == "main-menu" then
        deathMusic:stop()
        gamestate = 0
      end
      
    end 
  end
  end