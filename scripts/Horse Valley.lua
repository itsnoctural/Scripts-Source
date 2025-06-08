local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Horse = Workspace.Horses[LocalPlayer.Name]

getgenv().Settings = {
  Default = false,
  Stars = false,
}

local LastTimeTeleported = os.clock()

for _,v in ipairs(Workspace.Training:GetDescendants()) do
  if v:IsA("Folder") and v.Name == "Stars" then
    v.ChildAdded:Connect(function(child)
      if child.Name == LocalPlayer.Name then
        child:GetPropertyChangedSignal("Position"):Connect(function()
          if Settings.Stars and (os.clock() - LastTimeTeleported) > 0.25 then
            LastTimeTeleported = os.clock()
            LocalPlayer.Character:PivotTo(child:GetPivot())
          end
        end)
      end
    end)
  end
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Collectables", {}, function(state)
  task.spawn(function()
      Settings.Default = state
      while true do
        if not Settings.Default then return end

        for _,v in ipairs(game["Workspace"].UCA.Collectables:GetChildren()) do
          for _, crystal in ipairs(v:GetChildren()) do
              if not Settings.Default then return end

              local Pivot_Tree = crystal:FindFirstChild("Pivot_Tree")
              if not Pivot_Tree or not Pivot_Tree:GetAttribute("Interactable") then continue; end

              LocalPlayer.Character:PivotTo(crystal:GetPivot() + Vector3.new(0, 5, 0)); task.wait(.75)
              ReplicatedStorage.Signals.Reliable.Interact:FireServer("UCACollect", "Collect", Pivot_Tree); task.wait()
              ReplicatedStorage.UCA.Signals.Reliable.Collect:FireServer(v.Name, crystal.Name);
          end
        end

        task.wait(2.5)
      end
  end)
end)

Window:Toggle("Auto Stars", {}, function(state)
  task.spawn(function()
    Settings.Stars = state
  end)
end)

Window:Button("YouTube: EsohaSL", function()
  task.spawn(function()
    if setclipboard then
      setclipboard("https://youtube.com/@esohasl")
    end
  end)
end)



-- Decompiled with the Synapse Z Luau decompiler.
-- NOTE: Currently in beta! Not representative of final product.

local v0_0_ = game
local v0_2_ = "UserInputService"
v0_0_ = v0_0_:GetService(v0_2_)
local v0_1_ = game
local v0_3_ = "TweenService"
v0_1_ = v0_1_:GetService(v0_3_)
v0_3_ = workspace
v0_2_ = v0_3_.Terrain
v0_3_ = require
local v0_7_ = game
local v0_6_ = v0_7_.ReplicatedStorage
local v0_5_ = v0_6_.Modules
local v0_4_ = v0_5_.ActivateHorseIdleAnimations
v0_3_ = v0_3_(v0_4_)
v0_4_ = require
local v0_8_ = game
v0_7_ = v0_8_.ReplicatedStorage
v0_6_ = v0_7_.Modules
v0_5_ = v0_6_.CollisionCheckDiagonal
v0_4_ = v0_4_(v0_5_)
v0_5_ = require
local v0_9_ = game
v0_8_ = v0_9_.ReplicatedStorage
v0_7_ = v0_8_.Modules
v0_6_ = v0_7_.CollisionCheckFrontal
v0_5_ = v0_5_(v0_6_)
v0_6_ = require
local v0_10_ = game
v0_9_ = v0_10_.ReplicatedStorage
v0_8_ = v0_9_.Modules
v0_7_ = v0_8_.CollisionCheckSides
v0_6_ = v0_6_(v0_7_)
v0_7_ = require
local v0_11_ = game
v0_10_ = v0_11_.ReplicatedStorage
v0_9_ = v0_10_.Modules
v0_8_ = v0_9_.GetRidingHipHeight
v0_7_ = v0_7_(v0_8_)
v0_8_ = require
local v0_12_ = game
v0_11_ = v0_12_.ReplicatedStorage
v0_10_ = v0_11_.Modules
v0_9_ = v0_10_.GoodSignalsClient
v0_8_ = v0_8_(v0_9_)
v0_9_ = require
local v0_13_ = game
v0_12_ = v0_13_.ReplicatedStorage
v0_11_ = v0_12_.Modules
v0_10_ = v0_11_.ActivateWildMode
v0_9_ = v0_9_(v0_10_)
v0_10_ = require
local v0_14_ = game
v0_13_ = v0_14_.ReplicatedStorage
v0_12_ = v0_13_.Modules
v0_11_ = v0_12_.GetRidingOffset
v0_10_ = v0_10_(v0_11_)
v0_11_ = require
local v0_15_ = game
v0_14_ = v0_15_.ReplicatedStorage
v0_13_ = v0_14_.Modules
v0_12_ = v0_13_.SharedVariables
v0_11_ = v0_11_(v0_12_)
v0_12_ = require
local v0_16_ = game
v0_15_ = v0_16_.ReplicatedStorage
v0_14_ = v0_15_.Modules
v0_13_ = v0_14_.CreateParticle
v0_12_ = v0_12_(v0_13_)
v0_13_ = require
local v0_17_ = game
v0_16_ = v0_17_.ReplicatedStorage
v0_15_ = v0_16_.Modules
v0_14_ = v0_15_.PlayerControl
v0_13_ = v0_13_(v0_14_)
v0_14_ = require
local v0_18_ = game
v0_17_ = v0_18_.ReplicatedStorage
v0_16_ = v0_17_.Modules
v0_15_ = v0_16_.DataClient
v0_14_ = v0_14_(v0_15_)
v0_15_ = require
local v0_19_ = game
v0_18_ = v0_19_.ReplicatedStorage
v0_17_ = v0_18_.Modules
v0_16_ = v0_17_.RideClient
v0_15_ = v0_15_(v0_16_)
v0_16_ = require
local v0_20_ = game
v0_19_ = v0_20_.ReplicatedStorage
v0_18_ = v0_19_.Modules
v0_17_ = v0_18_.TryGetRidingValue
v0_16_ = v0_16_(v0_17_)
v0_17_ = require
local v0_21_ = game
v0_20_ = v0_21_.ReplicatedStorage
v0_19_ = v0_20_.Modules
v0_18_ = v0_19_.PlayRandomNeighSound
v0_17_ = v0_17_(v0_18_)
v0_18_ = require
local v0_22_ = game
v0_21_ = v0_22_.ReplicatedStorage
v0_20_ = v0_21_.Modules
v0_19_ = v0_20_.Serde
v0_18_ = v0_18_(v0_19_)
v0_21_ = game
v0_20_ = v0_21_.Players
v0_19_ = v0_20_.LocalPlayer
v0_21_ = workspace
v0_20_ = v0_21_.Horses
v0_22_ = script
v0_21_ = v0_22_.Parent
local v0_24_ = script
local v0_23_ = v0_24_.Parent
v0_22_ = v0_23_.Humanoid
local v0_25_ = script
v0_24_ = v0_25_.Parent
v0_23_ = v0_24_.HumanoidRootPart
local v0_26_ = game
v0_25_ = v0_26_.ReplicatedStorage
v0_24_ = v0_25_.Signals
local v0_28_ = game
local v0_27_ = v0_28_.ReplicatedStorage
v0_26_ = v0_27_.Animations
v0_25_ = v0_26_.Horse
v0_25_ = v0_25_:GetChildren()
local v0_29_ = game
v0_28_ = v0_29_.ReplicatedStorage
v0_27_ = v0_28_.Animations
v0_26_ = v0_27_.Horse2
v0_26_ = v0_26_:GetChildren()
local v0_30_ = game
v0_29_ = v0_30_.ReplicatedStorage
v0_28_ = v0_29_.Animations
v0_27_ = v0_28_.Horse2
local v0_31_ = game
v0_30_ = v0_31_.ReplicatedStorage
v0_29_ = v0_30_.Animations
v0_28_ = v0_29_.NewHorse2
local v0_32_ = game
v0_31_ = v0_32_.ReplicatedStorage
v0_30_ = v0_31_.Emotes
v0_29_ = v0_30_.Horse
local v0_33_ = game
v0_32_ = v0_33_.ReplicatedStorage
v0_31_ = v0_32_.Sounds
v0_30_ = v0_31_.Horse
v0_30_ = v0_30_:GetChildren()
v0_33_ = workspace
v0_32_ = v0_33_.Environment
v0_31_ = v0_32_.Obstacles
local v0_36_ = game
local v0_35_ = v0_36_.Players
local v0_34_ = v0_35_.LocalPlayer
v0_33_ = v0_34_.PlayerGui
v0_32_ = v0_33_.Ride
local v0_38_ = game
local v0_37_ = v0_38_.Players
v0_36_ = v0_37_.LocalPlayer
v0_35_ = v0_36_.PlayerGui
v0_34_ = v0_35_.Ride
v0_33_ = v0_34_.Dismount
v0_34_ = {}
local new = Random.new
v0_35_ = new()
v0_36_ = 0
v0_37_ = false
v0_38_ = false
local v0_39_ = false
local v0_40_ = false
local v0_41_ = false
local v0_45_ = game
local v0_44_ = v0_45_.ReplicatedStorage
local v0_43_ = v0_44_.Animations
local v0_42_ = v0_43_.NewMeshEmotes
local new = CFrame.new
v0_45_ = -1.056000
local v0_46_ = 0
local v0_47_ = -3.264000
v0_44_ = new(v0_45_, v0_46_, v0_47_)
local Angles = CFrame.Angles
v0_46_ = 0
v0_47_ = 3.112166
local v0_48_ = 0
v0_45_ = Angles(v0_46_, v0_47_, v0_48_)
v0_43_ = v0_44_ * v0_45_
v0_44_ = require
v0_48_ = game
v0_47_ = v0_48_.ReplicatedStorage
v0_46_ = v0_47_.Settings
v0_45_ = v0_46_.HorseModifiers
v0_44_ = v0_44_(v0_45_)
v0_45_ = require
local v0_49_ = game
v0_48_ = v0_49_.ReplicatedStorage
v0_47_ = v0_48_.Settings
v0_46_ = v0_47_.GroundRaycastParams
v0_45_ = v0_45_(v0_46_)
v0_46_ = require
local v0_50_ = game
v0_49_ = v0_50_.ReplicatedStorage
v0_48_ = v0_49_.Settings
v0_47_ = v0_48_.GroundRaycastVector
v0_46_ = v0_46_(v0_47_)
v0_47_ = require
local v0_51_ = game
v0_50_ = v0_51_.ReplicatedStorage
v0_49_ = v0_50_.Settings
v0_48_ = v0_49_.Interact
v0_47_ = v0_47_(v0_48_)
v0_48_ = require
local v0_52_ = game
v0_51_ = v0_52_.ReplicatedStorage
v0_50_ = v0_51_.Settings
v0_49_ = v0_50_.MountTime
v0_48_ = v0_48_(v0_49_)
v0_49_ = require
local v0_53_ = game
v0_52_ = v0_53_.ReplicatedStorage
v0_51_ = v0_52_.Settings
v0_50_ = v0_51_.DressageInfo
v0_49_ = v0_49_(v0_50_)
v0_50_ = {}
v0_51_ = -1
v0_52_ = -0.080000
v0_50_[v0_51_] = v0_52_
v0_51_ = 0
v0_52_ = 0
v0_50_[v0_51_] = v0_52_
v0_51_ = 0.160000
v0_50_[-1] = v0_51_
v0_51_ = 0.320000
v0_50_[0] = v0_51_
v0_51_ = 0.650000
v0_50_[1] = v0_51_
v0_51_ = 1
v0_50_[2] = v0_51_
v0_51_ = table.create(4)
v0_52_ = "Walk"
v0_53_ = "Trot"
local v0_54_ = "Canter"
local v0_55_ = "Gallop"
v0_51_[1] = v0_52_
v0_51_[2] = v0_53_
v0_51_[3] = v0_54_
v0_51_[4] = v0_55_
v0_52_ = require
local v0_56_ = game
v0_55_ = v0_56_.ReplicatedStorage
v0_54_ = v0_55_.Settings
v0_53_ = v0_54_.CustomHorseData
v0_52_ = v0_52_(v0_53_)
v0_53_ = v0_22_.Animator
local v0_58_ = game
local v0_57_ = v0_58_.ReplicatedStorage
v0_56_ = v0_57_.Animations
v0_55_ = v0_56_.Rear2
v0_53_ = v0_53_:LoadAnimation(v0_55_)
v0_54_ = v0_22_.Animator
local v0_59_ = game
v0_58_ = v0_59_.ReplicatedStorage
v0_57_ = v0_58_.Animations
v0_56_ = v0_57_.NewRear2
v0_54_ = v0_54_:LoadAnimation(v0_56_)
v0_55_ = v0_22_.Animator
local v0_60_ = game
v0_59_ = v0_60_.ReplicatedStorage
v0_58_ = v0_59_.Animations
v0_57_ = v0_58_.CoRideRear2
v0_55_ = v0_55_:LoadAnimation(v0_57_)
v0_56_ = v0_22_.Animator
local v0_61_ = game
v0_60_ = v0_61_.ReplicatedStorage
v0_59_ = v0_60_.Animations
v0_58_ = v0_59_.CoRideNewRear2
v0_56_ = v0_56_:LoadAnimation(v0_58_)
v0_57_ = v0_22_.Animator
local v0_62_ = game
v0_61_ = v0_62_.ReplicatedStorage
v0_60_ = v0_61_.Animations
v0_59_ = v0_60_.Jump2
v0_57_ = v0_57_:LoadAnimation(v0_59_)
v0_58_ = {}
v0_59_ = v0_22_.Animator
local v0_64_ = game
local v0_63_ = v0_64_.ReplicatedStorage
v0_62_ = v0_63_.Animations
v0_61_ = v0_62_.Ride2
v0_59_ = v0_59_:LoadAnimation(v0_61_)
v0_58_.Ride2 = v0_59_
v0_59_ = v0_22_.Animator
v0_64_ = game
v0_63_ = v0_64_.ReplicatedStorage
v0_62_ = v0_63_.Animations
v0_61_ = v0_62_.Ride3
v0_59_ = v0_59_:LoadAnimation(v0_61_)
v0_58_.Ride3 = v0_59_
v0_59_ = v0_22_.Animator
v0_64_ = game
v0_63_ = v0_64_.ReplicatedStorage
v0_62_ = v0_63_.Animations
v0_61_ = v0_62_.Ride4
v0_59_ = v0_59_:LoadAnimation(v0_61_)
v0_58_.Ride4 = v0_59_
v0_59_ = v0_22_.Animator
v0_64_ = game
v0_63_ = v0_64_.ReplicatedStorage
v0_62_ = v0_63_.Animations
v0_61_ = v0_62_.Lean1
v0_59_ = v0_59_:LoadAnimation(v0_61_)
v0_60_ = v0_22_.Animator
local v0_65_ = game
v0_64_ = v0_65_.ReplicatedStorage
v0_63_ = v0_64_.Animations
v0_62_ = v0_63_.Lean2
v0_60_ = v0_60_:LoadAnimation(v0_62_)
local new = TweenInfo.new
v0_62_ = 0.250000
local Linear = Enum.EasingStyle.Linear
v0_61_ = new(v0_62_, Linear)
v0_62_ = function(a1)
    local v1_1_ = a1.PrimaryPart
    local v1_4_ = "Gait"
    local v1_2_ = a1:GetAttribute(v1_4_)
    if v1_2_ == 0.000000 then
        local v1_3_ = v1_1_.Bridle
        v1_3_:Stop()
        v1_3_ = pairs
        v1_4_ = v0_51_
        local v1_3_, v1_4_, v1_5_ = v1_3_(v1_4_)
        for v1_6_, v1_7_ in v1_3_, v1_4_, v1_5_ do
            local v1_8_ = v1_1_[v1_7_]
        end
        return
    end
    local v1_3_ = function(a1, a2)
        local v2_3_ = v1_1_
        local v2_2_ = v2_3_[a1]
        v2_2_.PlaybackSpeed = a2
        v2_3_ = v2_2_.Playing
        if not v2_3_ then
            if a1 ~= "Bridle" then
                v2_3_ = pairs
                local v2_4_ = v0_51_
                local v2_3_, v2_4_, v2_5_ = v2_3_(v2_4_)
                for v2_6_, v2_7_ in v2_3_, v2_4_, v2_5_ do
                    local v2_9_ = v1_1_
                    local v2_8_ = v2_9_[v2_7_]
                end
            end
            v2_2_:Play()
        end
    end
    local v1_5_ = v1_2_
    local abs = math.abs
    v1_4_ = abs(v1_5_)
    v1_2_ = v1_4_
    v1_4_ = v1_3_
    v1_5_ = "Bridle"
    local v1_7_ = 0.750000
    local v1_9_ = 0.250000
    local v1_8_ = v1_9_ * v1_2_
    local v1_6_ = v1_7_ + v1_8_
    v1_4_(v1_5_, v1_6_)
    v1_7_ = "Speed"
    v1_5_ = a1:GetAttribute(v1_7_)
    v1_7_ = v0_44_
    v1_6_ = v1_7_.baseSpeed
    v1_4_ = v1_5_ / v1_6_
    if v1_2_ == 1.000000 then
        v1_4_ *= 0.700000
    end
    v1_5_ = v1_3_
    v1_7_ = v0_51_
    v1_6_ = v1_7_[v1_2_]
    v1_7_ = v1_4_
    v1_5_(v1_6_, v1_7_)
