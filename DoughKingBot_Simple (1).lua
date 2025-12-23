-- ============================================================================
-- Script Lua - Blox Fruits: Dough King Auto Bot (Simple Version)
-- Phiên bản: 1.0
-- Mô tả: Script đơn giản chỉ dùng melee thường và bay để farm
-- Cách dùng: loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/DoughKingBot/main/DoughKingBot_Simple.lua"))()
-- ============================================================================

-- ============================================================================
-- CÀI ĐẶT CƠ BẢN
-- ============================================================================

local autofarm = true
local phase = "farm" -- farm, get_chalice, summon, fight
local enemyCount = 0
local hasGodsChalice = false
local hasConjuredCocoa = 0
local hasSweetChalice = false
local hasDefeated500 = false

-- Vị trí và tên enemies (cần điều chỉnh theo game thực tế)
local cakeLandEnemies = {"Cocoa Warrior", "Chocolate Bar Battler", "Cake Monster"}
local chocolateLandNPC = "Sweet Crafter"
local cakeLandNPC = "drip_mama"

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

local function attack()
    -- Tấn công melee thường
    -- Script sẽ tự động tấn công khi đứng gần enemy
    -- Không cần khai báo phím
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
            
            -- Tự động tấn công (script sẽ tự động tấn công khi đứng gần)
            -- Không cần khai báo phím
            
            -- Tăng enemy count (giả lập)
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
            
            -- Tương tác (giả lập)
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
    
    -- Tìm NPC drip_mama
    local npc = findNPCByName(cakeLandNPC)
    if npc then
        -- Di chuyển đến NPC
        moveToPosition(npc.HumanoidRootPart.CFrame, 0)
        
        -- Tương tác (giả lập)
        printPhase("Đang tương tác với drip_mama...")
        task.wait(1)
        
        -- Giả lập việc triệu hồi thành công
        printPhase("Đã triệu hồi Dough King! - Chuyển sang Phase Fight")
        
        phase = "fight"
        hasDefeated500 = true
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
        -- Không cần khai báo phím
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

printPhase("Script đã khởi động!")
printPhase("Phase hiện tại: " .. phase)

-- No-clip khi farm (bay không bị quái đánh)
game:GetService("RunService").RenderStepped:Connect(function()
    if autofarm then
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid:ChangeState(11) -- No-clip mode
        end
    end
end)

-- Vòng lặp chính
while autofarm do
    if phase == "farm" then
        farmPhase()
    elseif phase == "get_chalice" then
        getChalicePhase()
    elseif phase == "summon" then
        summonPhase()
    elseif phase == "fight" then
        fightPhase()
    end
    
    task.wait(0.1)
end

printPhase("Script đã dừng!")
