require "menu"

--Music created on pulseboy.com--
--Music created on pulseboy.com--
--Music created on pulseboy.com--

--[[
Gamestates:
0 = menu
1 = boulder
2 = goat
3 = bird
4 = score
--]]

--[[
-------TABLE DECLERATIONS-------
--]]
--table for boulder game variable and files
boulderTable = {}
--table for boulder game platform locations
boulderPlatforms = {}
--table for goat game variables and files
goatTable = {}
goatPlatforms = {}
function love.load()
  --[[
  -STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD--STANDARD-
  --]]
  math.randomseed(os.time())
  backgroundQuad = love.graphics.newQuad(1,1,750/2,1334/2,750/2,1334/2)
  gamestate = 0
  previousGamemode = 1
  menuImage = love.graphics.newImage("sprites/Menu.png")
  scoreImage = love.graphics.newImage("sprites/Score text.png")
  menuMusic= love.audio.newSource("sounds/Main_Menu.wav")
  menuMusic:setVolume(0.5)
  deathMusic = love.audio.newSource("sounds/Death-Track.wav")
  deathMusic:setVolume(0.5)
  --[[
  -BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER--BOULDER-
  --]]
  --Load boulder resources
  boulderTable.wall = love.graphics.newImage("sprites/boulder wall.png")
  boulderTable.sides = love.graphics.newImage("sprites/boulder sides.png")
  boulderTable.player = love.graphics.newImage("sprites/boulder.png")
  boulderTable.platform = love.graphics.newImage("sprites/boulder platform.png")
  boulderTable.song = love.audio.newSource("sounds/Boulder Game.wav")
  boulderTable.song:setVolume(0.5)
  --boulder game difficulty 
  boulderTable.Speed = 500
  boulderTable.playerSpeed = 150
  boulderTable.platformGap = 100
  boulderTable.timeLimit = 59.5
  boulderTable.scoreIncrease = 10
  boulderTable.rotate = 0
  --initialise other boulder variables
  boulder_reset()
  --[[
  -GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT--GOAT-
  --]]
  goatTable.wall = love.graphics.newImage("sprites/Goat Background.png")
  goatTable.player = love.graphics.newImage("sprites/goat.png")
  goatTable.platform = love.graphics.newImage("sprites/Goat Platform.png")
  goatTable.lava = love.graphics.newImage("sprites/Lava.png")
  goatTable.song = love.audio.newSource("sounds/Goat Game.wav")
  goatTable.song:setVolume(0.5)
  --goat game difficutly
  goatTable.Speed = 250
  goatTable.playerSpeed = 400
  goatPlatforms.speed = 150 
  --initialise other goat game variables
  goat_reset()
  --[[
  -BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD--BIRD-
  --]]
  --set variables
  alive = true
  rotate = 0
  enemyState = love.math.random(0, 1)
  monkeyRotate = 0
  monkeyRotating = true
  swingDirection = true
  swingAnimation = 0
  movement = 5
  gameSpeed = 350
  score = 0
  drawOne = true
  birdMovement = 0
  --set sounds
  birdMusic = love.audio.newSource("sounds/Bird Game.wav")
  birdMusic:setVolume(0.5)
  --initialise other bird game variables
  bird_reset()
  --draw images and set to variables
  background= love.graphics.newImage("sprites/Bird Background.png")
  backgroundQuad = love.graphics.newQuad(1,1,750/2,1334/2,750/2,1334/2)
  treeEdge = love.graphics.newImage("sprites/Bird Sides.png")
  treeEdge2 = love.graphics.newImage("sprites/Bird Sides.png")
  treeEdgeQuad = love.graphics.newQuad(1,1,770/2,1354/2,770/2,1354/2)
  Sides1Y = 0
  Sides2Y = 667
  player = love.graphics.newImage("sprites/poo covered bird.png")
  playerPosX = 200
  playerPosY = 100
  swingingMonkey = love.graphics.newImage("sprites/swinging monkey.png")
  swingingMonkey2 = love.graphics.newImage("sprites/swinging monkey.png")
  branch = love.graphics.newImage("sprites/swinging monkey branch.png")
  movingMonkey = love.graphics.newImage("sprites/Bird enemy.png")
  movingMonkey2 = love.graphics.newImage("sprites/Bird enemy flip.png")
  movingMonkeyQuad = love.graphics.newQuad(1,1,90,90,90,90)
  swingPosX = love.math.random(30, 300)
  swingPosX2 = love.math.random(30, 300)
  swingPosY = 800