end
v0_63_ = function(a1)
    local v3_1_ = a1.PrimaryPart
    local v3_2_ = pairs
    local v3_3_ = v0_30_
    local v3_2_, v3_3_, v3_4_ = v3_2_(v3_3_)
    for v3_5_, v3_6_ in v3_2_, v3_3_, v3_4_ do
        local v3_7_ = v3_6_:Clone()
        v3_7_.Parent = v3_1_
    end
    local defer = task.defer
    v3_3_ = function()
        local wait = task.wait
        local v4_1_ = v0_35_
        local v4_3_ = 3
        local v4_4_ = 7
        local v4_0_ = wait(v4_1_:NextInteger(v4_3_, v4_4_))
        while v4_0_ do
            v4_1_ = a1
            v4_0_ = v4_1_.Parent
            while v4_0_ do
                v4_0_ = a1
                local v4_2_ = "Gait"
                v4_0_ = v4_0_:GetAttribute(v4_2_)
                if v4_0_ == 0.000000 then
                    v4_0_ = v0_35_
                    v4_2_ = 1
                    v4_3_ = 4
                    v4_0_ = v4_0_:NextInteger(v4_2_, v4_3_)
                    v4_1_ = 3
                    if v4_0_ <= v4_1_ then
                        v4_1_ = v3_1_
                        v4_3_ = "Breath"
                        v4_4_ = v0_35_
                        local v4_6_ = 1
                        local v4_7_ = 2
                        v4_4_ = v4_4_:NextInteger(v4_6_, v4_7_)
                        v4_2_ = v4_3_
                        v4_0_ = v4_1_[v4_2_]
                        v4_0_:Play()
                    else
                        v4_0_ = v0_35_
                        v4_2_ = 1
                        v4_3_ = 5
                        v4_0_ = v4_0_:NextInteger(v4_2_, v4_3_)
                        v4_1_ = 3
                        if v4_0_ <= v4_1_ then
                            v4_0_ = a1
                            v4_2_ = "AgeStage"
                            v4_0_ = v4_0_:GetAttribute(v4_2_)
                            if v4_0_ == 1.000000 then
                                v4_1_ = v3_1_
                                v4_0_ = v4_1_.SnortFoal
                                v4_0_:Play()
                            else
                                v4_1_ = v3_1_
                                v4_3_ = "Snort"
                                v4_4_ = v0_35_
                                local v4_6_ = 1
                                local v4_7_ = 2
                                v4_4_ = v4_4_:NextInteger(v4_6_, v4_7_)
                                v4_2_ = v4_3_
                                v4_0_ = v4_1_[v4_2_]
                                v4_0_:Play()
                            end
                        end
                    end
                end
            end
        end
    end
    defer(v3_3_)
end
v0_64_ = function(a1, a2)
    local v5_6_ = "Speed"
    local v5_4_ = a1:GetAttribute(v5_6_)
    v5_6_ = v0_44_
    local v5_5_ = v5_6_.baseSpeed
    local v5_3_ = v5_4_ / v5_5_
    local v5_2_ = v5_3_ * 0.800000
    v5_3_ = function(a1)
        local v6_2_ = a2
        local v6_1_ = v6_2_[a1]
        v6_2_ = v6_1_.IsPlaying
        if v6_2_ then
            return
        end
        v6_2_ = pairs
        local v6_3_ = a2
        local v6_2_, v6_3_, v6_4_ = v6_2_(v6_3_)
        for v6_5_, v6_6_ in v6_2_, v6_3_, v6_4_ do
        end
        v6_4_ = nil
        local v6_5_ = nil
        local v6_6_ = v5_2_
        v6_1_:Play(v6_4_, v6_5_, v6_6_)
    end
    v5_6_ = "Gait"
    v5_4_ = a1:GetAttribute(v5_6_)
    if v5_4_ == 0.000000 then
        v5_5_ = pairs
        v5_6_ = a2
        local v5_5_, v5_6_, v5_7_ = v5_5_(v5_6_)
        for v5_8_, v5_9_ in v5_5_, v5_6_, v5_7_ do
            local v5_12_ = 0.250000
        end
        return
    end
    if v5_4_ == -1.000000 then
        v5_5_ = v5_3_
        v5_6_ = "Back"
        v5_5_(v5_6_)
        return
    end
    v5_5_ = v5_3_
    local v5_7_ = v0_51_
    v5_6_ = v5_7_[v5_4_]
    v5_5_(v5_6_)
end
v0_65_ = function(a1)
    local v7_3_ = "AnimationController"
    local v7_1_ = a1:WaitForChild(v7_3_)
    v7_3_ = "Animator"
    v7_1_ = v7_1_:WaitForChild(v7_3_)
    local v7_2_ = a1.Parent
    if not v7_2_ then
        return
    end
    v7_2_ = {}
    v7_3_ = v0_34_
    local v7_4_ = {}
    v7_3_[a1] = v7_4_
    local v7_5_ = "NewMesh"
    v7_3_ = a1:GetAttribute(v7_5_)
    if v7_3_ then
        local v7_6_ = game
        v7_5_ = v7_6_.ReplicatedStorage
        v7_4_ = v7_5_.Animations
        v7_3_ = v7_4_.NewHorse
        v7_3_, v7_4_, v7_5_ = v7_3_:GetChildren()
        local v7_8_ = nil.Name
        local v7_11_ = nil
        local v7_9_ = v7_1_:LoadAnimation(v7_11_)
        v7_2_[v7_8_] = v7_9_
        v7_4_ = v0_34_
        v7_3_ = v7_4_[a1]
        local v7_7_ = game
        v7_6_ = v7_7_.ReplicatedStorage
        v7_5_ = v7_6_.Animations
        v7_4_ = v7_5_.NewHorse2
        v7_4_, v7_5_, v7_6_ = v7_4_:GetChildren()
        v7_9_ = v7_8_.Name
        local v7_12_ = v7_8_
        local v7_10_ = v7_1_:LoadAnimation(v7_12_)
        v7_3_[v7_9_] = v7_10_
        v7_10_ = v7_8_.Name
        v7_9_ = v7_3_[v7_10_]
        v7_11_ = "Weight"
        local v7_14_ = "Weight"
        v7_9_:SetAttribute(v7_8_:GetAttribute(v7_14_))
    else
        v7_3_ = pairs
        v7_4_ = v0_25_
        v7_3_, v7_4_, v7_5_ = v7_3_(v7_4_)
        for v7_6_, v7_7_ in v7_3_, v7_4_, v7_5_ do
            local v7_8_ = v7_7_.Name
            local v7_11_ = v7_7_
            local v7_9_ = v7_1_:LoadAnimation(v7_11_)
        end
        v7_4_ = v0_34_
        v7_3_ = v7_4_[a1]
        v7_4_ = pairs
        v7_5_ = v0_26_
        local v7_4_, v7_5_, v7_6_ = v7_4_(v7_5_)
        for v7_7_, v7_8_ in v7_4_, v7_5_, v7_6_ do
            local v7_9_ = v7_8_.Name
            local v7_12_ = v7_8_
            local v7_10_ = v7_1_:LoadAnimation(v7_12_)
        end
    end
    v7_3_ = v0_3_
    v7_4_ = a1
    v7_3_(v7_4_)
    return v7_2_
end
local v0_66_ = function(a1, a2)
    local v8_3_ = a1.Rider
    local v8_2_ = v8_3_.Value
    local v8_6_ = "NewMesh"
    local v8_4_ = a1:GetAttribute(v8_6_)
    if v8_4_ then
        local v8_5_ = "Bridle"
        v8_3_ = a1:WaitForChild(v8_5_)
    else
        v8_4_ = a1.Bridle
        v8_3_ = v8_4_.PrimaryPart
    end
    v8_4_ = function()
        local v9_0_ = v8_2_
        local v9_1_ = v0_21_
        if v9_0_ == v9_1_ then
            v9_1_ = v0_11_
            v9_0_ = v9_1_.WildMode
            return v9_0_
        end
        v9_0_ = v8_3_
        if v9_0_ then
            v9_0_ = v8_3_
            local v9_2_ = "Folder"
            v9_0_ = v9_0_:IsA(v9_2_)
            if not v9_0_ then
                v9_2_ = v8_3_
                v9_1_ = v9_2_.Transparency
                if v9_1_ ~= 1.000000 then
                    v9_0_ = false
                end
                v9_0_ = true
                return v9_0_
            end
        end
        v9_0_ = v8_3_
        if v9_0_ then
            v9_0_ = v8_3_
            local v9_2_ = "Folder"
            v9_0_ = v9_0_:IsA(v9_2_)
            if v9_0_ then
                v9_1_ = v8_3_
                v9_1_ = v9_1_:GetChildren()
                v9_0_ = v9_1_[-1]
                v9_1_ = v9_0_
                if v9_1_ then
                    v9_2_ = v9_0_.Transparency
                    if v9_2_ ~= 1.000000 then
                        v9_1_ = false
                    end
                    v9_1_ = true
                end
                return v9_1_
            end
        end
    end
    if v8_2_ then
        local v8_5_ = v8_4_
        v8_5_ = v8_5_()
        if not v8_5_ then
            v8_5_ = a2[-1]
            local v8_7_ = v8_2_.LeftHand
            v8_6_ = v8_7_.LeftGripAttachment
            v8_5_.Attachment1 = v8_6_
            v8_5_ = a2[0]
            v8_7_ = v8_2_.RightHand
            v8_6_ = v8_7_.RightGripAttachment
            v8_5_.Attachment1 = v8_6_
            v8_5_ = a2[1]
            v8_7_ = v8_2_.LeftHand
            v8_6_ = v8_7_.LeftGripAttachment
            v8_5_.Attachment0 = v8_6_
            v8_5_ = a2[1]
            v8_7_ = v8_2_.RightHand
            v8_6_ = v8_7_.RightGripAttachment
            v8_5_.Attachment1 = v8_6_
            v8_7_ = "Decal"
            v8_5_ = v8_3_:FindFirstChildOfClass(v8_7_)
            if v8_5_ then
                local v8_8_ = 1
                v8_6_ = 3
                v8_7_ = 1
                for v8_8_ = v8_8_, v8_6_, v8_7_ do
                    local v8_9_ = a2[v8_8_]
                    local new = ColorSequence.new
                    local new_0 = Color3.new
                    local v8_12_ = 1
                    local v8_13_ = 1
                    local v8_14_ = 1
                    local v8_10_ = new(new_0(v8_12_, v8_13_, v8_14_))
                    v8_9_.Color = v8_10_
                    v8_9_ = a2[v8_8_]
                    v8_10_ = v8_5_.Texture
                    v8_9_.Texture = v8_10_
                    return
                end
            end
            local v8_8_ = "Folder"
            v8_6_ = v8_3_:IsA(v8_8_)
            if not v8_6_ then
                v8_8_ = 1
                v8_6_ = 3
                v8_7_ = 1
                for v8_8_ = v8_8_, v8_6_, v8_7_ do
                    local v8_9_ = a2[v8_8_]
                    local new = ColorSequence.new
                    local v8_11_ = v8_3_.Color
                    local v8_10_ = new(v8_11_)
                    v8_9_.Color = v8_10_
                    v8_9_ = a2[v8_8_]
                    v8_10_ = ""
                    v8_9_.Texture = v8_10_
                    return
                end
            end
            v8_8_ = "ReinColor"
            v8_6_ = v8_3_:GetAttribute(v8_8_)
            if not v8_6_ then
                local new = Color3.new
                v8_7_ = 1
                v8_8_ = 1
                local v8_9_ = 1
                v8_6_ = new(v8_7_, v8_8_, v8_9_)
            end
            local v8_9_ = 1
            v8_7_ = 3
            v8_8_ = 1
            for v8_9_ = v8_9_, v8_7_, v8_8_ do
                local v8_10_ = a2[v8_9_]
                local new = ColorSequence.new
                local v8_12_ = v8_6_
                local v8_11_ = new(v8_12_)
                v8_10_.Color = v8_11_
                v8_10_ = a2[v8_9_]
                v8_11_ = ""
                v8_10_.Texture = v8_11_
                return
            end
        end
    end
    local v8_5_ = a2[-1]
    v8_6_ = nil
    v8_5_.Attachment1 = v8_6_
    v8_5_ = a2[0]
    v8_6_ = nil
    v8_5_.Attachment1 = v8_6_
    v8_5_ = a2[1]
    v8_6_ = nil
    v8_5_.Attachment0 = v8_6_
    v8_5_ = a2[1]
    v8_6_ = nil
    v8_5_.Attachment1 = v8_6_
end
local v0_67_ = function(a1)
    local v10_1_ = table.create(3)
    local v10_4_ = 1
    local v10_2_ = 3
    local v10_3_ = 1
    for v10_4_ = v10_4_, v10_2_, v10_3_ do
        local new = Instance.new
        local v10_6_ = "Beam"
        local v10_5_ = new(v10_6_)
        v10_6_ = 3
        if v10_4_ < v10_6_ then
            v10_6_ = a1.Head
            local v10_9_ = "ReinAttachment"
            local v10_10_ = v10_4_
            local v10_8_ = v10_9_
            v10_6_ = v10_6_:WaitForChild(v10_8_)
            v10_5_.Attachment0 = v10_6_
            local v10_7_ = -0.500000
            v10_8_ = v10_4_ - 1.000000
            v10_6_ = v10_7_ + v10_8_
            v10_5_.CurveSize0 = v10_6_
            v10_7_ = v10_4_ - 1.000000
            v10_6_ = nil - "Attachment0"
            v10_5_.CurveSize1 = v10_6_
        end
        local new = NumberSequence.new
        local v10_7_ = 0
        v10_6_ = new(v10_7_)
        v10_5_.Transparency = v10_6_
        v10_6_ = 1
        v10_5_.LightInfluence = v10_6_
        v10_6_ = 7
        v10_5_.Segments = v10_6_
        v10_6_ = true
        v10_5_.FaceCamera = v10_6_
        v10_6_ = 0.200000
        v10_5_.Width0 = v10_6_
        v10_6_ = 0.200000
        v10_5_.Width1 = v10_6_
        v10_6_ = 0
        v10_5_.TextureSpeed = v10_6_
        v10_7_ = "Rein"
        local v10_8_ = v10_4_
        v10_6_ = v10_7_
        v10_5_.Name = v10_6_
        v10_6_ = a1.Head
        v10_5_.Parent = v10_6_
        v10_1_[v10_4_] = v10_5_
    end
    return v10_1_
end
local v0_68_ = function()
    local v11_0_ = v0_39_
    if v11_0_ then
        v11_0_ = true
        return v11_0_
    end
    v11_0_ = v0_38_
    if v11_0_ then
        v11_0_ = true
        return v11_0_
    end
    v11_0_ = v0_41_
    if v11_0_ then
        v11_0_ = true
        return v11_0_
    end
    local v11_1_ = v0_23_
    v11_0_ = v11_1_.Anchored
    if v11_0_ then
        v11_0_ = true
        return v11_0_
    end
    v11_0_ = v0_37_
    if v11_0_ then
        v11_0_ = true
        return v11_0_
    end
    v11_0_ = false
    return v11_0_
end
local v0_69_ = v0_24_.IsHorseImmobilized
v0_69_.OnInvoke = v0_68_
v0_69_ = function(a1)
    local v12_3_ = "AnimationController"
    local v12_1_ = a1:FindFirstChild(v12_3_)
    if not v12_1_ then
        local v12_2_ = false
        return v12_2_
    end
    local v12_4_ = "Animator"
    local v12_2_ = v12_1_:FindFirstChild(v12_4_)
    if not v12_2_ then
        v12_3_ = false
        return v12_3_
    end
    local v12_6_ = "NewMesh"
    v12_4_ = a1:GetAttribute(v12_6_)
    if v12_4_ then
        v12_3_ = v0_42_
    else
        v12_3_ = v0_29_
    end
    local v12_4_, v12_5_, v12_6_ = v12_2_:GetPlayingAnimationTracks()
    local v12_9_ = nil.Animation
    local v12_11_ = v12_3_
    v12_9_ = v12_9_:IsDescendantOf(v12_11_)
    if v12_9_ then
        v12_9_ = true
        return v12_9_
    end
    v12_4_ = false
    return v12_4_
