local fakelagblock = Instance.new("Part")
fakelagblock.Parent = game.Workspace
fakelagblock.Anchored = true
fakelagblock.CanCollide = false
fakelagblock.Size = Vector3.new(1,1,1)
fakelagblock.Color = Color3.fromRGB(255,0,0)

while wait() do
    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(1)
    wait(1)
    fakelagblock.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(9e9)
end