--[[
-MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU--MENU-
--]]
  menu_spawn(125/2, 500/2, 615/2, 750/2, "boulder")
  menu_spawn(125/2, 750/2, 615/2, 1000/2, "goat")
  menu_spawn(125/2, 1025/2, 615/2, 1270/2, "bird")
  
 gameover_spawn(115/2, 700/2, 600/2, 950/2, "retry")
 gameover_spawn(115/2, 1000/2, 600/2, 1250/2, "main-menu"  ) 
  
end
function love.draw()
  love.graphics.setColor(255,255,255)
  if gamestate == 0 then
    love.graphics.draw(menuImage, backgroundQuad, 0, 0)
    end
  --boulder game mode drawing
  if gamestate == 1 then
    boulder_draw()
  end
  if gamestate == 2 then
    goat_draw()
  end 
  if gamestate == 3 then
    bird_draw()
  end
  if gamestate == 4 then
    love.graphics.draw(scoreImage, backgroundQuad, 0, 0)
    love.graphics.setColor(0,0,0)
    if previousGamemode == 1 then
      love.graphics.print(tostring(math.floor(boulderTable.score)), 750/4, 420/2)
    elseif previousGamemode == 2 then
      love.graphics.print(tostring(math.floor(goatTable.score)), 750/4, 420/2)
    elseif previousGamemode == 3 then
      love.graphics.print(tostring(math.floor(score)), 750/4, 420/2)
    end   
  end
end

function love.mousepressed(x,y)
  --menu
  if gamestate == 0 then
    menu_click(x,y)
  end
  --score screen
  if gamestate == 4 then
    gameover_click(x,y)
  end
  --boulder game
  if gamestate == 1 then
    if x <= boulderTable.playerX then
      boulderTable.mouseControl = 1
    elseif x > boulderTable.playerX then
      boulderTable.mouseControl = 2
    end
  end
  --goat game
  if gamestate == 2 then
    if x <= goatTable.playerX then
      goatTable.mouseControl = 1
    elseif x > goatTable.playerX then
      goatTable.mouseControl = 2
    end
  end
  --bird game
  if gamestate == 3 then
    if x <= playerPosX then
      birdMovement = 1
    elseif x > playerPosX then
      birdMovement = 2
    end
  end
end


function love.mousereleased(x, y, button)
   if button == 1 then
      if gamestate == 1 then
        boulderTable.mouseControl = 0
      end
      if gamestate == 2 then
        goatTable.mouseControl = 0
      end
      if gamestate == 3 then
        birdMovement = 0
        end
   end
end


function love.update(dt)
  if gamestate == 0 then
    menuMusic:play()
  end
  if gamestate == 1 then   
    menuMusic:stop()
    boulder_game(dt)
  elseif gamestate == 2 then
    menuMusic:stop()
    goat_game(dt)
  elseif gamestate == 3 then
  menuMusic:stop()
    bird_game(dt)
end
end
--[[
Boulder game functions
--]]
function boulder_game(dt)
  --Timer and music
  boulderTable.time = boulderTable.time - (1 * dt)
  
  boulderTable.song:play()
  if boulderTable.time <= 0 then
    gamestate = 4 
    boulderTable.song:stop()
    deathMusic:play()
    end -- end game after time limit 
  --platform movement and scoring
  if touchingPlatform == 0 then
  boulderPlatforms.lPosY1 = boulderPlatforms.lPosY1 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY2 = boulderPlatforms.lPosY2 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY3 = boulderPlatforms.lPosY3 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY4 = boulderPlatforms.lPosY4 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY5 = boulderPlatforms.lPosY5 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY6 = boulderPlatforms.lPosY6 - (boulderTable.Speed * dt)
  boulderPlatforms.lPosY7 = boulderPlatforms.lPosY7 - (boulderTable.Speed * dt)
  boulderPlatforms.rPosY1 = boulderPlatforms.lPosY1
  boulderPlatforms.rPosY2 = boulderPlatforms.lPosY2
  boulderPlatforms.rPosY3 = boulderPlatforms.lPosY3
  boulderPlatforms.rPosY4 = boulderPlatforms.lPosY4
  boulderPlatforms.rPosY5 = boulderPlatforms.lPosY5
  boulderPlatforms.rPosY6 = boulderPlatforms.lPosY6
  boulderPlatforms.rPosY7 = boulderPlatforms.lPosY7
  boulderTable.score = boulderTable.score + (boulderTable.scoreIncrease * dt)
  end