end
local v0_70_ = function(a1)
    local v13_4_ = "NewMesh"
    local v13_2_ = a1:GetAttribute(v13_4_)
    if v13_2_ then
        local v13_1_ = v0_28_
    else
        local v13_1_ = v0_27_
    end
    v13_4_ = "Animator"
    local v13_5_ = true
    v13_2_ = a1:FindFirstChild(v13_4_, v13_5_)
    if not v13_2_ then
        local v13_3_ = false
        return v13_3_
    end
    local v13_3_, v13_4_, v13_5_ = v13_2_:GetPlayingAnimationTracks()
    local v13_8_ = nil.Animation
    local v13_10_ = nil
    v13_8_ = v13_8_:IsDescendantOf(v13_10_)
    if v13_8_ then
        v13_8_ = true
        return v13_8_
    end
    v13_3_ = false
    return v13_3_
end
local v0_71_ = function(a1, a2)
    local v14_3_ = v0_34_
    local v14_2_ = v14_3_[a1]
    if not v14_2_ then
        return
    end
    v14_3_ = v14_2_.Piaffe
    if a2 then
        v14_3_:Play()
        local v14_5_ = v0_8_
        local v14_4_ = v14_5_.Trigger
        local v14_6_ = v14_3_
        v14_4_:Fire(v14_6_)
    else
        v14_3_:Stop()
    end
    local v14_6_ = v0_24_
    local v14_5_ = v14_6_.Unreliable
    local v14_4_ = v14_5_.HorsePiaffe
    v14_6_ = "Piaffe"
    local v14_7_ = a2
    v14_4_:FireServer(v14_6_, v14_7_)
end
local v0_72_ = function(a1)
    local v15_1_ = v0_16_
    local v15_2_ = a1
    v15_1_ = v15_1_(v15_2_)
    if not v15_1_ then
        return
    end
    local v15_3_ = v0_34_
    v15_2_ = v15_3_[v15_1_]
    if not v15_2_ then
        return
    end
    local v15_5_ = "HipHeight"
    v15_3_ = a1:GetAttribute(v15_5_)
    local v15_4_ = v0_12_
    v15_5_ = "Skid"
    local v15_6_ = v15_1_.PrimaryPart
    local v15_8_ = 0
    local v15_9_ = -v15_3_
    local v15_10_ = 0
    local new = Vector3.new
    local v15_7_ = new(v15_8_, v15_9_, v15_10_)
    v15_4_(v15_5_, v15_6_, v15_7_)
    v15_4_ = v15_2_.SlidingStop
    v15_7_ = nil
    v15_8_ = nil
    v15_9_ = 1.500000
    v15_4_:Play(v15_7_, v15_8_, v15_9_)
    return v15_4_
end
local v0_75_ = v0_24_.Unreliable
local v0_74_ = v0_75_.HorseSlidingStop
local v0_73_ = v0_74_.OnClientEvent
v0_75_ = v0_72_
v0_73_:Connect(v0_75_)
v0_73_ = function(a1)
    local v16_1_ = v0_16_
    local v16_2_ = v0_21_
    v16_1_ = v16_1_(v16_2_)
    if not v16_1_ then
        return
    end
    v16_2_ = v0_69_
    local v16_3_ = v16_1_
    v16_2_ = v16_2_(v16_3_)
    if v16_2_ then
        return
    end
    v16_3_ = v0_14_
    v16_2_ = v16_3_.Get
    v16_2_ = v16_2_()
    local v16_5_ = "Gait"
    v16_3_ = v16_1_:GetAttribute(v16_5_)
    local v16_6_ = v16_2_.horses
    local v16_7_ = v16_2_.riding
    v16_5_ = v16_6_[v16_7_]
    local v16_4_ = v16_5_.stats
    if v16_3_ == 4.000000 then
        if a1 then
            v16_6_ = v0_49_
            v16_5_ = v16_6_["Sliding Stop"]
            local v16_8_ = v16_5_.stat
            v16_7_ = v16_4_[v16_8_]
            v16_6_ = v16_7_.level
            v16_7_ = v16_5_.level
            if v16_6_ < v16_7_ then
                return
            end
            v16_6_ = v0_40_
            if not v16_6_ then
                v16_6_ = v0_38_
                if v16_6_ then
                    return
                end
            end
            return
        end
    end
    if v16_3_ == 0.000000 then
        v16_5_ = v0_39_
        if v16_5_ then
            return
        end
        v16_6_ = v0_49_
        v16_5_ = v16_6_["Leg Yield"]
        local v16_8_ = v16_5_.stat
        v16_7_ = v16_4_[v16_8_]
        v16_6_ = v16_7_.level
        v16_7_ = v16_5_.level
        if v16_7_ <= v16_6_ then
            v0_41_ = nil
        end
        v16_6_ = v0_49_
        v16_5_ = v16_6_.Piaffe
        v16_8_ = v16_5_.stat
        v16_7_ = v16_4_[v16_8_]
        v16_6_ = v16_7_.level
        v16_7_ = v16_5_.level
        if v16_7_ <= v16_6_ then
            v16_6_ = v0_71_
            v16_7_ = v16_1_
            v16_8_ = a1
            v16_6_(v16_7_, v16_8_)
        end
    end
end
v0_75_ = v0_32_.Star
v0_74_ = v0_75_.InputBegan
local v0_76_ = function(a1, a2)
    local v17_2_ = a1.UserInputType
    local v17_3_ = v0_73_
    local v17_4_ = true
    v17_3_(v17_4_)
    v17_3_ = nil
    v17_4_ = a1.Changed
    local v17_6_ = function()
        local v18_1_ = a1
        local v18_0_ = v18_1_.UserInputType
        v17_2_ = v18_0_
        v18_1_ = a1
        v18_0_ = v18_1_.UserInputState
        local End = Enum.UserInputState.End
        if v18_0_ == End then
            v18_0_ = v17_2_
            local MouseButton1 = Enum.UserInputType.MouseButton1
            if v18_0_ ~= MouseButton1 then
                v18_0_ = v17_2_
                local Touch = Enum.UserInputType.Touch
                if v18_0_ ~= Touch then
                    v18_0_ = v17_2_
                    local Gamepad1 = Enum.UserInputType.Gamepad1
                    if v18_0_ == Gamepad1 then
                        v18_0_ = v0_73_
                        v18_1_ = false
                        v18_0_(v18_1_)
                        v18_0_ = v17_3_
                        v18_0_:Disconnect()
                    end
                end
            end
            v18_0_ = v0_73_
            v18_1_ = false
            v18_0_(v18_1_)
            v18_0_ = v17_3_
            v18_0_:Disconnect()
        end
    end
    v17_4_ = v17_4_:Connect(v17_6_)
    v17_3_ = v17_4_
end
v0_74_:Connect(v0_76_)
v0_74_ = function(a1, a2)
    local v19_2_ = false
    v0_41_ = a1
    v19_2_ = v0_71_
    local v19_3_ = a1
    local v19_4_ = false
    v19_2_(v19_3_, v19_4_)
    v19_2_ = 4
    if v19_2_ < a2 then
        v19_1_ = 4
    else
        v19_2_ = -1
        if a2 < v19_2_ then
            v19_1_ = -1
        else
            v19_2_ = pairs
            v19_3_ = v0_58_
            v19_2_, v19_3_, v19_4_ = v19_2_(v19_3_)
            for v19_5_, v19_6_ in v19_2_, v19_3_, v19_4_ do
                local v19_9_ = 0.250000
            end
            v19_4_ = "Speed"
            v19_2_ = a1:GetAttribute(v19_4_)
            v19_3_ = 2
            if v19_3_ <= a2 then
                v19_4_ = v0_58_
                local v19_6_ = "Ride"
                local v19_7_ = a2
                local v19_5_ = v19_6_
                v19_3_ = v19_4_[v19_5_]
                v19_5_ = nil
                v19_6_ = nil
                local v19_9_ = v0_44_
                local v19_8_ = v19_9_.baseSpeed
                v19_7_ = v19_2_ / v19_8_
                v19_3_:Play(v19_5_, v19_6_, v19_7_)
            end
        end
    end
    v19_4_ = "Gait"
    local v19_5_ = a2
    a1:SetAttribute(v19_4_, v19_5_)
    v19_4_ = v0_24_
    v19_3_ = v19_4_.Reliable
    v19_2_ = v19_3_.HorseGait
    v19_4_ = a2
    v19_2_:FireServer(v19_4_)
    local clock = os.clock
    v19_2_ = clock()
    v0_36_ = v19_5_
end
UpdateGait = v0_74_
v0_74_ = function(a1, a2)
    local v20_2_ = UpdateGait
    local v20_3_ = a1
    local v20_4_ = a2
    v20_2_(v20_3_, v20_4_)
    local spawn = task.spawn
    v20_3_ = function()
        local v21_0_ = true
        v0_37_ = v21_0_
        local wait = task.wait
        local v21_1_ = 0.500000
        wait(v21_1_)
        v21_0_ = false
        v0_37_ = v21_0_
        v21_0_ = UpdateGait
        v21_1_ = a1
        local v21_2_ = 0
        v21_0_(v21_1_, v21_2_)
    end
    spawn(v20_3_)
