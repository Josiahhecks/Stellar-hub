function setTeam(teamName)
    local args = {
        [1] = "SetTeam",
        [2] = teamName
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
end

spawn(function()
    while wait() do
        if getgenv().Team == "Pirates" then
            setTeam("Pirates")
        elseif getgenv().Team == "Marines" then
            setTeam("Marines")
        end
    end
end)

function topos(Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if Distance < 250 then
        Speed = 300
    elseif Distance < 1000 then
        Speed = 350
    end
    game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
        {CFrame = Pos}
    ):Play()
end

spawn(function()
    while wait() do
        if getgenv().FindFruit then
            for i,v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "Fruit") then
                    topos(v.Handle.CFrame)
                else
                    wait(5)
                    Hop()
                end
            end
        end
    end
end)

function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    
    function TPReturner()
        local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        for i,v in pairs(Site.data) do
            if v.playing < v.maxPlayers then
                game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, v.id)
                wait(4)
            end
        end
    end
    
    while wait() do
        pcall(TPReturner)
    end
end