--player movement
  if love.keyboard.isDown('d') or boulderTable.mouseControl == 2 then
  boulderTable.playerX = boulderTable.playerX + (boulderTable.playerSpeed * dt)
  
  boulderTable.rotate = boulderTable.rotate + 3.141
  end
  if love.keyboard.isDown('a') or boulderTable.mouseControl == 1 then
  boulderTable.playerX = boulderTable.playerX - (boulderTable.playerSpeed * dt)
  
  boulderTable.rotate = boulderTable.rotate - 3.141
end
if boulderTable.playerX <= 0 then boulderTable.playerX = 0 end
if boulderTable.playerX + boulderTable.player:getWidth() >= 750/2 then
  boulderTable.playerX =  750/2 - boulderTable.player:getWidth() end

  --platform reset at top of screen with random position
  if(boulderPlatforms.lPosY1 <= -40) then
    boulderPlatforms.lPosY1 = 1334/2
    boulderPlatforms.rPosY1 = boulderPlatforms.lPosY1
    boulderPlatforms.lPosX1 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX1 = boulderPlatforms.lPosX1 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY2 <= -40) then
    boulderPlatforms.lPosY2 = 1334/2
    boulderPlatforms.rPosY2 = boulderPlatforms.lPosY2
    boulderPlatforms.lPosX2 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX2 = boulderPlatforms.lPosX2 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY3 <= -40) then
    boulderPlatforms.lPosY3 = 1334/2
    boulderPlatforms.rPosY3 = boulderPlatforms.lPosY3
    boulderPlatforms.lPosX3 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX3 = boulderPlatforms.lPosX3 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY4 <= -40) then
    boulderPlatforms.lPosY4 = 1334/2
    boulderPlatforms.rPosY4 = boulderPlatforms.lPosY4
    boulderPlatforms.lPosX4 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX4 = boulderPlatforms.lPosX4 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY5 <= -40) then
    boulderPlatforms.lPosY5 = 1334/2
    boulderPlatforms.rPosY5 = boulderPlatforms.lPosY5
    boulderPlatforms.lPosX5 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX5 = boulderPlatforms.lPosX5 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY6 <= -40) then
    boulderPlatforms.lPosY6 = 1334/2
    boulderPlatforms.rPosY6 = boulderPlatforms.lPosY6
    boulderPlatforms.lPosX6 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX6 = boulderPlatforms.lPosX6 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end
  if(boulderPlatforms.lPosY7 <= -40) then
    boulderPlatforms.lPosY7 = 1334/2
    boulderPlatforms.rPosY7 = boulderPlatforms.lPosY7
    boulderPlatforms.lPosX7 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
    boulderPlatforms.rPosX7 = boulderPlatforms.lPosX7 + boulderTable.platform:getWidth() + boulderTable.platformGap
  end