end
v0_75_ = function(a1, a2)
    local v22_4_ = "Gait"
    local v22_2_ = a1:GetAttribute(v22_4_)
    local clock = os.clock
    v22_4_ = clock()
    local v22_5_ = v0_36_
    local v22_3_ = v22_4_ - v22_5_
    local v22_6_ = "Rate"
    v22_4_ = a1:GetAttribute(v22_6_)
    if v22_4_ < v22_3_ then
        v22_5_ = v0_13_
        v22_4_ = v22_5_.MoveVector
        v22_4_ = v22_4_()
        v22_3_ = v22_4_.Z
        v22_5_ = v22_3_
        local abs = math.abs
        v22_4_ = abs(v22_5_)
        if v22_4_ == 1.000000 then
            v22_5_ = v0_39_
            if v22_5_ then
                v22_4_ = true
            else
                v22_5_ = v0_38_
                if v22_5_ then
                    v22_4_ = true
                else
                    v22_5_ = v0_41_
                    if v22_5_ then
                        v22_4_ = true
                    else
                        v22_6_ = v0_23_
                        v22_5_ = v22_6_.Anchored
                        if v22_5_ then
                            v22_4_ = true
                        else
                            v22_5_ = v0_37_
                            if v22_5_ then
                                v22_4_ = true
                            else
                                v22_4_ = false
                            end
                        end
                    end
                end
            end
            if not v22_4_ then
                v22_4_ = UpdateGait
                v22_5_ = a1
                v22_6_ = v22_2_ - v22_3_
                v22_4_(v22_5_, v22_6_)
            end
        end
    end
    v22_4_ = v0_23_
    v22_3_ = v22_4_.CFrame
    v22_6_ = v0_21_
    v22_5_ = v22_6_.LowerTorso
    v22_4_ = v22_5_.CFrame
    local v22_7_ = v0_22_
    v22_6_ = v22_7_.HipHeight
    v22_5_ = nil - "MoveVector"
    v22_6_ = 0
    if v22_6_ < v22_2_ then
        v22_6_ = v0_5_
        v22_7_ = v22_4_
        local v22_9_ = v0_22_
        local v22_8_ = v22_9_.WalkSpeed
        v22_9_ = v22_5_
        v22_6_ = v22_6_(v22_7_, v22_8_, v22_9_)
        if v22_6_ then
            v22_6_ = UpdateGait
            v22_7_ = a1
            v22_8_ = -1
            v22_6_(v22_7_, v22_8_)
            local spawn = task.spawn
            v22_7_ = function()
                local v23_0_ = true
                v0_37_ = v23_0_
                local wait = task.wait
                local v23_1_ = 0.500000
                wait(v23_1_)
                v23_0_ = false
                v0_37_ = v23_0_
                v23_0_ = UpdateGait
                v23_1_ = a1
                local v23_2_ = 0
                v23_0_(v23_1_, v23_2_)
            end
            spawn(v22_7_)
        else
            v22_6_ = 0
            if v22_2_ < v22_6_ then
                v22_6_ = v0_5_
                local Angles = CFrame.Angles
                v22_9_ = 0
                local v22_10_ = 3.141593
                local v22_11_ = 0
                v22_8_ = Angles(v22_9_, v22_10_, v22_11_)
                v22_7_ = v22_4_ * v22_8_
                v22_8_ = 5
                v22_9_ = v22_5_
                v22_6_ = v22_6_(v22_7_, v22_8_, v22_9_)
                if v22_6_ then
                    v22_6_ = UpdateGait
                    v22_7_ = a1
                    v22_8_ = 1
                    v22_6_(v22_7_, v22_8_)
                    local spawn = task.spawn
                    v22_7_ = function()
                        local v24_0_ = true
                        v0_37_ = v24_0_
                        local wait = task.wait
                        local v24_1_ = 0.500000
                        wait(v24_1_)
                        v24_0_ = false
                        v0_37_ = v24_0_
                        v24_0_ = UpdateGait
                        v24_1_ = a1
                        local v24_2_ = 0
                        v24_0_(v24_1_, v24_2_)
                    end
                    spawn(v22_7_)
                end
            end
        end
    else
        v22_6_ = 0
        if v22_2_ < v22_6_ then
            v22_6_ = v0_5_
            local Angles = CFrame.Angles
            local v22_9_ = 0
            local v22_10_ = 3.141593
            local v22_11_ = 0
            local v22_8_ = Angles(v22_9_, v22_10_, v22_11_)
            v22_7_ = v22_4_ * v22_8_
            v22_8_ = 5
            v22_9_ = v22_5_
            v22_6_ = v22_6_(v22_7_, v22_8_, v22_9_)
            if v22_6_ then
                v22_6_ = UpdateGait
                v22_7_ = a1
                v22_8_ = 1
                v22_6_(v22_7_, v22_8_)
                local spawn = task.spawn
                v22_7_ = function()
                    local v25_0_ = true
                    v0_37_ = v25_0_
                    local wait = task.wait
                    local v25_1_ = 0.500000
                    wait(v25_1_)
                    v25_0_ = false
                    v0_37_ = v25_0_
                    v25_0_ = UpdateGait
                    v25_1_ = a1
                    local v25_2_ = 0
                    v25_0_(v25_1_, v25_2_)
                end
                spawn(v22_7_)
            end
        end
    end
    local v22_8_ = v0_13_
    v22_7_ = v22_8_.MoveVector
    v22_7_ = v22_7_()
    v22_6_ = v22_7_.X
    local v22_9_ = -1
    local v22_10_ = 1
    v22_8_ = v22_6_
    local clamp = math.clamp
    v22_7_ = clamp(v22_8_, v22_9_, v22_10_)
    v22_6_ = v22_7_
    v22_8_ = v22_6_
    local round = math.round
    v22_7_ = round(v22_8_)
    v22_10_ = "Speed"
    v22_8_ = a1:GetAttribute(v22_10_)
    local v22_11_ = v0_50_
    v22_10_ = v22_11_[v22_2_]
    v22_9_ = v22_8_ * v22_10_
    v22_10_ = v0_22_
    v22_10_.WalkSpeed = v22_9_
    v22_11_ = v0_34_
    v22_10_ = v22_11_[a1]
    v22_11_ = function(a1, a2)
        local v26_2_ = pairs
        local v26_3_ = a1
        local v26_2_, v26_3_, v26_4_ = v26_2_(v26_3_)
        for v26_5_, v26_6_ in v26_2_, v26_3_, v26_4_ do
            local v26_8_ = v22_10_
            local v26_7_ = v26_8_[v26_5_]
            v26_8_ = v26_7_.IsPlaying
            if v26_8_ then
                local v26_10_ = v0_24_
                local v26_9_ = v26_10_.Reliable
                v26_8_ = v26_9_[a2]
                v26_10_ = v26_5_
                local v26_11_ = false
                v26_8_:FireServer(v26_10_, v26_11_)
                v26_7_:Stop()
                return
            end
        end
    end
    local v22_12_ = function(a1, a2)
        local v27_2_ = pairs
        local v27_3_ = a1
        local v27_2_, v27_3_, v27_4_ = v27_2_(v27_3_)
        for v27_5_, v27_6_ in v27_2_, v27_3_, v27_4_ do
            local v27_7_ = v22_7_
            if v27_7_ == v27_6_ then
                local v27_8_ = v22_10_
                v27_7_ = v27_8_[v27_5_]
                v27_8_ = v27_7_.IsPlaying
                if not v27_8_ then
                    local v27_10_ = v0_24_
                    local v27_9_ = v27_10_.Reliable
                    v27_8_ = v27_9_[a2]
                    v27_10_ = v27_5_
                    local v27_11_ = true
                    v27_8_:FireServer(v27_10_, v27_11_)
                    v27_7_:Play()
                    v27_9_ = v0_8_
                    v27_8_ = v27_9_.Trigger
                    v27_10_ = v27_7_
                    v27_8_:Fire(v27_10_)
                    return
                end
            end
        end
    end
    local v22_13_ = function(a1, a2, a3)
        if not a3 then
            v28_2_ = 0.100000
        end
        local v28_4_ = v22_10_
        local v28_3_ = v28_4_[a1]
        if a2 then
            v28_4_ = v28_3_.IsPlaying
            if not v28_4_ then
                local v28_6_ = a3
                local v28_9_ = "Weight"
                v28_3_:Play(v28_3_:GetAttribute(v28_9_))
                v28_6_ = v0_24_
                local v28_5_ = v28_6_.Reliable
                v28_4_ = v28_5_.HorseTurn
                v28_6_ = a1
                local v28_7_ = true
                local v28_8_ = a3
                v28_4_:FireServer(v28_6_, v28_7_, v28_8_)
                return
            end
        end
        if not a2 then
            v28_4_ = v28_3_.IsPlaying
            if v28_4_ then
                local v28_6_ = a3
                v28_3_:Stop(v28_6_)
                v28_6_ = v0_24_
                local v28_5_ = v28_6_.Reliable
                v28_4_ = v28_5_.HorseTurn
                v28_6_ = a1
                local v28_7_ = false
                local v28_8_ = a3
                v28_4_:FireServer(v28_6_, v28_7_, v28_8_)
            end
        end
    end
    local v22_14_ = false
    local v22_17_ = v22_6_
    local abs = math.abs
    local v22_16_ = abs(v22_17_)
    v22_17_ = 0.500000
    if v22_17_ >= v22_16_ then
        local v22_15_ = false
    end
    local v22_15_ = true
    if v22_15_ then
        v22_17_ = v0_39_
        if v22_17_ then
            v22_16_ = true
        else
            v22_17_ = v0_38_
            if v22_17_ then
                v22_16_ = true
            else
                v22_17_ = v0_41_
                if v22_17_ then
                    v22_16_ = true
                else
                    local v22_18_ = v0_23_
                    v22_17_ = v22_18_.Anchored
                    if v22_17_ then
                        v22_16_ = true
                    else
                        v22_17_ = v0_37_
                        if v22_17_ then
                            v22_16_ = true
                        else
                            v22_16_ = false
                        end
                    end
                end
            end
        end
        if not v22_16_ then
            v22_17_ = 1
            local v22_18_ = v22_2_ * 0.250000
            v22_16_ = v22_17_ + v22_18_
            v22_18_ = v0_22_
            v22_17_ = v22_18_.WalkSpeed
            if v22_17_ == 0.000000 then
                v22_17_ = v0_6_
                v22_18_ = v22_4_
                local v22_19_ = v22_7_
                local v22_20_ = v22_5_
                v22_17_ = v22_17_(v22_18_, v22_19_, v22_20_)
                if not v22_17_ then
                    v22_17_ = v0_22_
                    v22_18_ = 0.010000
                    v22_17_.WalkSpeed = v22_18_
                    v22_16_ = 2
                    v22_14_ = true
                    v22_17_ = v0_71_
                    v22_18_ = a1
                    v22_19_ = false
                    v22_17_(v22_18_, v22_19_)
                    v22_17_ = v22_13_
                    v22_18_ = "Turn"
                    v22_19_ = true
                    v22_17_(v22_18_, v22_19_)
                end
            end
            v22_1_ = 0.016667
            local Angles = CFrame.Angles
            v22_18_ = 0
            local v22_24_ = "Turn"
            local v22_22_ = a1:GetAttribute(v22_24_)
            local v22_21_ = v22_22_ / v22_16_
            v22_22_ = -v22_6_
            local v22_20_ = v22_21_ * v22_22_
            local v22_19_ = v22_20_ * v22_1_
            v22_20_ = 0
            v22_17_ = Angles(v22_18_, v22_19_, v22_20_)
            v22_3_ *= v22_17_
        end
    end
    if not v22_14_ then
        v22_16_ = v22_13_
        v22_17_ = "Turn"
        local v22_18_ = false
        v22_16_(v22_17_, v22_18_)
    end
    if v22_15_ then
        v22_16_ = v0_41_
        if not v22_16_ then
            v22_16_ = v0_69_
            v22_17_ = a1
            v22_16_ = v22_16_(v22_17_)
            if not v22_16_ then
                v22_16_ = nil
                v22_17_ = nil
                local v22_18_ = 0
                if v22_6_ < v22_18_ then
                    v22_16_ = "TurnHeadLeft"
                    v22_17_ = "TurnHeadRight"
                else
                    v22_16_ = "TurnHeadRight"
                    v22_17_ = "TurnHeadLeft"
                end
                v22_18_ = v22_13_
                local v22_19_ = v22_17_
                local v22_20_ = false
                local v22_21_ = 0.200000
                v22_18_(v22_19_, v22_20_, v22_21_)
                v22_18_ = v22_13_
                v22_19_ = v22_16_
                v22_20_ = true
                v22_21_ = 0.200000
                v22_18_(v22_19_, v22_20_, v22_21_)
            else
                v22_16_ = v0_41_
                if not v22_16_ then
                    v22_16_ = v0_69_
                    v22_17_ = a1
                    v22_16_ = v22_16_(v22_17_)
                    if not v22_16_ then
                        v22_16_ = v22_13_
                        v22_17_ = "TurnHeadLeft"
                        local v22_18_ = false
                        local v22_19_ = 0.200000
                        v22_16_(v22_17_, v22_18_, v22_19_)
                        v22_16_ = v22_13_
                        v22_17_ = "TurnHeadRight"
                        v22_18_ = false
                        v22_19_ = 0.200000
                        v22_16_(v22_17_, v22_18_, v22_19_)
                    end
                end
            end
        else
            v22_16_ = v0_41_
            if not v22_16_ then
                v22_16_ = v0_69_
                v22_17_ = a1
                v22_16_ = v22_16_(v22_17_)
                if not v22_16_ then
                    v22_16_ = v22_13_
                    v22_17_ = "TurnHeadLeft"
                    local v22_18_ = false
                    local v22_19_ = 0.200000
                    v22_16_(v22_17_, v22_18_, v22_19_)
                    v22_16_ = v22_13_
                    v22_17_ = "TurnHeadRight"
                    v22_18_ = false
                    v22_19_ = 0.200000
                    v22_16_(v22_17_, v22_18_, v22_19_)
                end
            end
        end
    else
        v22_16_ = v0_41_
        if not v22_16_ then
            v22_16_ = v0_69_
            v22_17_ = a1
            v22_16_ = v22_16_(v22_17_)
            if not v22_16_ then
                v22_16_ = v22_13_
                v22_17_ = "TurnHeadLeft"
                local v22_18_ = false
                local v22_19_ = 0.200000
                v22_16_(v22_17_, v22_18_, v22_19_)
                v22_16_ = v22_13_
                v22_17_ = "TurnHeadRight"
                v22_18_ = false
                v22_19_ = 0.200000
                v22_16_(v22_17_, v22_18_, v22_19_)
            end
        end
    end
    if v22_15_ then
        v22_16_ = 2
        if v22_16_ < v22_2_ then
            v22_16_ = 0
            if v22_6_ < v22_16_ then
                v22_17_ = v0_59_
                v22_16_ = v22_17_.IsPlaying
                if not v22_16_ then
                    v22_16_ = v0_60_
                    local v22_18_ = 0.200000
                    v22_16_:Stop(v22_18_)
                    v22_16_ = v0_59_
                    v22_18_ = 0.400000
                    v22_16_:Play(v22_18_)
                    v22_17_ = v0_60_
                    v22_16_ = v22_17_.IsPlaying
                    if not v22_16_ then
                        v22_16_ = v0_59_
                        v22_18_ = 0.200000
                        v22_16_:Stop(v22_18_)
                        v22_16_ = v0_60_
                        v22_18_ = 0.400000
                        v22_16_:Play(v22_18_)
                        v22_16_ = v0_59_
                        v22_18_ = 0.200000
                        v22_16_:Stop(v22_18_)
                        v22_16_ = v0_60_
                        v22_18_ = 0.200000
                        v22_16_:Stop(v22_18_)
                    end
                end
            else
                v22_17_ = v0_60_
                v22_16_ = v22_17_.IsPlaying
                if not v22_16_ then
                    v22_16_ = v0_59_
                    local v22_18_ = 0.200000
                    v22_16_:Stop(v22_18_)
                    v22_16_ = v0_60_
                    v22_18_ = 0.400000
                    v22_16_:Play(v22_18_)
                    v22_16_ = v0_59_
                    v22_18_ = 0.200000
                    v22_16_:Stop(v22_18_)
                    v22_16_ = v0_60_
                    v22_18_ = 0.200000
                    v22_16_:Stop(v22_18_)
                end
            end
        else
            v22_16_ = v0_59_
            local v22_18_ = 0.200000
            v22_16_:Stop(v22_18_)
            v22_16_ = v0_60_
            v22_18_ = 0.200000
            v22_16_:Stop(v22_18_)
        end
    else
        v22_16_ = v0_59_
        local v22_18_ = 0.200000
        v22_16_:Stop(v22_18_)
        v22_16_ = v0_60_
        v22_18_ = 0.200000
        v22_16_:Stop(v22_18_)
    end
    v22_16_ = v0_22_
    local v22_18_ = v22_3_.LookVector
    v22_16_:Move(v22_18_)
    v22_16_ = v0_23_
    v22_18_ = "BodyVelocity"
    v22_16_ = v22_16_:FindFirstChild(v22_18_)
    v22_17_ = function()
        local new = Instance.new
        local v29_1_ = "BodyVelocity"
        local v29_0_ = new(v29_1_)
        v22_16_ = v29_0_
        v29_0_ = v22_16_
        v29_1_ = Vector3.new(400000.000000, 0.000000, 400000.000000)
        v29_0_.MaxForce = v29_1_
        v29_0_ = v22_16_
        v29_1_ = v0_23_
        v29_0_.Parent = v29_1_
    end
    v22_18_ = {}
    local v22_19_ = -1
    v22_18_.LegYieldLeft = v22_19_
    v22_19_ = 1
    v22_18_.LegYieldRight = v22_19_
    if v22_2_ == -1.000000 then
        if not v22_16_ then
            local new = Instance.new
            local v22_20_ = "BodyVelocity"
            v22_19_ = new(v22_20_)
            v22_16_ = v22_19_
            v22_19_ = Vector3.new(400000.000000, 0.000000, 400000.000000)
            v22_16_.MaxForce = v22_19_
            v22_19_ = v0_23_
            v22_16_.Parent = v22_19_
        end
        local v22_20_ = v22_3_.LookVector
        v22_19_ = v22_20_ * v22_9_
        v22_16_.Velocity = v22_19_
    else
        if v22_15_ then
            v22_19_ = v0_41_
            if v22_19_ then
                v22_19_ = v0_4_
                local v22_20_ = v22_4_
                local v22_21_ = v22_7_
                local v22_22_ = v22_5_
                v22_19_ = v22_19_(v22_20_, v22_21_, v22_22_)
                if not v22_19_ then
                    v22_19_ = v0_39_
                    if not v22_19_ then
                        if not v22_16_ then
                            local new = Instance.new
                            v22_20_ = "BodyVelocity"
                            v22_19_ = new(v22_20_)
                            v22_16_ = v22_19_
                            v22_19_ = Vector3.new(400000.000000, 0.000000, 400000.000000)
                            v22_16_.MaxForce = v22_19_
                            v22_19_ = v0_23_
                            v22_16_.Parent = v22_19_
                        end
                        v22_22_ = v0_50_
                        v22_21_ = v22_22_[-1]
                        v22_20_ = v22_8_ * v22_21_
                        v22_19_ = v22_20_ * 0.700000
                        local v22_23_ = v22_3_.RightVector
                        v22_22_ = v22_23_ * v22_7_
                        v22_21_ = v22_22_ * v22_19_
                        v22_23_ = v22_3_.LookVector
                        v22_22_ = v22_23_ * v22_19_
                        v22_20_ = v22_21_ + v22_22_
                        v22_16_.Velocity = v22_20_
                        v22_20_ = v0_71_
                        v22_21_ = a1
                        v22_22_ = false
                        v22_20_(v22_21_, v22_22_)
                        v22_20_ = v22_12_
                        v22_21_ = v22_18_
                        v22_22_ = "HorseLegYield"
                        v22_20_(v22_21_, v22_22_)
                    else
                        if v22_16_ then
                            v22_16_:Destroy()
                            v22_19_ = v22_11_
                            v22_20_ = v22_18_
                            v22_21_ = "HorseLegYield"
                            v22_19_(v22_20_, v22_21_)
                        end
                    end
                else
                    if v22_16_ then
                        v22_16_:Destroy()
                        v22_19_ = v22_11_
                        v22_20_ = v22_18_
                        v22_21_ = "HorseLegYield"
                        v22_19_(v22_20_, v22_21_)
                    end
                end
            else
                if v22_16_ then
                    v22_16_:Destroy()
                    v22_19_ = v22_11_
                    local v22_20_ = v22_18_
                    local v22_21_ = "HorseLegYield"
                    v22_19_(v22_20_, v22_21_)
                end
            end
        else
            if v22_16_ then
                v22_16_:Destroy()
                v22_19_ = v22_11_
                local v22_20_ = v22_18_
                local v22_21_ = "HorseLegYield"
                v22_19_(v22_20_, v22_21_)
            end
        end
    end
end
v0_76_ = function(a1, a2, a3)
    local v30_3_ = a1.PrimaryPart
    local v30_5_ = a1.Head
    local v30_4_ = v30_5_.Lead
    local v30_8_ = "NewMesh"
    local v30_6_ = a1:GetAttribute(v30_8_)
    if v30_6_ then
        v30_5_ = a1:GetScale()
    else
        local v30_7_ = "BodyHeight"
        v30_5_ = a1:GetAttribute(v30_7_)
    end
    v30_6_ = a1.Node
    v30_8_ = a1.Rider
    local v30_7_ = v30_8_.Value
    if v30_7_ then
        if a3 then
            local v30_10_ = v30_7_.LowerTorso
            local v30_9_ = v30_10_.CFrame
            local v30_12_ = "RidingOffset"
            v30_10_ = a1:GetAttribute(v30_12_)
            if not v30_10_ then
                v30_10_ = v0_10_
                local v30_11_ = 0
                v30_12_ = v30_5_
                v30_10_ = v30_10_(v30_11_, v30_12_)
            end
            v30_8_ = v30_9_ * v30_10_
            v30_3_.CFrame = v30_8_
        else
            if a3 then
                v30_8_ = v30_6_.Value
                v30_3_.CFrame = v30_8_
            end
        end
    else
        if a3 then
            v30_8_ = v30_6_.Value
            v30_3_.CFrame = v30_8_
        end
    end
    local v30_11_ = v0_47_
    local v30_10_ = v30_11_.distance
    local v30_9_ = v30_10_ * v30_5_
    v30_8_ = v30_9_ * 2.000000
    v30_9_ = a2.Trot
    v30_10_ = nil
    v30_11_ = v30_6_.Changed
    local v30_13_ = function(a1)
        local v31_3_ = a1.Position
        local v31_5_ = v30_3_
        local v31_4_ = v31_5_.Position
        local v31_2_ = v31_3_ - v31_4_
        local v31_1_ = v31_2_.Magnitude
        v31_2_ = v30_8_
        if v31_1_ < v31_2_ then
            v31_2_ = v30_4_
            v31_1_ = v31_2_.Attachment1
            if v31_1_ then
                v31_2_ = v30_9_
                v31_1_ = v31_2_.IsPlaying
                if not v31_1_ then
                    v31_1_ = v30_9_
                    v31_3_ = 0.100000
                    v31_4_ = 1
                    v31_5_ = 1
                    v31_1_:Play(v31_3_, v31_4_, v31_5_)
                end
                v31_1_ = v0_1_
                v31_3_ = v30_3_
                local new = TweenInfo.new
                v31_5_ = 0.500000
                local Linear = Enum.EasingStyle.Linear
                v31_4_ = new(v31_5_, Linear)
                v31_5_ = {}
                v31_5_.CFrame = a1
                v31_1_ = v31_1_:Create(v31_3_, v31_4_, v31_5_)
                v30_10_ = v31_4_
                v31_1_ = v30_10_
                v31_1_:Play()
                v31_2_ = v30_10_
                v31_1_ = v31_2_.Completed
                v31_1_:Wait()
                v31_2_ = v30_4_
                v31_1_ = v31_2_.Attachment1
                if v31_1_ then
                    local v31_7_ = v31_1_.Parent
                    local v31_6_ = v31_7_.Parent
                    v31_5_ = v31_6_.HumanoidRootPart
                    v31_4_ = v31_5_.Position
                    v31_6_ = v30_3_
                    v31_5_ = v31_6_.Position
                    v31_3_ = v31_4_ - v31_5_
                    v31_2_ = v31_3_.Magnitude
                    v31_3_ = v30_8_
                    if v31_2_ <= v31_3_ then
                        v31_2_ = v30_9_
                        v31_2_:Stop()
                        return
                    end
                end
                v31_2_ = v30_9_
                v31_2_:Stop()
                return
            end
        end
        v31_1_ = v30_10_
        if v31_1_ then
            v31_1_ = v30_10_
            v31_1_:Cancel()
            v31_1_ = nil
            v30_10_ = v31_4_
        end
        v31_1_ = v30_3_
        v31_1_.CFrame = a1
        v31_1_ = v30_9_
        v31_1_:Stop()
    end
    v30_11_:Connect(v30_13_)
    v30_13_ = "Attachment1"
    v30_11_ = v30_4_:GetPropertyChangedSignal(v30_13_)
    v30_13_ = function()
        local v32_0_ = v30_9_
        v32_0_:Stop()
    end
    v30_11_:Connect(v30_13_)
