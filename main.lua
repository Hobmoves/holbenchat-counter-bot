-- holbenchat-counter — HolbenChat Bot

function events.command.maze(ctx)
  math.randomseed(os.time())

local width = 21   -- must be odd
local height = 21  -- must be odd

-- Fill maze with walls
local maze = {}
for y = 1, height do
    maze[y] = {}
    for x = 1, width do
        maze[y][x] = "#"
    end
end

local directions = {
    { 0, -2 }, -- up
    { 2,  0 }, -- right
    { 0,  2 }, -- down
    {-2,  0 }  -- left
}

local function shuffle(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

local function carve(x, y)
    maze[y][x] = " "

    local dirs = {}
    for i = 1, #directions do
        dirs[i] = directions[i]
    end

    shuffle(dirs)

    for _, dir in ipairs(dirs) do
        local dx, dy = dir[1], dir[2]
        local nx, ny = x + dx, y + dy

        if nx > 1 and nx < width and ny > 1 and ny < height then
            if maze[ny][nx] == "#" then
                maze[y + dy // 2][x + dx // 2] = " "
                carve(nx, ny)
            end
        end
    end
end

-- Generate maze
carve(2, 2)

-- Entrance and exit
maze[2][1] = " "
maze[height - 1][width] = " "

-- Print maze
for y = 1, height do
    ctx.reply(table.concat(maze[y]))
end
end