--test collision code
if CheckCollision(boulderPlatforms.lPosX1, boulderPlatforms.lPosY1, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or 
    CheckCollision(boulderPlatforms.rPosX1, boulderPlatforms.rPosY1, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX2, boulderPlatforms.lPosY2, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX2, boulderPlatforms.rPosY2, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX3, boulderPlatforms.lPosY3, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX3, boulderPlatforms.rPosY3, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX4, boulderPlatforms.lPosY4, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX4, boulderPlatforms.rPosY4, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX5, boulderPlatforms.lPosY5, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX5, boulderPlatforms.rPosY5, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX6, boulderPlatforms.lPosY6, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX6, boulderPlatforms.rPosY6, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.lPosX7, boulderPlatforms.lPosY7, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    or
    CheckCollision(boulderPlatforms.rPosX7, boulderPlatforms.rPosY7, boulderTable.platform:getWidth(), 1,
      boulderTable.playerX - boulderTable.player:getWidth()/2, boulderTable.playerY - boulderTable.player:getHeight()/2, boulderTable.player:getWidth(), boulderTable.player:getHeight())
    then touchingPlatform = 1
    else touchingPlatform = 0
end
end
function boulder_reset()
  -- basic variables
  boulderTable.playerX = 150
  boulderTable.playerY = 100
  boulderTable.touchingPlatform = 0
  boulderTable.time = boulderTable.timeLimit
  boulderTable.score = 0
  boulderTable.gameover = 0
  
  --LEFT boulderPlatforms
  boulderPlatforms.lPosY1 = 1334/5
  boulderPlatforms.lPosX1 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY2 = boulderPlatforms.lPosY1 + 200
  boulderPlatforms.lPosX2 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY3 = boulderPlatforms.lPosY2 + 200
  boulderPlatforms.lPosX3 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY4 = boulderPlatforms.lPosY3 + 200
  boulderPlatforms.lPosX4 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY5 = boulderPlatforms.lPosY4 + 200
  boulderPlatforms.lPosX5 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY6 = boulderPlatforms.lPosY5 + 200
  boulderPlatforms.lPosX6 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  boulderPlatforms.lPosY7 = boulderPlatforms.lPosY6 + 200
  boulderPlatforms.lPosX7 = -(math.random() * (boulderTable.platform:getWidth() - 250)) - 300
  --RIGHT boulderPlatforms
  boulderPlatforms.rPosY1 = boulderPlatforms.lPosY1
  boulderPlatforms.rPosX1 = boulderPlatforms.lPosX1 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY2 = boulderPlatforms.lPosY2
  boulderPlatforms.rPosX2 = boulderPlatforms.lPosX2 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY3 = boulderPlatforms.lPosY3
  boulderPlatforms.rPosX3 = boulderPlatforms.lPosX3 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY4 = boulderPlatforms.lPosY4
  boulderPlatforms.rPosX4 = boulderPlatforms.lPosX4 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY5 = boulderPlatforms.lPosY5
  boulderPlatforms.rPosX5 = boulderPlatforms.lPosX5 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY6 = boulderPlatforms.lPosY6
  boulderPlatforms.rPosX6 = boulderPlatforms.lPosX6 + boulderTable.platform:getWidth() + boulderTable.platformGap
  boulderPlatforms.rPosY7 = boulderPlatforms.lPosY7
  boulderPlatforms.rPosX7 = boulderPlatforms.lPosX7 + boulderTable.platform:getWidth() + boulderTable.platformGap
end

function boulder_draw()
  if boulderTable.gameover == 0 then
  --all boulder graphics
      --boulder backgorund
  love.graphics.draw(boulderTable.wall, backgroundQuad, 0, 0)
      --boulder boulderPlatforms
      -- left
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX1, boulderPlatforms.lPosY1)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX2, boulderPlatforms.lPosY2)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX3, boulderPlatforms.lPosY3)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX4, boulderPlatforms.lPosY4)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX5, boulderPlatforms.lPosY5)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX6, boulderPlatforms.lPosY6)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.lPosX7, boulderPlatforms.lPosY7)
      --right
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX1, boulderPlatforms.rPosY1)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX2, boulderPlatforms.rPosY2)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX3, boulderPlatforms.rPosY3)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX4, boulderPlatforms.rPosY4)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX5, boulderPlatforms.rPosY5)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX6, boulderPlatforms.rPosY6)
  love.graphics.draw(boulderTable.platform, boulderPlatforms.rPosX7, boulderPlatforms.rPosY7)
      --player
  love.graphics.draw(boulderTable.player, boulderTable.playerX, boulderTable.playerY, math.rad(boulderTable.rotate),1 ,1 , boulderTable.player:getWidth()/2, boulderTable.player:getHeight()/2)
  --sides
  love.graphics.draw(boulderTable.sides, backgroundQuad, 0, 0)
  
-- time and score
love.graphics.print("Time: "..tostring(math.floor(boulderTable.time)), 270, 2)
love.graphics.print("Score: "..tostring(math.floor(boulderTable.score)), 2, 2)

else
love.graphics.draw(boulderTable.wall, backgroundQuad, 0, 0)
love.graphics.draw(boulderTable.sides, backgroundQuad, 0, 0)
love.graphics.draw(scoreImage, -15, 0)
end
end

--[[
Goat game functions
--]]
function goat_game(dt)
  goatTable.song:play()
  goatTable.score = goatTable.score + (1 * dt)
  goatTable.lavaPos = goatTable.lavaPos - (300 * dt) 
  goatTable.lavaPos2 = goatTable.lavaPos + goatTable.lava:getWidth()
  if goatTable.lavaPos <= -1 * goatTable.lava:getWidth() then
    goatTable.lavaPos = 0
    goatTable.lavaPos2 = goatTable.lavaPos + goatTable.lava:getWidth()
  end
  --player movement
  if love.keyboard.isDown('d') then
  goatTable.playerX = goatTable.playerX + (goatTable.playerSpeed * dt)
  end
  if love.keyboard.isDown('a') then
  goatTable.playerX = goatTable.playerX - (goatTable.playerSpeed * dt)
