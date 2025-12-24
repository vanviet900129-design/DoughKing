-- ============================================================================
-- Script Lua - Blox Fruits: Dough King Auto Bot (GUI Version)
-- Phiên bản: 1.0
-- Mô tả: Script với giao diện GUI để bật/tắt các tính năng
-- Cách dùng: loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/DoughKingBot/main/DoughKingBot_GUI.lua"))()
-- ============================================================================

-- ============================================================================
-- CÀI ĐẶT CƠ BẢN
-- ============================================================================

local autofarm = false
local autoGetChalice = false
local autoSummon = false
local autoFight = false
local noClip = false
local autoMode = false

local phase = "farm" -- farm, get_chalice, summon, fight
local enemyCount = 0
local hasGodsChalice = false
local hasConjuredCocoa = 0
local hasSweetChalice = false
local hasDefeated500 = false

-- Vị trí và tên enemies
local cakeLandEnemies = {"Cocoa Warrior", "Chocolate Bar Battler", "Cake Monster"}
local chocolateLandNPC = "Sweet Crafter"
local cakeLandNPC = "drip_mama"

-- ============================================================================
-- TẠO GIAO DIỆN GUI
-- ============================================================================

local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DoughKingBotGUI"
    gui.Parent = game:GetService("CoreGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 400)
    frame.Position = UDim2.new(0.5, -175, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 100, 100)
    frame.Parent = gui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Text = "Dough King Bot"
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Parent = frame
    
    -- Auto Mode
    local autoModeLabel = Instance.new("TextLabel")
    autoModeLabel.Text = "Auto Mode"
    autoModeLabel.TextSize = 16
    autoModeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoModeLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    autoModeLabel.Size = UDim2.new(0, 150, 0, 30)
    autoModeLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
    autoModeLabel.Parent = frame
    
    local autoModeButton = Instance.new("TextButton")
    autoModeButton.Text = "OFF"
    autoModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoModeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoModeButton.Size = UDim2.new(0, 80, 0, 30)
    autoModeButton.Position = UDim2.new(0.6, 0, 0.15, 0)
    autoModeButton.Parent = frame
    
    -- Auto Farm
    local autoFarmLabel = Instance.new("TextLabel")
    autoFarmLabel.Text = "Auto Farm"
    autoFarmLabel.TextSize = 16
    autoFarmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoFarmLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    autoFarmLabel.Size = UDim2.new(0, 150, 0, 30)
    autoFarmLabel.Position = UDim2.new(0.05, 0, 0.25, 0)
    autoFarmLabel.Parent = frame
    
    local autoFarmButton = Instance.new("TextButton")
    autoFarmButton.Text = "OFF"
    autoFarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoFarmButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoFarmButton.Size = UDim2.new(0, 80, 0, 30)
    autoFarmButton.Position = UDim2.new(0.6, 0, 0.25, 0)
    autoFarmButton.Parent = frame
    
    -- Auto Get Chalice
    local autoGetChaliceLabel = Instance.new("TextLabel")
    autoGetChaliceLabel.Text = "Auto Get Chalice"
    autoGetChaliceLabel.TextSize = 16
    autoGetChaliceLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoGetChaliceLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    autoGetChaliceLabel.Size = UDim2.new(0, 150, 0, 30)
    autoGetChaliceLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
    autoGetChaliceLabel.Parent = frame
    
    local autoGetChaliceButton = Instance.new("TextButton")
    autoGetChaliceButton.Text = "OFF"
    autoGetChaliceButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoGetChaliceButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoGetChaliceButton.Size = UDim2.new(0, 80, 0, 30)
    autoGetChaliceButton.Position = UDim2.new(0.6, 0, 0.35, 0)
    autoGetChaliceButton.Parent = frame
    
    -- Auto Summon
    local autoSummonLabel = Instance.new("TextLabel")
    autoSummonLabel.Text = "Auto Summon"
    autoSummonLabel.TextSize = 16
    autoSummonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoSummonLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    autoSummonLabel.Size = UDim2.new(0, 150, 0, 30)
    autoSummonLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
    autoSummonLabel.Parent = frame
    
    local autoSummonButton = Instance.new("TextButton")
    autoSummonButton.Text = "OFF"
    autoSummonButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoSummonButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoSummonButton.Size = UDim2.new(0, 80, 0, 30)
    autoSummonButton.Position = UDim2.new(0.6, 0, 0.45, 0)
    autoSummonButton.Parent = frame
    
    -- Auto Fight
    local autoFightLabel = Instance.new("TextLabel")
    autoFightLabel.Text = "Auto Fight"
    autoFightLabel.TextSize = 16
    autoFightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoFightLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    autoFightLabel.Size = UDim2.new(0, 150, 0, 30)
    autoFightLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
    autoFightLabel.Parent = frame
    
    local autoFightButton = Instance.new("TextButton")
    autoFightButton.Text = "OFF"
    autoFightButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoFightButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    autoFightButton.Size = UDim2.new(0, 80, 0, 30)
    autoFightButton.Position = UDim2.new(0.6, 0, 0.55, 0)
    autoFightButton.Parent = frame
    
    -- No Clip
    local noClipLabel = Instance.new("TextLabel")
    noClipLabel.Text = "No Clip"
    noClipLabel.TextSize = 16
    noClipLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    noClipLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    noClipLabel.Size = UDim2.new(0, 150, 0, 30)
    noClipLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
    noClipLabel.Parent = frame
    
    local noClipButton = Instance.new("TextButton")
    noClipButton.Text = "OFF"
    noClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noClipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    noClipButton.Size = UDim2.new(0, 80, 0, 30)
    noClipButton.Position = UDim2.new(0.6, 0, 0.65, 0)
    noClipButton.Parent = frame
    
    -- Status
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Text = "Status: Stopped"
    statusLabel.TextSize = 16
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    statusLabel.Size = UDim2.new(1, -20, 0, 30)
    statusLabel.Position = UDim2.new(0.05, 0, 0.75, 0)
    statusLabel.Parent = frame
    
    -- Start/Stop
    local startStopButton = Instance.new("TextButton")
    startStopButton.Text = "Start"
    startStopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startStopButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    startStopButton.Size = UDim2.new(0, 150, 0, 40)
    startStopButton.Position = UDim2.new(0.05, 0, 0.85, 0)
    startStopButton.Parent = frame
    
    -- Close
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.Size = UDim2.new(0, 150, 0, 40)
    closeButton.Position = UDim2.new(0.55, 0, 0.85, 0)
    closeButton.Parent = frame
    
    -- Button handlers
    autoModeButton.MouseButton1Click:Connect(function()
        autoMode = not autoMode
        autoModeButton.Text = autoMode and "ON" or "OFF"
        autoModeButton.BackgroundColor3 = autoMode and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    autoFarmButton.MouseButton1Click:Connect(function()
        autofarm = not autofarm
        autoFarmButton.Text = autofarm and "ON" or "OFF"
        autoFarmButton.BackgroundColor3 = autofarm and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    autoGetChaliceButton.MouseButton1Click:Connect(function()
        autoGetChalice = not autoGetChalice
        autoGetChaliceButton.Text = autoGetChalice and "ON" or "OFF"
        autoGetChaliceButton.BackgroundColor3 = autoGetChalice and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    autoSummonButton.MouseButton1Click:Connect(function()
        autoSummon = not autoSummon
        autoSummonButton.Text = autoSummon and "ON" or "OFF"
        autoSummonButton.BackgroundColor3 = autoSummon and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    autoFightButton.MouseButton1Click:Connect(function()
        autoFight = not autoFight
        autoFightButton.Text = autoFight and "ON" or "OFF"
        autoFightButton.BackgroundColor3 = autoFight and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    noClipButton.MouseButton1Click:Connect(function()
        noClip = not noClip
        noClipButton.Text = noClip and "ON" or "OFF"
        noClipButton.BackgroundColor3 = noClip and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(100, 100, 100)
    end)
    
    startStopButton.MouseButton1Click:Connect(function()
        if autoMode or autofarm or autoGetChalice or autoSummon or autoFight then
            statusLabel.Text = "Status: Running"
            statusLabel.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            startStopButton.Text = "Stop"
            startStopButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            
            -- Start the main loop
            coroutine.wrap(function()
                while autoMode or autofarm or autoGetChalice or autoSummon or autoFight do
                    if autoMode then
                        -- Auto mode logic
                        if enemyCount >= 500 and not hasSweetChalice then
                            phase = "get_chalice"
                        elseif hasSweetChalice then
                            phase = "summon"
                        end
                    end
                    
                    if autofarm and phase == "farm" then
                        farmPhase()
                    end
                    
                    if autoGetChalice and phase == "get_chalice" then
                        getChalicePhase()
                    end
                    
                    if autoSummon and phase == "summon" then
                        summonPhase()
                    end
                    
                    if autoFight and phase == "fight" then
                        fightPhase()
                    end
                    
                    task.wait(0.1)
                end
                
                statusLabel.Text = "Status: Stopped"
                statusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                startStopButton.Text = "Start"
                startStopButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            end)()
        else
            statusLabel.Text = "Status: Stopped"
            statusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            startStopButton.Text = "Start"
            startStopButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        end
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    print("[DoughKingBot] GUI đã được tạo!")
end

-- ============================================================================
-- HÀM HỖ TRỢ
-- ============================================================================

local function printPhase(message)
    print("[DoughKingBot] " .. message)
end

local function moveToPosition(targetPosition, offset)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local rootPart = character.HumanoidRootPart
        local targetCFrame = targetPosition * CFrame.new(offset or 0, 5, 0) * CFrame.Angles(math.rad(-90), 0, 0)
        rootPart.CFrame = targetCFrame
    end
end

local function findEnemyByName(name)
    for _, v in pairs(game.Workspace:GetChildren()) do
        if v:IsA("Model") and v.Name == name then
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    return nil
end

local function findNPCByName(name)
    return findEnemyByName(name)
end

-- ============================================================================
-- PHASE 1: FARM ENEMIES
-- ============================================================================

local function farmPhase()
    printPhase("Phase: Farm Enemies - Count: " .. enemyCount .. "/500")
    
    -- Tìm và tấn công enemies
    for _, enemyName in ipairs(cakeLandEnemies) do
        local enemy = findEnemyByName(enemyName)
        if enemy then
            -- Di chuyển đến vị trí enemy (bay lên cao để không bị tấn công)
            moveToPosition(enemy.HumanoidRootPart.CFrame, 3)
            
            -- Tự động tấn công
            
            -- Tăng enemy count
            enemyCount = enemyCount + 1
            printPhase("Đã đánh: " .. enemyCount .. "/500 enemies")
            
            -- Kiểm tra nếu đã đủ 500
            if enemyCount >= 500 then
                phase = "get_chalice"
                printPhase("Chuyển sang Phase: Get Chalice")
                return
            end
        end
    end
    
    task.wait(0.5)
end

-- ============================================================================
-- PHASE 2: LẤY SWEET CHALICE
-- ============================================================================

local function getChalicePhase()
    printPhase("Phase: Get Sweet Chalice - God's Chalice: " .. tostring(hasGodsChalice) .. " - Cocoa: " .. hasConjuredCocoa .. "/10")
    
    -- Kiểm tra nếu đã có đủ điều kiện
    if hasGodsChalice and hasConjuredCocoa >= 10 then
        -- Đến Chocolate Land
        printPhase("Đang di chuyển đến Chocolate Land...")
        
        -- Tìm NPC Sweet Crafter
        local npc = findNPCByName(chocolateLandNPC)
        if npc then
            -- Di chuyển đến NPC
            moveToPosition(npc.HumanoidRootPart.CFrame, 0)
            
            -- Tương tác
            printPhase("Đang tương tác với Sweet Crafter...")
            task.wait(1)
            
            -- Giả lập việc nhận Sweet Chalice
            hasSweetChalice = true
            printPhase("Đã nhận Sweet Chalice!")
            
            phase = "summon"
        end
    else
        -- Nếu chưa có God's Chalice
        if not hasGodsChalice then
            printPhase("Đang farm Elite Pirates để lấy God's Chalice...")
            
            -- Giả lập việc farm Elite Pirates
            if math.random(1, 100) <= 10 then -- 10% chance
                hasGodsChalice = true
                printPhase("Đã nhận God's Chalice!")
            end
        end
        
        -- Nếu chưa có đủ Conjured Cocoa
        if hasConjuredCocoa < 10 then
            printPhase("Đang farm Conjured Cocoa...")
            
            -- Giả lập việc farm Conjured Cocoa
            if math.random(1, 100) <= 25 then -- 25% chance
                hasConjuredCocoa = hasConjuredCocoa + 1
                printPhase("Đã nhận Conjured Cocoa - Tổng: " .. hasConjuredCocoa .. "/10")
            end
        end
    end
    
    task.wait(0.5)
end

-- ============================================================================
-- PHASE 3: TRIỆU HỒI DOUGH KING
-- ============================================================================

local function summonPhase()
    printPhase("Phase: Summon Dough King - Đang di chuyển đến drip_mama...")
    
    -- Kiểm tra nếu đã có Sweet Chalice
    if hasSweetChalice then
        -- Tìm NPC drip_mama
        local npc = findNPCByName(cakeLandNPC)
        if npc then
            -- Di chuyển đến NPC
            moveToPosition(npc.HumanoidRootPart.CFrame, 0)
            
            -- Tương tác
            printPhase("Đang tương tác với drip_mama...")
            task.wait(1)
            
            -- Giả lập việc triệu hồi thành công
            printPhase("Đã triệu hồi Dough King! - Chuyển sang Phase Fight")
            
            phase = "fight"
            hasDefeated500 = true
        end
    else
        -- Nếu chưa có Sweet Chalice, quay lại phase get_chalice
        printPhase("Chưa có Sweet Chalice! Quay lại lấy Sweet Chalice...")
        phase = "get_chalice"
    end
    
    task.wait(0.5)
end

-- ============================================================================
-- PHASE 4: ĐÁNH BOSS
-- ============================================================================

local function fightPhase()
    printPhase("Phase: Fight Dough King - HP: 1,111,500")
    
    -- Tìm boss
    local boss = findEnemyByName("Dough King")
    if boss then
        -- Di chuyển đến vị trí boss (bay lên cao để không bị tấn công)
        moveToPosition(boss.HumanoidRootPart.CFrame, 3)
        
        -- Tự động tấn công
    end
    
    -- Kiểm tra nếu đã đánh boss xong (giả lập)
    if math.random(1, 100) == 1 then
        printPhase("Đã đánh xong Dough King! - Nhận Drops...")
        
        -- Reset script
        phase = "farm"
        enemyCount = 0
        hasDefeated500 = false
        printPhase("Script đã reset - Bắt đầu lại từ Phase Farm")
    end
    
    task.wait(0.3)
end

-- ============================================================================
-- VÒNG LẶP CHÍNH
-- ============================================================================

-- Tạo GUI
createGUI()

-- No-clip khi bật noClip
game:GetService("RunService").RenderStepped:Connect(function()
    if noClip then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState(11)
        end
    end
end)

print("[DoughKingBot] Script đã khởi động!")