end
local v0_77_ = function(a1)
    local v33_1_ = a1.Head
    local v33_2_ = {}
    local v33_3_, v33_4_, v33_5_ = v33_1_:GetChildren()
    local find = string.find
    local v33_9_ = nil.Name
    local v33_10_ = "Eye"
    local v33_8_ = find(v33_9_, v33_10_)
    if v33_8_ then
        v33_8_ = table.create(2)
        v33_9_ = nil.Size
        local v33_11_ = nil.Decal
        v33_10_ = v33_11_.Texture
        v33_8_[1] = v33_9_
        v33_8_[2] = v33_10_
        v33_2_[nil] = v33_8_
    end
    v33_3_ = {}
    v33_4_ = pairs
    v33_5_ = v33_2_
    local v33_4_, v33_5_, v33_6_ = v33_4_(v33_5_)
    for v33_7_, v33_8_ in v33_4_, v33_5_, v33_6_ do
        v33_9_ = v33_8_[-1]
        v33_10_ = v0_1_
        local v33_12_ = v33_7_
        local new = TweenInfo.new
        local v33_14_ = 0.150000
        local Linear = Enum.EasingStyle.Linear
        local Out = Enum.EasingDirection.Out
        local v33_17_ = 0
        local v33_18_ = true
        local v33_13_ = new(v33_14_, Linear, Out, v33_17_, v33_18_)
        v33_14_ = {}
        local v33_16_ = v33_9_.X
        v33_17_ = 0
        v33_18_ = v33_9_.Z
        local new = Vector3.new
        local v33_15_ = new(v33_16_, v33_17_, v33_18_)
        v33_14_.Size = v33_15_
        v33_10_ = v33_10_:Create(v33_12_, v33_13_, v33_14_)
    end
    v33_4_ = function()
        local v34_0_ = true
        local v34_1_ = a1
        local v34_3_ = "Resting"
        v34_1_ = v34_1_:GetAttribute(v34_3_)
        if v34_1_ ~= "Sleep" then
            v34_0_ = a1
            local v34_2_ = "EyesClosed"
            v34_0_ = v34_0_:GetAttribute(v34_2_)
        end
        v34_1_ = pairs
        local v34_2_ = v33_2_
        v34_1_, v34_2_, v34_3_ = v34_1_(v34_2_)
        for v34_4_, v34_5_ in v34_1_, v34_2_, v34_3_ do
            local v34_6_ = v34_5_[-1]
            local v34_8_ = v34_6_.X
            if v34_0_ then
                local v34_9_ = 0.030000
            else
                local v34_9_ = v34_6_.Y
            end
            local v34_10_ = v34_6_.Z
            local new = Vector3.new
            local v34_7_ = new(v34_8_, nil, v34_10_)
            v34_4_.Size = v34_7_
            v34_7_ = v34_4_.Decal
            if v34_0_ then
                v34_8_ = ""
            else
                v34_8_ = v34_5_[0]
            end
            v34_7_.Texture = v34_8_
        end
    end
    local v33_7_ = "Resting"
    v33_5_ = a1:GetAttributeChangedSignal(v33_7_)
    v33_7_ = v33_4_
    v33_5_:Connect(v33_7_)
    v33_7_ = "EyesClosed"
    v33_5_ = a1:GetAttributeChangedSignal(v33_7_)
    v33_7_ = v33_4_
    v33_5_:Connect(v33_7_)
    local wait = task.wait
    v33_6_ = v0_35_
    v33_8_ = 4
    v33_9_ = 7
    v33_5_ = wait(v33_6_:NextInteger(v33_8_, v33_9_))
    while v33_5_ do
        v33_5_ = a1.Parent
        while v33_5_ do
            v33_7_ = "Resting"
            v33_5_ = a1:GetAttribute(v33_7_)
            if v33_5_ ~= "Sleep" then
                v33_7_ = "EyesClosed"
                v33_5_ = a1:GetAttribute(v33_7_)
                if not v33_5_ then
                    v33_5_ = pairs
                    v33_6_ = v33_3_
                    v33_5_, v33_6_, v33_7_ = v33_5_(v33_6_)
                    for v33_8_, v33_9_ in v33_5_, v33_6_, v33_7_ do
                        v33_10_ = v33_8_.Decal
                        local v33_11_ = ""
                        v33_10_.Texture = v33_11_
                        v33_9_:Play()
                        local defer = task.defer
                        local v33_12_ = function()
                            local v35_1_ = v33_9_
                            local v35_0_ = v35_1_.Completed
                            v35_0_:Wait()
                            v35_0_ = v33_10_
                            local v35_3_ = v33_2_
                            local v35_4_ = v33_8_
                            local v35_2_ = v35_3_[v35_4_]
                            v35_1_ = v35_2_[0]
                            v35_0_.Texture = v35_1_
                        end
                    end
                end
            end
        end
    end