end
if goatTable.playerX <= 0 then goatTable.playerX = 0 end
if goatTable.playerX + goatTable.player:getWidth() >= 750/2 then
  goatTable.playerX =  750/2 - goatTable.player:getWidth() end
  goatPlatforms.PosY1 = goatPlatforms.PosY1 - (goatTable.Speed * dt)
  goatPlatforms.PosY2 = goatPlatforms.PosY2 - (goatTable.Speed * dt)
  goatPlatforms.PosY3 = goatPlatforms.PosY3 - (goatTable.Speed * dt)
  --platform reset at top of screen with random position
  if(goatPlatforms.PosY1 <= -40) then
    goatPlatforms.PosY1 = 1334/2
    goatPlatforms.PosX1 = math.random() * (750/2 - goatTable.platform:getWidth())
    goatPlatforms.Movement1 = math.random(0,1)
  end
  if(goatPlatforms.PosY2 <= -40) then
    goatPlatforms.PosY2 = 1334/2
    goatPlatforms.PosX2 = math.random() * (750/2 - goatTable.platform:getWidth())
    goatPlatforms.Movement2 = math.random(0,1)
  end
  if(goatPlatforms.PosY3 <= -40) then
    goatPlatforms.PosY3 = 1334/2
    goatPlatforms.PosX3 = math.random() * (750/2 - goatTable.platform:getWidth())
    goatPlatforms.Movement3 = math.random(0,1)
  end

if CheckCollision(goatPlatforms.PosX1, goatPlatforms.PosY1, goatTable.platform:getWidth(), 1,
      goatTable.playerX, goatTable.playerY, goatTable.player:getWidth(), goatTable.player:getHeight())
    or
    CheckCollision(goatPlatforms.PosX2, goatPlatforms.PosY2, goatTable.platform:getWidth(), 1,
      goatTable.playerX, goatTable.playerY, goatTable.player:getWidth(), goatTable.player:getHeight())
    or
    CheckCollision(goatPlatforms.PosX3, goatPlatforms.PosY3, goatTable.platform:getWidth(), 1,
      goatTable.playerX, goatTable.playerY, goatTable.player:getWidth(), goatTable.player:getHeight())
    then goatTable.playerY = goatTable.playerY - (goatTable.Speed * dt)
  elseif CheckCollision(goatTable.lavaPos, -150, goatTable.lava:getWidth(), goatTable.lava:getHeight(),
      goatTable.playerX, goatTable.playerY, goatTable.player:getWidth(), goatTable.player:getHeight())
    or
    CheckCollision(goatTable.lavaPos2, -150, goatTable.lava:getWidth(), goatTable.lava:getHeight(),
      goatTable.playerX, goatTable.playerY, goatTable.player:getWidth(), goatTable.player:getHeight())
    then
      gamestate = 4
      goatTable.song:stop()
      deathMusic:play()
  end 
  
  if goatPlatforms.Movement1 == 1 then
    goatPlatforms.PosX1 =  goatPlatforms.PosX1 + (goatPlatforms.speed * dt)
  else 
    goatPlatforms.PosX1 =  goatPlatforms.PosX1 - (goatPlatforms.speed * dt)
  end 
   if goatPlatforms.Movement2 == 1 then
    goatPlatforms.PosX2 =  goatPlatforms.PosX2 + (goatPlatforms.speed * dt)
  else 
    goatPlatforms.PosX2 =  goatPlatforms.PosX2 - (goatPlatforms.speed * dt)
  end 
   if goatPlatforms.Movement2 == 1 then
    goatPlatforms.PosX3 =  goatPlatforms.PosX3 + (goatPlatforms.speed * dt)
  else 
    goatPlatforms.PosX3 =  goatPlatforms.PosX3 - (goatPlatforms.speed * dt)
  end 
  
  if goatPlatforms.PosX1 <= -goatTable.platform:getWidth()/2 then
    goatPlatforms.Movement1 = 1
  end
  if goatPlatforms.PosX2 <= -goatTable.platform:getWidth()/2 then
    goatPlatforms.Movement2 = 1
  end
  if goatPlatforms.PosX3 <= -goatTable.platform:getWidth()/2 then
    goatPlatforms.Movement3 = 1
  end
  
  if  goatPlatforms.PosX1 >= (750/2 - goatTable.platform:getWidth()/2) then
    goatPlatforms.Movement1 = 0
  end
  if  goatPlatforms.PosX2 >= (750/2 - goatTable.platform:getWidth()/2) then
    goatPlatforms.Movement2 = 0
  end
  if  goatPlatforms.PosX3 >= (750/2 - goatTable.platform:getWidth()/2) then
    goatPlatforms.Movement3 = 0
  end
