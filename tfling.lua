local HEIGHT = 1 --HRP height
local DISTANCE = 4 -- Distance from HRP

-----------------------------------
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()
local Tools = {}
local move = 0
local Target = LP

Mouse.Button1Down:Connect(function()
    if Mouse.Target:FindFirstAncestorOfClass("Model") then
        local Model = Mouse.Target:FindFirstAncestorOfClass("Model")
        if game.Players:GetPlayerFromCharacter(Model) then
            Target = game.Players:GetPlayerFromCharacter(Model)
            wait(1)
            Target = LP
        end
    end
end)

LP.Character.Humanoid:UnequipTools()

for _,v in pairs(LP.Backpack:GetChildren()) do
     if v.Name:lower():find("boombox") then --edit this for different tools (I only use a certain one to bypass anticheats that detect selecting multiple tools
        Tools[#Tools + 1] = v
    end
end

for _,v in pairs(Tools) do
    v.Parent = LP.Character
    v.Handle.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
end

wait(.5)

if LP.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
    LP.Character["RightHand"]:Destroy()
else
    LP.Character["Right Arm"]:Destroy()
end

for _,v in pairs(Tools) do
    task.spawn(function()
        v.Parent = LP.Backpack
        task.wait()
        v.Parent = LP.Character
    end)
end


spawn(function()
    wait(.3)

    for _,v in next, LP.Character.Humanoid:GetPlayingAnimationTracks() do
        if v.Animation and v.Name == "ToolNoneAnim" then
            v:Stop()
        end
    end
end)

while LP.Character.Humanoid.Health >= 1 do
    coroutine.wrap(function()
        for _,v in next, Tools do
            v.Handle.Velocity = Vector3.new(0,0,30)
            v.Handle.RotVelocity = Vector3.new(10000,10000,10000)
        end
    end)()

    for i,v in next, Tools do
        if Target == LP then
            v.Handle.CFrame = CFrame.new((CFrame.new(LP.Character.HumanoidRootPart.Position) * CFrame.Angles(0, math.rad(move + ( i * (360 / #Tools))), 0) * CFrame.new(0, HEIGHT, DISTANCE)).Position, Vector3.new(0,0,0)) * CFrame.Angles(move/20,move/20,0)
        else
            if Target.Character then
                v.Handle.CFrame = Target.Character:WaitForChild("Humanoid").RootPart.CFrame * CFrame.new(0,0,0) * CFrame.Angles(move/20,move/20,0)
            else
                Target = LP
            end
        end
    end

    move = move + 1
    task.wait(0/1)
end