end
local v0_78_ = function(a1, a2)
    local v36_4_ = "Hidden"
    local v36_2_ = a1:GetAttribute(v36_4_)
    if v36_2_ then
        return
    end
    v36_4_ = "NewMesh"
    v36_2_ = a1:GetAttribute(v36_4_)
    if v36_2_ then
        local v36_5_ = "RootPart"
        local v36_3_ = a1:WaitForChild(v36_5_)
    else
        local v36_5_ = "HumanoidRootPart"
        local v36_3_ = a1:WaitForChild(v36_5_)
    end
    local v36_6_ = "Rider"
    v36_4_ = a1:WaitForChild(v36_6_)
    local v36_5_ = v0_63_
    v36_6_ = a1
    v36_5_(v36_6_)
    v36_5_ = v0_65_
    v36_6_ = a1
    v36_5_ = v36_5_(v36_6_)
    v36_6_ = v0_67_
    local v36_7_ = a1
    v36_6_ = v36_6_(v36_7_)
    if v36_2_ then
        local v36_9_ = "Bridle"
        v36_7_ = a1:WaitForChild(v36_9_)
        local v36_10_ = "Folder"
        local v36_8_ = v36_7_:IsA(v36_10_)
        if v36_8_ then
            v36_9_ = v36_7_:GetChildren()
            v36_8_ = v36_9_[-1]
            local time = os.time
            v36_9_ = time()
            while not v36_8_ do
                local time = os.time
                local v36_11_ = time()
                v36_10_ = v36_11_ - v36_9_
                v36_11_ = 5
                while v36_10_ < v36_11_ do
                    local wait = task.wait
                    wait()
                    v36_10_ = v36_7_:GetChildren()
                    v36_8_ = v36_10_[-1]
                end
            end
            if v36_8_ then
                local v36_12_ = "Transparency"
                v36_10_ = v36_8_:GetPropertyChangedSignal(v36_12_)
                v36_12_ = function()
                    local v37_0_ = v0_66_
                    local v37_1_ = a1
                    local v37_2_ = v36_6_
                    v37_0_(v37_1_, v37_2_)
                end
                v36_10_:Connect(v36_12_)
                v36_10_ = "Transparency"
                v36_8_ = v36_7_:GetPropertyChangedSignal(v36_10_)
                v36_10_ = function()
                    local v38_0_ = v0_66_
                    local v38_1_ = a1
                    local v38_2_ = v36_6_
                    v38_0_(v38_1_, v38_2_)
                end
                v36_8_:Connect(v36_10_)
                v36_9_ = "Bridle"
                v36_7_ = a1:WaitForChild(v36_9_)
                v36_9_ = "Main"
                v36_7_ = v36_7_:WaitForChild(v36_9_)
                v36_9_ = "Transparency"
                v36_7_ = v36_7_:GetPropertyChangedSignal(v36_9_)
                v36_9_ = function()
                    local v39_0_ = v0_66_
                    local v39_1_ = a1
                    local v39_2_ = v36_6_
                    v39_0_(v39_1_, v39_2_)
                end
                v36_7_:Connect(v36_9_)
            end
        else
            v36_10_ = "Transparency"
            v36_8_ = v36_7_:GetPropertyChangedSignal(v36_10_)
            v36_10_ = function()
                local v40_0_ = v0_66_
                local v40_1_ = a1
                local v40_2_ = v36_6_
                v40_0_(v40_1_, v40_2_)
            end
            v36_8_:Connect(v36_10_)
            v36_9_ = "Bridle"
            v36_7_ = a1:WaitForChild(v36_9_)
            v36_9_ = "Main"
            v36_7_ = v36_7_:WaitForChild(v36_9_)
            v36_9_ = "Transparency"
            v36_7_ = v36_7_:GetPropertyChangedSignal(v36_9_)
            v36_9_ = function()
                local v41_0_ = v0_66_
                local v41_1_ = a1
                local v41_2_ = v36_6_
                v41_0_(v41_1_, v41_2_)
            end
            v36_7_:Connect(v36_9_)
        end
    else
        local v36_9_ = "Bridle"
        v36_7_ = a1:WaitForChild(v36_9_)
        v36_9_ = "Main"
        v36_7_ = v36_7_:WaitForChild(v36_9_)
        v36_9_ = "Transparency"
        v36_7_ = v36_7_:GetPropertyChangedSignal(v36_9_)
        v36_9_ = function()
            local v42_0_ = v0_66_
            local v42_1_ = a1
            local v42_2_ = v36_6_
            v42_0_(v42_1_, v42_2_)
        end
        v36_7_:Connect(v36_9_)
    end
    v36_7_ = a1.Parent
    if not v36_7_ then
        return
    end
    v36_7_ = v0_66_
    local v36_8_ = a1
    local v36_9_ = v36_6_
    v36_7_(v36_8_, v36_9_)
    v36_7_ = v36_4_.Changed
    v36_9_ = function(a1)
        if a1 then
            local v43_1_ = wait
            local v43_4_ = v0_48_
            local v43_3_ = v43_4_[-1]
            local v43_5_ = v0_48_
            v43_4_ = v43_5_[0]
            local v43_2_ = v43_3_ + v43_4_
            v43_1_(v43_2_)
        end
        local v43_1_ = v0_66_
        local v43_2_ = a1
        local v43_3_ = v36_6_
        v43_1_(v43_2_, v43_3_)
    end
    v36_7_:Connect(v36_9_)
    v36_9_ = "Gait"
    v36_7_ = a1:GetAttributeChangedSignal(v36_9_)
    v36_9_ = function()
        local v44_0_ = v0_64_
        local v44_1_ = a1
        local v44_2_ = v36_5_
        v44_0_(v44_1_, v44_2_)
        v44_0_ = v0_62_
        v44_1_ = a1
        v44_0_(v44_1_)
        v44_2_ = a1
        v44_1_ = v44_2_.CoRider
        v44_0_ = v44_1_.Value
        v44_1_ = v0_21_
        if v44_0_ == v44_1_ then
            v44_0_ = v0_58_
            v44_1_ = nil
            v44_2_ = nil
            local v44_7_ = 0.250000
            nil:Stop(v44_7_)
            v44_0_ = a1
            v44_2_ = "Gait"
            v44_0_ = v44_0_:GetAttribute(v44_2_)
            v44_1_ = 2
            if v44_1_ <= v44_0_ then
                v44_1_ = a1
                local v44_3_ = "Speed"
                v44_1_ = v44_1_:GetAttribute(v44_3_)
                v44_3_ = v0_58_
                local v44_5_ = "Ride"
                local v44_6_ = v44_0_
                local v44_4_ = v44_5_
                v44_2_ = v44_3_[v44_4_]
                v44_4_ = nil
                v44_5_ = nil
                local v44_8_ = v0_44_
                v44_7_ = v44_8_.baseSpeed
                v44_6_ = v44_1_ / v44_7_
                v44_2_:Play(v44_4_, v44_5_, v44_6_)
            end
        end
    end
    v36_7_:Connect(v36_9_)
    v36_9_ = "RidingOffset"
    v36_7_ = a1:GetAttribute(v36_9_)
    local v36_10_ = "AgeStage"
    v36_8_ = a1:GetAttributeChangedSignal(v36_10_)
    v36_10_ = function()
        local v45_1_ = v0_34_
        local v45_2_ = a1
        local v45_0_ = v45_1_[v45_2_]
        v45_1_ = nil
        v45_0_["Lay Down"] = v45_1_
        v45_1_ = v0_34_
        v45_2_ = a1
        v45_0_ = v45_1_[v45_2_]
        v45_1_ = nil
        v45_0_.Sleep = v45_1_
        v45_0_ = a1
        v45_2_ = "RidingOffset"
        v45_0_ = v45_0_:GetAttribute(v45_2_)
        v36_7_ = v45_2_
    end
    v36_8_:Connect(v36_10_)
    v36_8_ = v0_76_
    v36_9_ = a1
    v36_10_ = v36_5_
    local v36_11_ = a2
    v36_8_(v36_9_, v36_10_, v36_11_)
    local defer = task.defer
    v36_9_ = v0_77_
    v36_10_ = a1
    defer(v36_9_, v36_10_)
    v36_8_ = function(a1)
        if not a1 then
            return
        end
        local v46_2_ = v36_4_
        local v46_1_ = v46_2_.Value
        local v46_4_ = "HumanoidRootPart"
        v46_2_ = a1:WaitForChild(v46_4_)
        local v46_5_ = "CoRiding"
        local v46_3_ = a1:WaitForChild(v46_5_)
        local new = CFrame.new
        local v46_6_ = 0
        local v46_7_ = 0
        local v46_8_ = a1
        local v46_10_ = "CoRideOffset"
        v46_5_ = new(v46_8_:GetAttribute(v46_10_))
        local v46_9_ = "LowerTorso"
        v46_7_ = a1:WaitForChild(v46_9_)
        v46_6_ = v46_7_.CFrame
        v46_8_ = v46_2_.CFrame
        v46_6_ = v46_6_:ToObjectSpace(v46_8_)
        v46_4_ = v46_5_ * v46_6_
        local wait = task.wait
        v46_5_ = wait()
        while v46_5_ do
            v46_6_ = a1
            v46_5_ = v46_6_.Parent
            while v46_5_ do
                v46_5_ = v46_3_.Value
                while v46_5_ do
                    local zero = Vector3.zero
                    v46_2_.Velocity = zero
                    v46_9_ = v46_1_.LowerTorso
                    v46_8_ = v46_9_.CFrame
                    v46_7_ = v46_8_ * v46_4_
                    a1:PivotTo(v46_7_)
                end
            end
        end
    end
    local defer = task.defer
    v36_10_ = v36_8_
    local v36_14_ = "CoRider"
    local v36_12_ = a1:WaitForChild(v36_14_)
    v36_11_ = v36_12_.Value
    defer(v36_10_, v36_11_)
    v36_12_ = "CoRider"
    v36_10_ = a1:WaitForChild(v36_12_)
    v36_9_ = v36_10_.Changed
    v36_11_ = v36_8_
    v36_9_:Connect(v36_11_)
    if v36_2_ then
        v36_9_ = nil.LowerTorso
    else
        v36_11_ = "LowerTorso"
        v36_9_ = a1:WaitForChild(v36_11_)
    end
    v36_12_ = nil.Position
    v36_11_ = v36_12_.Y
    if v36_2_ then
        v36_14_ = v36_9_.TransformedWorldCFrame
        local v36_13_ = v36_14_.Position
        v36_12_ = v36_13_.Y
    else
        local v36_13_ = v36_9_.Position
        v36_12_ = v36_13_.Y
    end
    v36_10_ = v36_11_ - v36_12_
    v36_11_ = 0
    v36_12_ = nil
    local v36_13_ = nil
    local v36_15_ = v0_34_
    v36_14_ = v36_15_[a1]
    v36_15_ = v36_14_.Turn
    local v36_16_ = v36_14_.LegYieldLeft
    local v36_17_ = v36_14_.LegYieldRight
    local v36_18_ = v36_14_.Rear
    local v36_19_ = function()
        local v47_0_ = v36_12_
        if not v47_0_ then
            return
        end
        v47_0_ = v36_12_
        v47_0_:Cancel()
        v47_0_ = nil
        v36_12_ = v47_0_
        v47_0_ = v36_13_
        if not v47_0_ then
            return
        end
        local v47_2_ = v36_13_
        local v47_1_ = v47_2_.Parent
        v47_0_ = v47_1_.Parent
        local new = CFrame.new
        v47_2_ = 0
        local v47_6_ = "DefaultRootOffset"
        local v47_4_ = v47_0_:GetAttribute(v47_6_)
        local v47_7_ = v47_0_.Humanoid
        v47_6_ = v47_7_.BodyHeightScale
        local v47_5_ = v47_6_.Value
        local v47_3_ = v47_4_ * v47_5_
        v47_4_ = 0
        v47_1_ = new(v47_2_, v47_3_, v47_4_)
        v47_2_ = v36_13_
        v47_2_.C0 = v47_1_
        v47_2_ = nil
        v36_13_ = v47_1_
    end
    local v36_20_ = a1.Parent
    while v36_20_ do
        local wait = task.wait
        v36_20_ = wait()
        local v36_21_ = a1.Name
        local v36_23_ = v0_19_
        local v36_22_ = v36_23_.Name
        if v36_21_ == v36_22_ then
            v36_23_ = v0_24_
            v36_22_ = v36_23_.Unreliable
            v36_21_ = v36_22_.HorseUpdateCFrame
            local v36_25_ = v0_18_
            local v36_24_ = v36_25_.cframe
            v36_23_ = v36_24_.ser
            v36_24_ = nil.CFrame
            v36_21_:FireServer(v36_23_(v36_24_))
        end
        v36_21_ = v36_4_.Value
        if not v36_21_ then
            v36_22_ = v36_19_
            v36_22_()
        else
            local v36_24_ = "LowerTorso"
            v36_22_ = v36_21_:FindFirstChild(v36_24_)
            if v36_22_ then
                v36_23_ = v0_2_
                local v36_26_ = "DummyMount_"
                local v36_27_ = a1.Name
                local v36_25_ = v36_26_
                v36_23_ = v36_23_:FindFirstChild(v36_25_)
                if not v36_23_ then
                    v36_25_ = "BodyHeight"
                    v36_23_ = a1:GetAttribute(v36_25_)
                    v36_27_ = nil.Position
                    v36_26_ = v36_27_.Y
                    if v36_2_ then
                        local v36_29_ = v36_9_.TransformedWorldCFrame
                        local v36_28_ = v36_29_.Position
                        v36_27_ = v36_28_.Y
                    else
                        local v36_28_ = v36_9_.Position
                        v36_27_ = v36_28_.Y
                    end
                    v36_25_ = v36_26_ - v36_27_
                    v36_24_ = v36_10_ - v36_25_
                    v36_25_ = v0_21_
                    if v36_21_ == v36_25_ then
                        v36_26_ = v0_33_
                        v36_25_ = v36_26_.Visible
                        if v36_25_ then
                            v36_25_ = v0_39_
                            if v36_25_ then
                                v36_25_ = v0_22_
                                v36_26_ = 0.010000
                                v36_25_.WalkSpeed = v36_26_
                            else
                                v36_25_ = v0_75_
                                v36_26_ = a1
                                v36_27_ = v36_20_
                                v36_25_(v36_26_, v36_27_)
                                v36_25_ = v0_21_
                                v36_27_ = "HipHeight"
                                v36_25_ = v36_25_:GetAttribute(v36_27_)
                                local v36_30_ = v0_22_
                                local v36_29_ = v36_30_.BodyHeightScale
                                local v36_28_ = v36_29_.Value
                                v36_27_ = nil - task.defer
                                v36_26_ = v36_27_ * 0.500000
                                if v36_2_ then
                                    v36_27_ = v0_22_
                                    local v36_31_ = "RideHipHeight"
                                    v36_29_ = a1:GetAttribute(v36_31_)
                                    v36_28_ = v36_29_ + v36_24_
                                    v36_27_.HipHeight = v36_28_
                                else
                                    v36_27_ = v0_22_
                                    local v36_31_ = v0_7_
                                    local v36_32_ = v36_25_
                                    local v36_33_ = v36_23_
                                    v36_31_ = v36_31_(v36_32_, v36_33_)
                                    v36_30_ = v36_25_ + v36_31_
                                    v36_33_ = v36_22_.Size
                                    v36_32_ = v36_33_.Y
                                    v36_31_ = v36_32_ * v36_26_
                                    v36_29_ = v36_30_ + v36_31_
                                    v36_28_ = v36_29_ + v36_24_
                                    v36_27_.HipHeight = v36_28_
                                end
                                v36_28_ = "Gait"
                                v36_26_ = a1:GetAttribute(v36_28_)
                                if v36_26_ ~= 0.000000 then
                                    v36_25_ = false
                                end
                                v36_25_ = true
                                v36_26_ = v0_21_
                                if v36_21_ ~= v36_26_ then
                                    v36_27_ = v36_21_.PrimaryPart
                                    v36_26_ = v36_27_.Velocity
                                    v36_28_ = v36_21_.PrimaryPart
                                    v36_27_ = v36_28_.RotVelocity
                                    v36_28_ = v36_25_
                                    if v36_28_ then
                                        v36_28_ = false
                                        local v36_31_ = v36_26_
                                        v36_29_ = v36_26_:Dot(v36_31_)
                                        v36_30_ = 0.100000
                                        if v36_29_ < v36_30_ then
                                            v36_31_ = v36_27_
                                            v36_29_ = v36_27_:Dot(v36_31_)
                                            v36_30_ = 1
                                            if v36_29_ >= v36_30_ then
                                                v36_28_ = false
                                            end
                                            v36_28_ = true
                                        end
                                    end
                                    v36_25_ = v36_28_
                                end
                                if v36_25_ then
                                    v36_26_ = v36_15_.IsPlaying
                                    if not v36_26_ then
                                        v36_26_ = v36_16_.IsPlaying
                                        if not v36_26_ then
                                            v36_26_ = v36_17_.IsPlaying
                                            if not v36_26_ then
                                                v36_26_ = v0_70_
                                                v36_27_ = a1
                                                v36_26_ = v36_26_(v36_27_)
                                                if v36_26_ then
                                                    v36_26_ = v36_18_.IsPlaying
                                                    if not v36_26_ then
                                                        v36_26_ = nil
                                                        if v36_2_ then
                                                            local new = CFrame.new
                                                            v36_30_ = v36_7_.Position
                                                            v36_29_ = v36_30_.X
                                                            local v36_32_ = v36_7_.Position
                                                            local v36_31_ = v36_32_.Y
                                                            v36_30_ = v36_31_ - v36_24_
                                                            v36_32_ = v36_7_.Position
                                                            v36_31_ = v36_32_.Z
                                                            local new_0 = Vector3.new
                                                            v36_28_ = new_0(v36_29_, v36_30_, v36_31_)
                                                            v36_27_ = new(v36_28_)
                                                            v36_28_ = v36_7_.Rotation
                                                            v36_26_ = v36_27_ * v36_28_
                                                        else
                                                            v36_27_ = v0_10_
                                                            v36_28_ = -v36_24_
                                                            v36_29_ = v36_23_
                                                            v36_27_ = v36_27_(v36_28_, v36_29_)
                                                            v36_26_ = v36_27_
                                                        end
                                                        v36_28_ = v36_22_.CFrame
                                                        v36_27_ = v36_28_ * v36_26_
                                                        nil.CFrame = v36_27_
                                                        v36_29_ = "Root"
                                                        v36_27_ = v36_22_:FindFirstChild(v36_29_)
                                                        v36_13_ = v36_27_
                                                        if v36_13_ then
                                                            local clock = os.clock
                                                            v36_28_ = clock()
                                                            v36_27_ = v36_28_ - v36_11_
                                                            v36_28_ = 0.250000
                                                            if v36_28_ < v36_27_ then
                                                                local clock = os.clock
                                                                v36_27_ = clock()
                                                                v36_11_ = v36_27_
                                                                v36_27_ = v36_21_.HumanoidRootPart
                                                                v36_28_ = workspace
                                                                v36_30_ = v36_27_.Position
                                                                local v36_31_ = v0_46_
                                                                local v36_32_ = v0_45_
                                                                v36_28_ = v36_28_:Raycast(v36_30_, v36_31_, v36_32_)
                                                                if v36_28_ then
                                                                    v36_29_ = v36_27_.CFrame
                                                                    v36_31_ = v36_28_.Normal
                                                                    v36_29_ = v36_29_:VectorToObjectSpace(v36_31_)
                                                                    local new = CFrame.new
                                                                    v36_31_ = 0
                                                                    local v36_35_ = "DefaultRootOffset"
                                                                    local v36_33_ = v36_21_:GetAttribute(v36_35_)
                                                                    local v36_36_ = v36_21_.Humanoid
                                                                    v36_35_ = v36_36_.BodyHeightScale
                                                                    local v36_34_ = v36_35_.Value
                                                                    v36_32_ = v36_33_ * v36_34_
                                                                    v36_33_ = 0
                                                                    v36_30_ = new(v36_31_, v36_32_, v36_33_)
                                                                    v36_31_ = v0_1_
                                                                    v36_33_ = v36_13_
                                                                    v36_34_ = v0_61_
                                                                    v36_35_ = {}
                                                                    local Angles = CFrame.Angles
                                                                    local v36_38_ = v36_29_.z
                                                                    local v36_39_ = 0
                                                                    local v36_42_ = v36_29_.X
                                                                    local v36_41_ = -v36_42_
                                                                    v36_42_ = -0.150000
                                                                    local v36_43_ = 0.150000
                                                                    local clamp = math.clamp
                                                                    local v36_40_ = clamp(v36_41_, v36_42_, v36_43_)
                                                                    local v36_37_ = Angles(v36_38_, v36_39_, v36_40_)
                                                                    v36_36_ = v36_30_ * v36_37_
                                                                    v36_35_.C0 = v36_36_
                                                                    v36_31_ = v36_31_:Create(v36_33_, v36_34_, v36_35_)
                                                                    v36_12_ = v36_31_
                                                                    v36_12_:Play()
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                v36_26_ = v36_18_.IsPlaying
                                if not v36_26_ then
                                    v36_26_ = nil
                                    if v36_2_ then
                                        local new = CFrame.new
                                        v36_30_ = v36_7_.Position
                                        v36_29_ = v36_30_.X
                                        local v36_32_ = v36_7_.Position
                                        local v36_31_ = v36_32_.Y
                                        v36_30_ = v36_31_ - v36_24_
                                        v36_32_ = v36_7_.Position
                                        v36_31_ = v36_32_.Z
                                        local new_0 = Vector3.new
                                        v36_28_ = new_0(v36_29_, v36_30_, v36_31_)
                                        v36_27_ = new(v36_28_)
                                        v36_28_ = v36_7_.Rotation
                                        v36_26_ = v36_27_ * v36_28_
                                    else
                                        v36_27_ = v0_10_
                                        v36_28_ = -v36_24_
                                        v36_29_ = v36_23_
                                        v36_27_ = v36_27_(v36_28_, v36_29_)
                                        v36_26_ = v36_27_
                                    end
                                    v36_28_ = v36_22_.CFrame
                                    v36_27_ = v36_28_ * v36_26_
                                    nil.CFrame = v36_27_
                                    v36_29_ = "Root"
                                    v36_27_ = v36_22_:FindFirstChild(v36_29_)
                                    v36_13_ = v36_27_
                                    if v36_13_ then
                                        local clock = os.clock
                                        v36_28_ = clock()
                                        v36_27_ = v36_28_ - v36_11_
                                        v36_28_ = 0.250000
                                        if v36_28_ < v36_27_ then
                                            local clock = os.clock
                                            v36_27_ = clock()
                                            v36_11_ = v36_27_
                                            v36_27_ = v36_21_.HumanoidRootPart
                                            v36_28_ = workspace
                                            v36_30_ = v36_27_.Position
                                            local v36_31_ = v0_46_
                                            local v36_32_ = v0_45_
                                            v36_28_ = v36_28_:Raycast(v36_30_, v36_31_, v36_32_)
                                            if v36_28_ then
                                                v36_29_ = v36_27_.CFrame
                                                v36_31_ = v36_28_.Normal
                                                v36_29_ = v36_29_:VectorToObjectSpace(v36_31_)
                                                local new = CFrame.new
                                                v36_31_ = 0
                                                local v36_35_ = "DefaultRootOffset"
                                                local v36_33_ = v36_21_:GetAttribute(v36_35_)
                                                local v36_36_ = v36_21_.Humanoid
                                                v36_35_ = v36_36_.BodyHeightScale
                                                local v36_34_ = v36_35_.Value
                                                v36_32_ = v36_33_ * v36_34_
                                                v36_33_ = 0
                                                v36_30_ = new(v36_31_, v36_32_, v36_33_)
                                                v36_31_ = v0_1_
                                                v36_33_ = v36_13_
                                                v36_34_ = v0_61_
                                                v36_35_ = {}
                                                local Angles = CFrame.Angles
                                                local v36_38_ = v36_29_.z
                                                local v36_39_ = 0
                                                local v36_42_ = v36_29_.X
                                                local v36_41_ = -v36_42_
                                                v36_42_ = -0.150000
                                                local v36_43_ = 0.150000
                                                local clamp = math.clamp
                                                local v36_40_ = clamp(v36_41_, v36_42_, v36_43_)
                                                local v36_37_ = Angles(v36_38_, v36_39_, v36_40_)
                                                v36_36_ = v36_30_ * v36_37_
                                                v36_35_.C0 = v36_36_
                                                v36_31_ = v36_31_:Create(v36_33_, v36_34_, v36_35_)
                                                v36_12_ = v36_31_
                                                v36_12_:Play()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    local v36_28_ = "Gait"
                    v36_26_ = a1:GetAttribute(v36_28_)
                    if v36_26_ ~= 0.000000 then
                        v36_25_ = false
                    end
                    v36_25_ = true
                    v36_26_ = v0_21_
                    if v36_21_ ~= v36_26_ then
                        v36_27_ = v36_21_.PrimaryPart
                        v36_26_ = v36_27_.Velocity
                        v36_28_ = v36_21_.PrimaryPart
                        v36_27_ = v36_28_.RotVelocity
                        v36_28_ = v36_25_
                        if v36_28_ then
                            v36_28_ = false
                            local v36_31_ = v36_26_
                            local v36_29_ = v36_26_:Dot(v36_31_)
                            local v36_30_ = 0.100000
                            if v36_29_ < v36_30_ then
                                v36_31_ = v36_27_
                                v36_29_ = v36_27_:Dot(v36_31_)
                                v36_30_ = 1
                                if v36_29_ >= v36_30_ then
                                    v36_28_ = false
                                end
                                v36_28_ = true
                            end
                        end
                        v36_25_ = v36_28_
                    end
                    if v36_25_ then
                        v36_26_ = v36_15_.IsPlaying
                        if not v36_26_ then
                            v36_26_ = v36_16_.IsPlaying
                            if not v36_26_ then
                                v36_26_ = v36_17_.IsPlaying
                                if not v36_26_ then
                                    v36_26_ = v0_70_
                                    v36_27_ = a1
                                    v36_26_ = v36_26_(v36_27_)
                                    if v36_26_ then
                                        v36_26_ = v36_18_.IsPlaying
                                        if not v36_26_ then
                                            v36_26_ = nil
                                            if v36_2_ then
                                                local new = CFrame.new
                                                local v36_30_ = v36_7_.Position
                                                local v36_29_ = v36_30_.X
                                                local v36_32_ = v36_7_.Position
                                                local v36_31_ = v36_32_.Y
                                                v36_30_ = v36_31_ - v36_24_
                                                v36_32_ = v36_7_.Position
                                                v36_31_ = v36_32_.Z
                                                local new_0 = Vector3.new
                                                v36_28_ = new_0(v36_29_, v36_30_, v36_31_)
                                                v36_27_ = new(v36_28_)
                                                v36_28_ = v36_7_.Rotation
                                                v36_26_ = v36_27_ * v36_28_
                                            else
                                                v36_27_ = v0_10_
                                                v36_28_ = -v36_24_
                                                local v36_29_ = v36_23_
                                                v36_27_ = v36_27_(v36_28_, v36_29_)
                                                v36_26_ = v36_27_
                                            end
                                            v36_28_ = v36_22_.CFrame
                                            v36_27_ = v36_28_ * v36_26_
                                            nil.CFrame = v36_27_
                                            local v36_29_ = "Root"
                                            v36_27_ = v36_22_:FindFirstChild(v36_29_)
                                            v36_13_ = v36_27_
                                            if v36_13_ then
                                                local clock = os.clock
                                                v36_28_ = clock()
                                                v36_27_ = v36_28_ - v36_11_
                                                v36_28_ = 0.250000
                                                if v36_28_ < v36_27_ then
                                                    local clock = os.clock
                                                    v36_27_ = clock()
                                                    v36_11_ = v36_27_
                                                    v36_27_ = v36_21_.HumanoidRootPart
                                                    v36_28_ = workspace
                                                    local v36_30_ = v36_27_.Position
                                                    local v36_31_ = v0_46_
                                                    local v36_32_ = v0_45_
                                                    v36_28_ = v36_28_:Raycast(v36_30_, v36_31_, v36_32_)
                                                    if v36_28_ then
                                                        v36_29_ = v36_27_.CFrame
                                                        v36_31_ = v36_28_.Normal
                                                        v36_29_ = v36_29_:VectorToObjectSpace(v36_31_)
                                                        local new = CFrame.new
                                                        v36_31_ = 0
                                                        local v36_35_ = "DefaultRootOffset"
                                                        local v36_33_ = v36_21_:GetAttribute(v36_35_)
                                                        local v36_36_ = v36_21_.Humanoid
                                                        v36_35_ = v36_36_.BodyHeightScale
                                                        local v36_34_ = v36_35_.Value
                                                        v36_32_ = v36_33_ * v36_34_
                                                        v36_33_ = 0
                                                        v36_30_ = new(v36_31_, v36_32_, v36_33_)
                                                        v36_31_ = v0_1_
                                                        v36_33_ = v36_13_
                                                        v36_34_ = v0_61_
                                                        v36_35_ = {}
                                                        local Angles = CFrame.Angles
                                                        local v36_38_ = v36_29_.z
                                                        local v36_39_ = 0
                                                        local v36_42_ = v36_29_.X
                                                        local v36_41_ = -v36_42_
                                                        v36_42_ = -0.150000
                                                        local v36_43_ = 0.150000
                                                        local clamp = math.clamp
                                                        local v36_40_ = clamp(v36_41_, v36_42_, v36_43_)
                                                        local v36_37_ = Angles(v36_38_, v36_39_, v36_40_)
                                                        v36_36_ = v36_30_ * v36_37_
                                                        v36_35_.C0 = v36_36_
                                                        v36_31_ = v36_31_:Create(v36_33_, v36_34_, v36_35_)
                                                        v36_12_ = v36_31_
                                                        v36_12_:Play()
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    v36_26_ = v36_18_.IsPlaying
                    if not v36_26_ then
                        v36_26_ = nil
                        if v36_2_ then
                            local new = CFrame.new
                            local v36_30_ = v36_7_.Position
                            local v36_29_ = v36_30_.X
                            local v36_32_ = v36_7_.Position
                            local v36_31_ = v36_32_.Y
                            v36_30_ = v36_31_ - v36_24_
                            v36_32_ = v36_7_.Position
                            v36_31_ = v36_32_.Z
                            local new_0 = Vector3.new
                            v36_28_ = new_0(v36_29_, v36_30_, v36_31_)
                            v36_27_ = new(v36_28_)
                            v36_28_ = v36_7_.Rotation
                            v36_26_ = v36_27_ * v36_28_
                        else
                            v36_27_ = v0_10_
                            v36_28_ = -v36_24_
                            local v36_29_ = v36_23_
                            v36_27_ = v36_27_(v36_28_, v36_29_)
                            v36_26_ = v36_27_
                        end
                        v36_28_ = v36_22_.CFrame
                        v36_27_ = v36_28_ * v36_26_
                        nil.CFrame = v36_27_
                        local v36_29_ = "Root"
                        v36_27_ = v36_22_:FindFirstChild(v36_29_)
                        v36_13_ = v36_27_
                        if v36_13_ then
                            local clock = os.clock
                            v36_28_ = clock()
                            v36_27_ = v36_28_ - v36_11_
                            v36_28_ = 0.250000
                            if v36_28_ < v36_27_ then
                                local clock = os.clock
                                v36_27_ = clock()
                                v36_11_ = v36_27_
                                v36_27_ = v36_21_.HumanoidRootPart
                                v36_28_ = workspace
                                local v36_30_ = v36_27_.Position
                                local v36_31_ = v0_46_
                                local v36_32_ = v0_45_
                                v36_28_ = v36_28_:Raycast(v36_30_, v36_31_, v36_32_)
                                if v36_28_ then
                                    v36_29_ = v36_27_.CFrame
                                    v36_31_ = v36_28_.Normal
                                    v36_29_ = v36_29_:VectorToObjectSpace(v36_31_)
                                    local new = CFrame.new
                                    v36_31_ = 0
                                    local v36_35_ = "DefaultRootOffset"
                                    local v36_33_ = v36_21_:GetAttribute(v36_35_)
                                    local v36_36_ = v36_21_.Humanoid
                                    v36_35_ = v36_36_.BodyHeightScale
                                    local v36_34_ = v36_35_.Value
                                    v36_32_ = v36_33_ * v36_34_
                                    v36_33_ = 0
                                    v36_30_ = new(v36_31_, v36_32_, v36_33_)
                                    v36_31_ = v0_1_
                                    v36_33_ = v36_13_
                                    v36_34_ = v0_61_
                                    v36_35_ = {}
                                    local Angles = CFrame.Angles
                                    local v36_38_ = v36_29_.z
                                    local v36_39_ = 0
                                    local v36_42_ = v36_29_.X
                                    local v36_41_ = -v36_42_
                                    v36_42_ = -0.150000
                                    local v36_43_ = 0.150000
                                    local clamp = math.clamp
                                    local v36_40_ = clamp(v36_41_, v36_42_, v36_43_)
                                    local v36_37_ = Angles(v36_38_, v36_39_, v36_40_)
                                    v36_36_ = v36_30_ * v36_37_
                                    v36_35_.C0 = v36_36_
                                    v36_31_ = v36_31_:Create(v36_33_, v36_34_, v36_35_)
                                    v36_12_ = v36_31_
                                    v36_12_:Play()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    v36_20_ = v36_19_
    v36_20_()
    v36_20_ = v0_34_
    local v36_21_ = nil
    v36_20_[a1] = v36_21_