end

function goat_reset()
  -- basic variables
  goatTable.playerX = 150
  goatTable.playerY = 450
  goatTable.score = 0
  goatTable.gameover = 0
  goatTable.lavaPos = 0
  goatTable.lavaPos2 = goatTable.lavaPos + goatTable.lava:getWidth()
  
  --platforms
  goatPlatforms.Movement1 = 1
  goatPlatforms.Movement2 = 1
  goatPlatforms.Movement3 = 1
  --platform positions 
  goatPlatforms.PosY1 = 1334/2
  goatPlatforms.PosX1 = -goatTable.platform:getWidth()/2 + math.random() * (750/2 + goatTable.platform:getWidth()/2)
  goatPlatforms.PosY2 = goatPlatforms.PosY1 + 250
  goatPlatforms.PosX2 = -goatTable.platform:getWidth()/2 + math.random() * (750/2 + goatTable.platform:getWidth()/2)
  goatPlatforms.PosY3 = goatPlatforms.PosY2 + 250
  goatPlatforms.PosX3 = -goatTable.platform:getWidth()/2 + math.random() * (750/2 + goatTable.platform:getWidth()/2)
end
function goat_draw()
  if goatTable.gameover == 0 then
  love.graphics.draw(goatTable.wall, backgroundQuad, 0, 0)
  love.graphics.draw(goatTable.platform, goatPlatforms.PosX1, goatPlatforms.PosY1)
  love.graphics.draw(goatTable.platform, goatPlatforms.PosX2, goatPlatforms.PosY2)
  love.graphics.draw(goatTable.platform, goatPlatforms.PosX3, goatPlatforms.PosY3)
  love.graphics.draw(goatTable.player, goatTable.playerX, goatTable.playerY)
  love.graphics.draw(goatTable.lava, goatTable.lavaPos, -150)
  love.graphics.draw(goatTable.lava, goatTable.lavaPos2, -150)
  love.graphics.print("Score: "..tostring(math.floor(goatTable.score)), 2, 2)
  else
    love.graphics.draw(goatTable.wall, backgroundQuad, 0, 0)
    love.graphics.draw(goatTable.lava, goatTable.lavaPos, 0)
    love.graphics.draw(goatTable.lava, goatTable.lavaPos2, 0)
    love.graphics.draw(scoreImage, -15, -30)
  end
end

--[[
Bird game functions
--]]
function bird_game(dt)
  if alive == true then
    birdMusic:play()
  
    --scoring
    score = score + dt
  
    --moving enemy
    swingPosY = swingPosY - (gameSpeed * dt)
  
    if swingPosY < -80 then
    
      if score > 29 then
        drawOne = false
      end
    
      swingPosY = 667
      swingPosX = love.math.random(30, 300)
      enemyState = love.math.random(0, 1)
    end
  
    if enemyState == 1 then
      if swingDirection == true then
        swingPosX = swingPosX + ((gameSpeed / 2) * dt)
      
        if swingPosX > 360 then
          swingDirection = false
        end
      end
      if swingDirection == false then
        swingPosX = swingPosX - ((gameSpeed / 2) * dt)
      
        if swingPosX < 0 then
          swingDirection = true
        end
      end
    
      swingAnimation = swingAnimation + dt
      if swingAnimation > 0.9 then
        swingAnimation = 0
      end
    end
  
    if monkeyRotating == true then
      monkeyRotate = monkeyRotate + 2
    
      if monkeyRotate > 40 then
        monkeyRotating = false
      end
    end
    if monkeyRotating == false then
      monkeyRotate = monkeyRotate - 2
    
      if monkeyRotate < -40 then
        monkeyRotating = true
      end
    end
  
    --moving background
    Sides1Y = Sides1Y - (gameSpeed * dt)
    Sides2Y = Sides2Y - (gameSpeed * dt)
  
    if score > 3 and score < 20 then
      gameSpeed = gameSpeed + (score / 100)
    end
  
    if Sides1Y < -666 then
      Sides1Y = 667
    end
    if Sides2Y < -666 then
      Sides2Y = 667
    end
  end
  
  --collision
  if enemyState == 0 then
    hitbox = CheckCollision(playerPosX, playerPosY, 39, 45, (swingPosX + 10 - monkeyRotate), (swingPosY + 40), 40, 60)
    if hitbox == true and (playerPosX - swingPosX) < 0 and monkeyRotate < 0 then
      birdKilled()
    end
    if hitbox == true and (playerPosX - swingPosX) > 0 and monkeyRotate > 0 then
      birdKilled()
    end
    hitbox = CheckCollision(playerPosX, playerPosY, 39, 45, (swingPosX + 10 - monkeyRotate), (swingPosY + 40), 40, 60)
    if hitbox == true then
      birdKilled()
    end
  end
  if enemyState == 1 then
    hitbox = CheckCollision(playerPosX, playerPosY, 39, 45, (swingPosX + 20), (swingPosY + 45), 65, 60)
    if hitbox == true then
      birdKilled()
    end
  end
