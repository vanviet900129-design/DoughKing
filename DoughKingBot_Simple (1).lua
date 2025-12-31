-- AUTO DOUGH KING - DELTA ONLY
-- Không dùng VirtualInputManager
-- Đánh bằng Tool:Activate()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ================= STATE =================
getgenv().Auto = false
local phase = "cake"

local CakeEnemies = {
    "Cocoa Warrior",
    "Chocolate Bar Battler",
    "Cake Monster"
}

local EliteNames = {
    "Diablo",
    "Urban",
    "Deandre"
}

-- ================= UTILS =================
local function char()
    return player.Character or player.CharacterAdded:Wait()
end

local function hrp()
    return char():WaitForChild("HumanoidRootPart")
end

local function hasItem(name)
    local bp = player.Backpack
    local ch = player.Character
    return bp:FindFirstChild(name) or (ch and ch:FindFirstChild(name))
end

-- AUTO EQUIP + ATTACK (DELTA)
local function equipWeapon()
    local c = char()
    for _, v in pairs(c:GetChildren()) do
        if v:IsA("Tool") then
            return v
        end
    end
    for _, v in pairs(player.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            c.Humanoid:EquipTool(v)
            return v
        end
    end
end

local function attack()
    local tool = equipWeapon()
    if tool then
        tool:Activate()
    end
end

local function tp(cf)
    hrp().CFrame = cf * CFrame.new(0,3,0)
end

local function findEnemy(list)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end

    for _, mob in pairs(enemies:GetChildren()) do
        for _, name in pairs(list) do
            if mob.Name == name
            and mob:FindFirstChild("Humanoid")
            and mob.Humanoid.Health > 0
            and mob:FindFirstChild("HumanoidRootPart") then
                return mob
            end
        end
    end
end

local function eliteAlive()
    return findEnemy(EliteNames) ~= nil
end

-- ================= NO CLIP =================
RunService.Stepped:Connect(function()
    if not getgenv().Auto then return end
    for _, v in pairs(char():GetChildren()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end)

-- ================= GUI =================
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "DK_DELTA"

local f = Instance.new("Frame", gui)
f.Size = UDim2.new(0,260,0,160)
f.Position = UDim2.new(0.05,0,0.3,0)
f.BackgroundColor3 = Color3.fromRGB(40,40,40)

local title = Instance.new("TextLabel", f)
title.Size = UDim2.new(1,0,0,40)
title.Text = "AUTO DOUGH KING (DELTA)"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(200,80,80)

local status = Instance.new("TextLabel", f)
status.Position = UDim2.new(0,0,0.35,0)
status.Size = UDim2.new(1,0,0,30)
status.Text = "Status: OFF"
status.TextColor3 = Color3.new(1,1,1)
status.BackgroundTransparency = 1

local btn = Instance.new("TextButton", f)
btn.Position = UDim2.new(0.15,0,0.65,0)
btn.Size = UDim2.new(0.7,0,0,40)
btn.Text = "START"
btn.BackgroundColor3 = Color3.fromRGB(80,200,80)

btn.MouseButton1Click:Connect(function()
    getgenv().Auto = not getgenv().Auto
    if getgenv().Auto then
        btn.Text = "STOP"
        btn.BackgroundColor3 = Color3.fromRGB(200,80,80)
        status.Text = "Status: RUNNING"
    else
        btn.Text = "START"
        btn.BackgroundColor3 = Color3.fromRGB(80,200,80)
        status.Text = "Status: OFF"
    end
end)

-- ================= MAIN LOOP =================
task.spawn(function()
    while task.wait(0.2) do
        if not getgenv().Auto then continue end

        -- ƯU TIÊN ELITE NẾU SPAWN
        if not hasItem("Sweet Chalice") then
            if eliteAlive() and not hasItem("God's Chalice") then
                phase = "elite"
            else
                phase = "cake"
            end
        else
            phase = "summon"
        end

        -- FARM CAKE
        if phase == "cake" then
            status.Text = "Farm Cake"
            local e = findEnemy(CakeEnemies)
            if e then
                repeat
                    tp(e.HumanoidRootPart.CFrame)
                    attack()
                until e.Humanoid.Health <= 0 or not getgenv().Auto
            end
        end

        -- FARM ELITE
        if phase == "elite" then
            status.Text = "Elite → God's Chalice"
            local e = findEnemy(EliteNames)
            if e then
                repeat
                    tp(e.HumanoidRootPart.CFrame)
                    attack()
                until e.Humanoid.Health <= 0 or not getgenv().Auto
            end
        end

        -- DOUGH KING
        if phase == "summon" then
            status.Text = "Dough King"
            local boss = findEnemy({"Dough King"})
            if boss then
                repeat
                    tp(boss.HumanoidRootPart.CFrame)
                    attack()
                until boss.Humanoid.Health <= 0 or not getgenv().Auto
            end
        end
    end
end)

print("✅ AUTO DOUGH KING DELTA READY")