end
local v0_79_ = pairs
local v0_79_, v0_80_, v0_81_ = v0_79_(v0_20_:GetChildren())
for v0_82_, v0_83_ in v0_79_, v0_80_, v0_81_ do
    local defer = task.defer
    local v0_85_ = v0_78_
    local v0_86_ = v0_83_
    local v0_87_ = true
end
v0_79_ = v0_20_.ChildAdded
v0_81_ = v0_78_
v0_79_:Connect(v0_81_)
v0_79_ = function(a1, a2)
    if a2 then
        local v48_2_ = 0
    else
        local v48_2_ = 0.250000
    end
    local v48_3_ = a1.PrimaryPart
    local v48_4_ = v0_51_
    local v48_5_ = nil
    local v48_6_ = nil
    local v48_9_ = v48_3_[nil]
    v48_9_.Volume = nil
end
v0_80_ = function(a1, a2, a3, a4)
    local v49_4_ = v0_16_
    local v49_5_ = a1
    v49_4_ = v49_4_(v49_5_)
    if not v49_4_ then
        return
    end
    local v49_6_ = v0_34_
    v49_5_ = v49_6_[v49_4_]
    if not v49_5_ then
        return
    end
    if not a4 then
        v49_3_ = 0.100000
    end
    v49_6_ = v49_5_[a2]
    if a3 then
        local v49_9_ = a4
        local v49_12_ = "Weight"
        v49_6_:Play(v49_6_:GetAttribute(v49_12_))
        return
    end
    if a2 ~= "LegYieldLeft" then
        if a2 == "LegYieldRight" then
            local wait = task.wait
            local v49_8_ = 0.200000
            wait(v49_8_)
        end
    end
    local wait = task.wait
    local v49_8_ = 0.200000
    wait(v49_8_)
    local v49_9_ = a4
    v49_6_:Stop(v49_9_)
end
local v0_83_ = v0_24_.Reliable
local v0_82_ = v0_83_.HorseTurn
v0_81_ = v0_82_.OnClientEvent
v0_83_ = v0_80_
v0_81_:Connect(v0_83_)
v0_83_ = v0_24_.Unreliable
v0_82_ = v0_83_.HorsePiaffe
v0_81_ = v0_82_.OnClientEvent
v0_83_ = v0_80_
v0_81_:Connect(v0_83_)
v0_83_ = v0_24_.Reliable
v0_82_ = v0_83_.HorseLegYield
v0_81_ = v0_82_.OnClientEvent
v0_83_ = v0_80_
v0_81_:Connect(v0_83_)
v0_83_ = v0_24_.Unreliable
v0_82_ = v0_83_.HorseRear
v0_81_ = v0_82_.OnClientEvent
v0_83_ = function(a1)
    local v50_1_ = v0_16_
    local v50_2_ = a1
    v50_1_ = v50_1_(v50_2_)
    if not v50_1_ then
        return
    end
    local v50_3_ = v0_34_
    v50_2_ = v50_3_[v50_1_]
    if not v50_2_ then
        return
    end
    local v50_4_ = v50_1_.CoRider
    v50_3_ = v50_4_.Value
    v50_4_ = v0_21_
    if v50_3_ == v50_4_ then
        local v50_5_ = "NewMesh"
        v50_3_ = v50_1_:GetAttribute(v50_5_)
        if v50_3_ then
            v50_3_ = v0_56_
            v50_3_:Play()
        else
            v50_3_ = v0_55_
            v50_3_:Play()
        end
    end
    v50_3_ = v0_17_
    v50_4_ = v50_1_
    v50_3_(v50_4_)
    local v50_5_ = "HipHeight"
    v50_3_ = a1:GetAttribute(v50_5_)
    v50_4_ = a1.Humanoid
    local v50_7_ = "NewMesh"
    v50_5_ = v50_1_:GetAttribute(v50_7_)
    if v50_5_ then
        v50_7_ = "RideHipHeight"
        v50_5_ = v50_1_:GetAttribute(v50_7_)
        v50_4_.HipHeight = v50_5_
    else
        local v50_6_ = v0_7_
        v50_7_ = v50_3_
        local v50_10_ = "BodyHeight"
        v50_6_ = v50_6_(v50_1_:GetAttribute(v50_10_))
        v50_5_ = v50_3_ + v50_6_
        v50_4_.HipHeight = v50_5_
    end
    v50_5_ = v50_2_.Rear
    v50_5_:Play()
    local v50_6_ = v50_5_.Stopped
    v50_6_:Wait()
    v50_4_.HipHeight = v50_3_
end
v0_81_:Connect(v0_83_)
v0_81_ = function(a1)
    local v51_2_ = v0_34_
    local v51_1_ = v51_2_[a1]
    if not v51_1_ then
        return
    end
    local wait = task.wait
    local v51_3_ = 0.125000
    wait(v51_3_)
    v51_2_ = v51_1_.JumpLand
    v51_2_:Stop()
    v51_2_ = v51_1_.JumpStart
    local v51_5_ = nil
    local v51_6_ = nil
    local v51_7_ = 2
    v51_2_:Play(v51_5_, v51_6_, v51_7_)
    v51_3_ = a1.PrimaryPart
    local v51_4_ = v0_51_
    v51_5_ = nil
    v51_6_ = nil
    local v51_9_ = v51_3_[nil]
    local v51_10_ = 0
    v51_9_.Volume = v51_10_
    v51_3_ = false
    v51_4_ = v51_2_.Stopped
    v51_6_ = function()
        local v52_0_ = v51_3_
        if v52_0_ then
            return
        end
        local v52_1_ = v51_1_
        v52_0_ = v52_1_.JumpFall
        v52_0_:Play()
    end
    v51_4_:Once(v51_6_)
    v51_5_ = a1.Rider
    v51_4_ = v51_5_.Value
    v51_5_ = v51_4_.Humanoid
    v51_6_ = nil
    v51_7_ = v51_5_.StateChanged
    v51_9_ = function(a1, a2)
        local v53_3_ = a1
        local v53_2_ = v53_3_.Parent
        if not v53_2_ then
            v53_2_ = v51_4_
            v53_3_ = v0_21_
            if v53_2_ == v53_3_ then
                v53_2_ = false
                v0_38_ = v53_3_
            end
            return
        end
        local Landed = Enum.HumanoidStateType.Landed
        if a2 ~= Landed then
            local Running = Enum.HumanoidStateType.Running
            if a2 ~= Running then
                return
            end
        end
        v53_2_ = v51_6_
        v53_2_:Disconnect()
        v53_2_ = nil
        v51_6_ = nil
        v53_2_ = true
        v51_3_ = nil
        v53_3_ = v51_1_
        v53_2_ = v53_3_.JumpLand
        local v53_4_ = v51_1_
        v53_3_ = v53_4_.JumpFall
        v53_3_:Stop()
        local v53_5_ = nil
        local v53_6_ = nil
        local v53_7_ = 2
        v53_2_:Play(v53_5_, v53_6_, v53_7_)
        v53_3_ = a1
        v53_5_ = "NewMesh"
        v53_3_ = v53_3_:GetAttribute(v53_5_)
        if not v53_3_ then
            v53_5_ = 0
            v53_7_ = v53_2_.Length
            local v53_8_ = v53_2_.TimePosition
            v53_6_ = v53_7_ - v53_8_
            v53_2_:AdjustWeight(v53_5_, v53_6_)
        end
        v53_3_ = v51_4_
        v53_4_ = v0_21_
        if v53_3_ == v53_4_ then
            v53_3_ = false
            v0_38_ = v53_3_
        end
        v53_3_ = a1
        v53_4_ = v53_3_.PrimaryPart
        v53_5_ = v0_51_
        v53_6_ = nil
        v53_7_ = nil
        local v53_10_ = v53_4_[nil]
        local v53_11_ = 0.250000
        v53_10_.Volume = v53_11_
    end
    v51_7_ = v51_7_:Connect(v51_9_)
    v51_6_ = v51_7_
end
local v0_84_ = v0_24_.Unreliable
v0_83_ = v0_84_.HorseJump
v0_82_ = v0_83_.OnClientEvent
v0_84_ = function(a1)
    local v54_1_ = v0_16_
    local v54_2_ = a1
    v54_1_ = v54_1_(v54_2_)
    if not v54_1_ then
        return
    end
    local v54_3_ = v54_1_.CoRider
    v54_2_ = v54_3_.Value
    v54_3_ = v0_21_
    if v54_2_ == v54_3_ then
        v54_2_ = v0_57_
        v54_2_:Play()
    end
    v54_2_ = v0_81_
    v54_3_ = v54_1_
    v54_2_(v54_3_)
end
v0_82_:Connect(v0_84_)
v0_82_ = function()
    local v55_0_ = v0_40_
    if v55_0_ then
        return
    end
    v55_0_ = v0_16_
    local v55_1_ = v0_21_
    v55_0_ = v55_0_(v55_1_)
    if not v55_0_ then
        return
    end
    local v55_3_ = "Gait"
    v55_1_ = v55_0_:GetAttribute(v55_3_)
    v55_3_ = v0_34_
    local v55_2_ = v55_3_[v55_0_]
    v55_3_ = 0
    if v55_3_ < v55_1_ then
        v55_3_ = v0_38_
        if not v55_3_ then
            v55_3_ = true
            v0_38_ = nil
            v55_3_ = v0_22_
            local v55_6_ = "Height"
            local v55_4_ = v55_0_:GetAttribute(v55_6_)
            v55_3_.JumpHeight = v55_4_
            local v55_5_ = v0_24_
            v55_4_ = v55_5_.Unreliable
            v55_3_ = v55_4_.HorseJump
            v55_3_:FireServer()
            v55_3_ = v0_57_
            v55_3_:Play()
            v55_3_ = v0_81_
            v55_4_ = v55_0_
            v55_3_(v55_4_)
            local wait = task.wait
            v55_4_ = 0.250000
            wait(v55_4_)
            v55_3_ = v0_22_
            v55_4_ = true
            v55_3_.Jump = v55_4_
            return
        end
    end
    if v55_1_ == 0.000000 then
        v55_3_ = v0_39_
        if not v55_3_ then
            v55_3_ = v0_41_
            if not v55_3_ then
                local v55_5_ = "Resting"
                v55_3_ = v55_0_:GetAttribute(v55_5_)
                if not v55_3_ then
                    v55_3_ = v0_69_
                    local v55_4_ = v55_0_
                    v55_3_ = v55_3_(v55_4_)
                    if v55_3_ then
                        return
                    end
                    v55_4_ = v0_14_
                    v55_3_ = v55_4_.Get
                    v55_3_ = v55_3_()
                    v55_5_ = v0_49_
                    v55_4_ = v55_5_.Rearing
                    local v55_9_ = v55_3_.horses
                    local v55_10_ = v55_3_.riding
                    local v55_8_ = v55_9_[v55_10_]
                    local v55_7_ = v55_8_.stats
                    v55_8_ = v55_4_.stat
                    local v55_6_ = v55_7_[v55_8_]
                    v55_5_ = v55_6_.level
                    v55_6_ = v55_4_.level
                    if v55_5_ < v55_6_ then
                        return
                    end
                    v55_6_ = v0_8_
                    v55_5_ = v55_6_.Trigger
                    v55_7_ = v0_53_
                    v55_5_:Fire(v55_7_)
                    v55_5_ = true
                    v0_39_ = v55_9_
                    v55_5_ = v55_2_.Rear
                    v55_5_:Play()
                    v55_7_ = "NewMesh"
                    v55_5_ = v55_0_:GetAttribute(v55_7_)
                    if v55_5_ then
                        v55_5_ = v0_54_
                        v55_5_:Play()
                    else
                        v55_5_ = v0_53_
                        v55_5_:Play()
                    end
                    v55_5_ = v0_17_
                    v55_6_ = v55_0_
                    v55_5_(v55_6_)
                    v55_7_ = v0_24_
                    v55_6_ = v55_7_.Unreliable
                    v55_5_ = v55_6_.HorseRear
                    v55_5_:FireServer()
                    local wait = task.wait
                    v55_6_ = 2.400000
                    wait(v55_6_)
                    v55_5_ = false
                    v0_39_ = v55_9_
                end
            end
        end
    end