end
function bird_reset()
    alive = true
  rotate = 0
  enemyState = love.math.random(0, 1)
  monkeyRotate = 0
  monkeyRotating = true
  swingDirection = true
  swingAnimation = 0
  score = 0
  drawOne = true
  playerPosX = 200
  playerPosY = 100
  swingPosY = 800
  Sides1Y = 0
  Sides2Y = 667
  
end
function bird_draw()
  --draw enemies and background
  
  love.graphics.draw(background, backgroundQuad, 0, 0)
  
  love.graphics.draw(branch, 0, swingPosY)
  
  if score < 30 then
    drawOne = true
  end
  
  if enemyState == 0 then
    if drawOne == true then
      love.graphics.draw(swingingMonkey, swingPosX, swingPosY, math.rad(monkeyRotate), 1, 1, 30, 0)
    end
    if drawOne == false then
      love.graphics.draw(swingingMonkey, swingPosX, swingPosY, math.rad(monkeyRotate), 1, 1, 30, 0)
      love.graphics.draw(swingingMonkey2, swingPosX2, swingPosY, math.rad(monkeyRotate), 1, 1, 30, 0)
    end
  end
  if enemyState == 1 then
    if swingAnimation < 0.5 then
      love.graphics.draw(movingMonkey, movingMonkeyQuad, swingPosX, swingPosY)
    end
    if swingAnimation > 0.5 and swingAnimation < 1 then
      love.graphics.draw(movingMonkey2, movingMonkeyQuad, swingPosX, swingPosY)
    end
  end
  --draw sides
  love.graphics.draw(treeEdge, treeEdgeQuad, 0, Sides1Y)
  love.graphics.draw(treeEdge2, treeEdgeQuad, 0, Sides2Y)
  
  love.graphics.draw(player, playerPosX, playerPosY, math.rad(rotate), 1, 1, 22.5, 22.5)
  
  game_screen()
end
function birdKilled() -- player dies
  alive = false
  birdMusic:stop()
  deathMusic:play()
end

function game_screen() -- what can be seen by the player
  
  --showing score
  love.graphics.print(math.floor(score), 330, 10)
  
  --moving player
  if love.keyboard.isDown("d") or birdMovement == 2 then
      playerPosX = playerPosX + movement
      
      if rotate > -40 then
        rotate = rotate - 8
      end
  end
  if love.keyboard.isDown("a") or birdMovement == 1  then
      playerPosX = playerPosX - movement
      
      if rotate < 40 then
        rotate = rotate + 8
      end
  end
  
  --setting boundaries
  if playerPosX < 20 then
    playerPosX = 20
  end
  if playerPosX > 360 then
    playerPosX = 360
  end
  
  --rotation of player
  if rotate < 0 then
    rotate = rotate + 4
  end
  if rotate > 0 then
    rotate = rotate - 4
  end
  
  --player dies
  if alive == false then
    playerPosY = playerPosY + 10
    rotate = rotate + 25
  end
  
  if playerPosY > 700 then
    gamestate = 4
  end
end

--Universal collision test function
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