end
local defer = task.defer
v0_84_ = function()
    local v56_1_ = v0_19_
    local v56_0_ = v56_1_.PlayerGui
    local v56_2_ = "TouchGui"
    local v56_3_ = 5
    v56_0_ = v56_0_:WaitForChild(v56_2_, v56_3_)
    if not v56_0_ then
        return
    end
    v56_1_ = v56_0_.TouchControlFrame
    v56_3_ = "JumpButton"
    local v56_4_ = 5
    v56_1_ = v56_1_:WaitForChild(v56_3_, v56_4_)
    if not v56_1_ then
        return
    end
    v56_2_ = v56_1_.Activated
    v56_4_ = v0_82_
    v56_2_:Connect(v56_4_)
end
defer(v0_84_)
local v0_85_ = v0_24_.Reliable
v0_84_ = v0_85_.HorseEmote
v0_83_ = v0_84_.OnClientEvent
v0_85_ = function(a1, a2, a3)
    local v57_4_ = v0_34_
    local v57_3_ = v57_4_[a1]
    if not v57_3_ then
        return
    end
    v57_4_ = true
    if a2 ~= "Sleep" then
        if a2 ~= "Lay Down" then
            v57_4_ = false
        end
        v57_4_ = true
    end
    local v57_5_ = v57_3_[a2]
    if not v57_5_ then
        local v57_6_ = v0_29_
        v57_5_ = v57_6_[a2]
        local v57_7_ = a1.AnimationController
        v57_6_ = v57_7_.Animator
        if v57_4_ then
            local v57_12_ = "NewMesh"
            local v57_10_ = a1:GetAttribute(v57_12_)
            if v57_10_ then
                v57_10_ = v0_42_
                local v57_9_ = v57_10_[a2]
            else
                local v57_9_ = v57_5_["3"]
            end
            v57_7_ = v57_6_:LoadAnimation(nil)
            v57_3_[a2] = v57_7_
        else
            local v57_12_ = "NewMesh"
            local v57_10_ = a1:GetAttribute(v57_12_)
            if v57_10_ then
                v57_10_ = v0_42_
                local v57_9_ = v57_10_[a2]
            else
                local v57_9_ = v57_5_
            end
            v57_7_ = v57_6_:LoadAnimation(nil)
            v57_3_[a2] = v57_7_
        end
    end
    if v57_4_ then
        local v57_6_ = v0_52_
        local v57_9_ = "Breed"
        local v57_7_ = a1:GetAttribute(v57_9_)
        v57_5_ = v57_6_[v57_7_]
        v57_7_ = 0
        if v57_5_ then
            local v57_8_ = v57_5_.restAnimOffset
            if not v57_8_ then
                v57_8_ = 0
            end
        end
        local v57_8_ = 0
        v57_9_ = 0
        local new = Vector3.new
        v57_6_ = new(v57_7_, v57_8_, v57_9_)
        if a3 then
            local v57_10_ = 1
        else
            local v57_10_ = -1
        end
        v57_9_ = v57_6_ * nil
        a1:TranslateBy(v57_9_)
    end
    if a3 then
        if a2 ~= "Scratch" then
            if a2 == "Hug" then
                local v57_6_ = v0_8_
                v57_5_ = v57_6_.PlayHorsePetEffects
                local v57_7_ = a1
                local v57_8_ = a2
                v57_5_:Fire(v57_7_, v57_8_)
                return
            end
        end
        local v57_6_ = v0_8_
        v57_5_ = v57_6_.PlayHorsePetEffects
        local v57_7_ = a1
        local v57_8_ = a2
        v57_5_:Fire(v57_7_, v57_8_)
        return
    end
    v57_5_ = v57_3_[a2]
    v57_5_:Stop()
end
v0_83_:Connect(v0_85_)
v0_83_ = function(a1, a2)
    local v58_3_ = v0_39_
    if v58_3_ then
        local v58_2_ = true
    else
        v58_3_ = v0_38_
        if v58_3_ then
            local v58_2_ = true
        else
            v58_3_ = v0_41_
            if v58_3_ then
                local v58_2_ = true
            else
                local v58_4_ = v0_23_
                v58_3_ = v58_4_.Anchored
                if v58_3_ then
                    local v58_2_ = true
                else
                    v58_3_ = v0_37_
                    if v58_3_ then
                        local v58_2_ = true
                    else
                        local v58_2_ = false
                    end
                end
            end
        end
    end
    if nil then
        return
    end
    local v58_2_ = v0_16_
    v58_3_ = v0_21_
    v58_2_ = v58_2_(v58_3_)
    if not v58_2_ then
        return
    end
    local v58_5_ = "Rate"
    v58_3_ = v58_2_:GetAttribute(v58_5_)
    local clock = os.clock
    v58_5_ = clock()
    local v58_6_ = v0_36_
    local v58_4_ = v58_5_ - v58_6_
    if v58_4_ < v58_3_ then
        return
    end
    v58_4_ = UpdateGait
    v58_5_ = v58_2_
    local v58_9_ = "Gait"
    local v58_7_ = v58_2_:GetAttribute(v58_9_)
    v58_6_ = v58_7_ + a1
    v58_4_(v58_5_, v58_6_)
    if a2 then
        v58_5_ = v0_32_
        v58_4_ = v58_5_.Plus
        v58_5_ = false
        v58_4_.Visible = v58_5_
        v58_5_ = v0_32_
        v58_4_ = v58_5_.Minus
        v58_5_ = false
        v58_4_.Visible = v58_5_
        local wait = task.wait
        v58_5_ = v58_3_
        wait(v58_5_)
        v58_5_ = v0_32_
        v58_4_ = v58_5_.Plus
        v58_5_ = true
        v58_4_.Visible = v58_5_
        v58_5_ = v0_32_
        v58_4_ = v58_5_.Minus
        v58_5_ = true
        v58_4_.Visible = v58_5_
    end
end
v0_84_ = v0_0_.InputBegan
local v0_86_ = function(a1, a2)
    local v59_3_ = v0_33_
    local v59_2_ = v59_3_.Visible
    if not v59_2_ then
        return
    end
    v59_2_ = a1.KeyCode
    if a2 then
        local ButtonA = Enum.KeyCode.ButtonA
        if v59_2_ ~= ButtonA then
            return
        end
    end
    local ButtonR1 = Enum.KeyCode.ButtonR1
    if v59_2_ ~= ButtonR1 then
        local W = Enum.KeyCode.W
        if v59_2_ == W then
            v59_3_ = v0_83_
            local v59_4_ = 1
            v59_3_(v59_4_)
            return
        end
    end
    v59_3_ = v0_83_
    local v59_4_ = 1
    v59_3_(v59_4_)
    return
end
v0_84_:Connect(v0_86_)
v0_84_ = v0_0_.InputEnded
v0_86_ = function(a1, a2)
    if a2 then
        return
    end
    local v60_2_ = a1.KeyCode
    local ButtonX = Enum.KeyCode.ButtonX
    if v60_2_ ~= ButtonX then
        local X = Enum.KeyCode.X
        if v60_2_ == X then
            local v60_3_ = v0_73_
            local v60_4_ = false
            v60_3_(v60_4_)
        end
    end
    local v60_3_ = v0_73_
    local v60_4_ = false
    v60_3_(v60_4_)
end
v0_84_:Connect(v0_86_)
v0_85_ = v0_32_.Plus
v0_84_ = v0_85_.Activated
v0_86_ = function()
    local v61_0_ = v0_83_
    local v61_1_ = 1
    local v61_2_ = true
    v61_0_(v61_1_, v61_2_)
end
v0_84_:Connect(v0_86_)
v0_85_ = v0_32_.Minus
v0_84_ = v0_85_.Activated
v0_86_ = function()
    local v62_0_ = v0_83_
    local v62_1_ = -1
    local v62_2_ = true
    v62_0_(v62_1_, v62_2_)
end
v0_84_:Connect(v0_86_)
v0_86_ = "Anchored"
v0_84_ = v0_23_:GetPropertyChangedSignal(v0_86_)
v0_86_ = function()
    local v63_1_ = v0_23_
    local v63_0_ = v63_1_.Anchored
    if not v63_0_ then
        return
    end
    v63_0_ = v0_16_
    v63_1_ = v0_21_
    v63_0_ = v63_0_(v63_1_)
    if not v63_0_ then
        return
    end
    v63_1_ = v0_23_
    local zero = Vector3.zero
    v63_1_.Velocity = zero
    v63_1_ = UpdateGait
    local v63_2_ = v63_0_
    local v63_3_ = 0
    v63_1_(v63_2_, v63_3_)
    v63_1_ = v0_53_
    v63_1_:Stop()
    v63_2_ = v0_34_
    v63_1_ = v63_2_[v63_0_]
    if v63_1_ then
        v63_2_ = v63_1_.Rear
        v63_2_:Stop()
    end
end
v0_84_:Connect(v0_86_)
v0_84_ = function(a1)
    local v64_2_ = a1.Hitbox
    local v64_1_ = v64_2_.Touched
    local v64_3_ = function(a1)
        local v65_1_ = v0_23_
        if a1 ~= v65_1_ then
            return
        end
        local v65_2_ = v0_8_
        v65_1_ = v65_2_.Flash
        v65_1_:Fire()
        v65_1_ = v0_16_
        v65_2_ = v0_21_
        v65_1_ = v65_1_(v65_2_)
        if not v65_1_ then
            return
        end
        local v65_4_ = "Gait"
        v65_2_ = v65_1_:GetAttribute(v65_4_)
        local v65_3_ = 1
        if v65_3_ < v65_2_ then
            v65_2_ = UpdateGait
            v65_3_ = v65_1_
            v65_4_ = 1
            v65_2_(v65_3_, v65_4_)
        end
    end
    v64_1_:Connect(v64_3_)
end
v0_85_ = pairs
local v0_85_, v0_86_, v0_87_ = v0_85_(v0_31_:GetChildren())
for v0_88_, v0_89_ in v0_85_, v0_86_, v0_87_ do
    local v0_91_ = v0_89_.Hitbox
    local v0_90_ = v0_91_.Touched
    local v0_92_ = function(a1)
        local v66_1_ = v0_23_
        if a1 ~= v66_1_ then
            return
        end
        local v66_2_ = v0_8_
        v66_1_ = v66_2_.Flash
        v66_1_:Fire()
        v66_1_ = v0_16_
        v66_2_ = v0_21_
        v66_1_ = v66_1_(v66_2_)
        if not v66_1_ then
            return
        end
        local v66_4_ = "Gait"
        v66_2_ = v66_1_:GetAttribute(v66_4_)
        local v66_3_ = 1
        if v66_3_ < v66_2_ then
            v66_2_ = UpdateGait
            v66_3_ = v66_1_
            v66_4_ = 1
            v66_2_(v66_3_, v66_4_)
        end
    end
end
v0_85_ = v0_31_.ChildAdded
v0_87_ = v0_84_
v0_85_:Connect(v0_87_)
v0_85_ = function()
    local v67_2_ = v0_21_
    local v67_1_ = v67_2_.CoRiding
    local v67_0_ = v67_1_.Value
    if v67_0_ then
        v67_2_ = v0_15_
        v67_1_ = v67_2_.CoDismount
        v67_2_ = v67_0_.PrimaryPart
        local v67_6_ = "Gait"
        local v67_4_ = v67_0_:GetAttribute(v67_6_)
        if v67_4_ == 0.000000 then
            local v67_3_ = false
        end
        local v67_3_ = true
        v67_1_(v67_2_, v67_3_)
        return
    end
    v67_1_ = v0_16_
    v67_2_ = v0_21_
    v67_1_ = v67_1_(v67_2_)
    if not v67_1_ then
        return
    end
    local v67_4_ = "Gait"
    v67_2_ = v67_1_:GetAttribute(v67_4_)
    if v67_2_ == 0.000000 then
        v67_4_ = v0_33_
        local v67_3_ = v67_4_.Thumbnail
        v67_2_ = v67_3_.ImageTransparency
        if v67_2_ ~= 0.000000 then
            return
        end
    end
    return
end
v0_86_ = v0_33_.Activated
local v0_88_ = v0_85_
v0_86_:Connect(v0_88_)
v0_86_ = v0_0_.InputBegan
v0_88_ = function(a1, a2)
    local v68_3_ = v0_33_
    local v68_2_ = v68_3_.Visible
    if not v68_2_ then
        return
    end
    v68_2_ = a1.KeyCode
    local ButtonY = Enum.KeyCode.ButtonY
    if v68_2_ ~= ButtonY then
        local Q = Enum.KeyCode.Q
        if v68_2_ == Q then
            if not a2 then
                v68_3_ = v0_85_
                v68_3_()
            end
        end
    end
    v68_3_ = v0_85_
    v68_3_()
end
v0_86_:Connect(v0_88_)
v0_86_ = v0_8_.PlayHorsePetEffects
v0_88_ = function(a1, a2)
    local v69_3_ = v0_34_
    local v69_2_ = v69_3_[a1]
    if not v69_2_ then
        return
    end
    local v69_4_ = v0_8_
    v69_3_ = v69_4_.StopHorseIdleAnimations
    local v69_5_ = a1
    v69_3_:Fire(v69_5_)
    local wait = task.wait
    wait()
    v69_3_ = v69_2_[a2]
    v69_3_:Play()
    if a2 == "Scratch" then
        local v69_6_ = "ParticleStart"
        v69_4_ = v69_3_:GetMarkerReachedSignal(v69_6_)
        v69_4_:Wait()
    end
    v69_4_ = v0_12_
    v69_5_ = "Hearts"
    local v69_7_ = workspace
    local v69_6_ = v69_7_.Terrain
    local v69_9_ = a1.Head
    local v69_8_ = v69_9_.Position
    v69_9_ = Vector3.new(0.000000, 0.300000, 0.000000)
    v69_7_ = v69_8_ + v69_9_
    v69_4_(v69_5_, v69_6_, v69_7_)
    v69_6_ = "BlinkStart"
    v69_4_ = v69_3_:GetMarkerReachedSignal(v69_6_)
    v69_4_:Wait()
    v69_6_ = "EyesClosed"
    v69_7_ = true
    a1:SetAttribute(v69_6_, v69_7_)
    v69_6_ = "BlinkStop"
    v69_4_ = v69_3_:GetMarkerReachedSignal(v69_6_)
    v69_4_:Wait()
    v69_6_ = "EyesClosed"
    v69_7_ = nil
    a1:SetAttribute(v69_6_, v69_7_)
end
v0_86_:Connect(v0_88_)
v0_88_ = v0_24_.Reliable
v0_87_ = v0_88_.CoRideRequest
v0_86_ = v0_87_.OnClientEvent
v0_88_ = function(a1)
    local v70_1_ = false
    local v70_3_ = v0_8_
    local v70_2_ = v70_3_.DisplayDialog
    local v70_4_ = "Info"
    local v70_6_ = a1.Name
    local v70_7_ = " invited you to coride"
    local v70_5_ = v70_6_
    v70_6_ = function()
        local v71_2_ = v0_24_
        local v71_1_ = v71_2_.Reliable
        local v71_0_ = v71_1_.CoRideAccept
        v71_2_ = a1
        v71_0_:FireServer(v71_2_)
        v71_0_ = true
        v70_1_ = v71_2_
    end
    v70_7_ = nil
    local v70_8_ = function()
        local v72_2_ = v0_24_
        local v72_1_ = v72_2_.Reliable
        local v72_0_ = v72_1_.CoRideDecline
        v72_2_ = a1
        v72_0_:FireServer(v72_2_)
        v72_0_ = true
        v70_1_ = v72_2_
    end
    v70_2_:Fire(v70_4_, v70_5_, v70_6_, v70_7_, v70_8_)
    local wait = task.wait
    v70_3_ = 15
    wait(v70_3_)
    if not v70_1_ then
        v70_5_ = v0_19_
        v70_4_ = v70_5_.PlayerGui
        v70_3_ = v70_4_.Menus
        v70_2_ = v70_3_.Dialog
        v70_3_ = false
        v70_2_.Visible = v70_3_
        v70_4_ = v0_24_
        v70_3_ = v70_4_.Reliable
        v70_2_ = v70_3_.CoRideDecline
        v70_4_ = a1
        v70_2_:FireServer(v70_4_)
    end
end
v0_86_:Connect(v0_88_)
