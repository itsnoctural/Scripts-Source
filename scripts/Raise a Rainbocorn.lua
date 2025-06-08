local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

getgenv().Settings = {
  Default = false,
}

local function GetEquipedPets()
  local Pets = {}

  for _, v in ipairs(Workspace[LocalPlayer.Name .. ":Debris"]:GetChildren()) do
    if v:GetAttribute("InteractionType") then
      table.insert(Pets, v.Name)
    end
  end

  return Pets
end

local function GetNearestField()
  local Field = nil
  local Distance = 1000

  for _, v in ipairs(Workspace.Maps.Fields:GetChildren()) do
    for _, f in ipairs(v:GetChildren()) do
      local DistTo = LocalPlayer:DistanceFromCharacter(f:GetPivot().Position)

      if DistTo < Distance then
          Distance = DistTo
          Field = f
      end
    end
  end

  return Field
end

-- Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wally2", true))()
local Window = Library:CreateWindow(" | EsohaSL")

Window:Section("esohasl.net")

Window:Toggle("Auto Farm", {}, function(state)
  task.spawn(function()
    Settings.Default = state
    while true do
      if not Settings.Default then return end

      local Pets = GetEquipedPets()
      local Field = GetNearestField()

      print(Pets, Field)

      for _, v in ipairs(Field.Spawners:GetChildren()) do
        while Settings.Default and #v:GetChildren() > 0 and task.wait(.25) do
          for _, pet in ipairs(Pets) do
            ReplicatedStorage.dataRemoteEvent:FireServer({{ utf8.char(1), { pet, v:GetAttribute("UID")} }, utf8.char(26)}); task.wait()
          end
        end
      end
      
      task.wait(1)
    end
  end)
end)

-- Window:Button("YouTube: EsohaSL", function()
--     task.spawn(function()
--         if setclipboard then
--             setclipboard("https://youtube.com/@esohasl")
--         end
--     end)
-- end)

-- LocalPlayer.Idled:Connect(function()
--     VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
--     task.wait()
--     VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame);
-- end)

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-10-05 14:00:38
-- Luau version 6, Types version 3
-- Time taken: 0.001829 seconds

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local RunService_upvr = game:GetService("RunService")
local module_upvr_3 = require(ReplicatedFirst:WaitForChild("BridgeNet"))
local module_upvr = {}
module_upvr.__index = module_upvr
local module_upvr_2 = require(ReplicatedFirst:WaitForChild("XSignal"))
function module_upvr.new(arg1) -- Line 37
	--[[ Upvalues[4]:
		[1]: module_upvr_3 (readonly)
		[2]: module_upvr_2 (readonly)
		[3]: module_upvr (readonly)
		[4]: RunService_upvr (readonly)
	]]
	local any_ReferenceBridge_result1 = module_upvr_3.ReferenceBridge(arg1)
	local tbl = {}
	tbl._ID = arg1
	tbl._Bridge = any_ReferenceBridge_result1
	tbl.OnServerEvent = module_upvr_2.new()
	tbl.OnClientEvent = module_upvr_2.new()
	local setmetatable_result1_upvr = setmetatable(tbl, module_upvr)
	if RunService_upvr:IsServer() then
		any_ReferenceBridge_result1:Connect(function(arg1_2, arg2) -- Line 49
			--[[ Upvalues[1]:
				[1]: setmetatable_result1_upvr (readonly)
			]]
			setmetatable_result1_upvr.OnServerEvent:Fire(arg1_2, arg2)
		end)
		return setmetatable_result1_upvr
	end
	any_ReferenceBridge_result1:Connect(function(arg1_3) -- Line 53
		--[[ Upvalues[1]:
			[1]: setmetatable_result1_upvr (readonly)
		]]
		setmetatable_result1_upvr.OnClientEvent:Fire(arg1_3)
	end)
	return setmetatable_result1_upvr
end
function module_upvr.GetID(arg1) -- Line 64
	return arg1._ID
end
function module_upvr.InvokeServer(arg1, arg2) -- Line 73
	arg1:_AssertClient()
	return arg1._Bridge:InvokeServerAsync(arg2)
end
function module_upvr.FireServer(arg1, arg2) -- Line 85
	arg1:_AssertClient()
	arg1._Bridge:Fire(arg2)
end
function module_upvr.SetOnServerInvoke(arg1, arg2) -- Line 97
	arg1:_AssertServer()
	arg1._Bridge.OnServerInvoke = arg2
end
function module_upvr.FireClient(arg1, arg2, arg3) -- Line 109
	arg1:_AssertServer()
	arg1._Bridge:Fire(arg2, arg3)
end
function module_upvr.FireAllClients(arg1, arg2) -- Line 121
	--[[ Upvalues[1]:
		[1]: module_upvr_3 (readonly)
	]]
	arg1:_AssertServer()
	arg1._Bridge:Fire(module_upvr_3.AllPlayers(), arg2)
end
function module_upvr.FireClients(arg1, arg2, arg3) -- Line 133
	--[[ Upvalues[1]:
		[1]: module_upvr_3 (readonly)
	]]
	arg1:_AssertServer()
	arg1._Bridge:Fire(module_upvr_3.Players(arg2), arg3)
end
function module_upvr.FireClientsExcept(arg1, arg2, arg3) -- Line 145
	--[[ Upvalues[1]:
		[1]: module_upvr_3 (readonly)
	]]
	arg1:_AssertServer()
	arg1._Bridge:Fire(module_upvr_3.PlayersExcept(arg2), arg3)
end
function module_upvr._AssertClient(arg1) -- Line 152
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	if not RunService_upvr:IsClient() then
		error("RemoteWrapper - This method can only be called on the client.")
	end
end
function module_upvr._AssertServer(arg1) -- Line 158
	--[[ Upvalues[1]:
		[1]: RunService_upvr (readonly)
	]]
	if not RunService_upvr:IsServer() then
		error("RemoteWrapper - This method can only be called on the server.")
	end
end
function module_upvr.__tostring(arg1) -- Line 164
	return `RemoteWrapper({arg1:GetID()})`
end
return module_upvr


-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-10-05 14:01:23
-- Luau version 6, Types version 3
-- Time taken: 0.040597 seconds

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local module_7_upvr = require(ReplicatedFirst:WaitForChild("Cleaner"))
local module_9_upvr = require(ReplicatedFirst:WaitForChild("Rosyn"))
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_11_upvr = require(ReplicatedStorage_upvr:WaitForChild("Client"):WaitForChild("Components"):WaitForChild("RewardsManager"))
local any_new_result1_upvr_4 = require(ReplicatedStorage_upvr:WaitForChild("Remotes"):WaitForChild("RemoteWrapper")).new("PetInteracted")
local module_8_upvr = {}
module_8_upvr.__index = module_8_upvr
module_8_upvr.Type = "InteractionHandler"
local RunService_upvr = game:GetService("RunService")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
module_8_upvr.isInteracting = false
module_8_upvr.CurrentPet = nil
module_8_upvr.isTweeningUI = false
module_8_upvr.PerformingAction = false
module_8_upvr.UpdateConnection = nil
module_8_upvr.DestroyedConnection = nil
module_8_upvr.isRidingPet = false
local tbl_upvr_2 = {
	Bathe = 2.8;
	Feed = 2.3;
	Love = 2.3;
}
local var11_upvw
local clone_28_upvr = ReplicatedStorage_upvr.Assets.Sounds.JumpSFX:Clone()
local clone_8_upvr = ReplicatedStorage_upvr.Assets.Sounds.HeartExplosionSFX:Clone()
module_8_upvr.InteractiveUI = ReplicatedStorage_upvr.Assets.Billboards.InteractionUI:Clone()
module_8_upvr.InteractiveUI.Parent = LocalPlayer_upvr:WaitForChild("PlayerGui")
module_8_upvr.InteractiveUI.Adornee = nil
module_8_upvr.InteractiveUI.Enabled = false
local tbl_upvr = {
	Bathe = {"Time to give you a bath! ðŸ§½", "Let's get you all cleaned up! ðŸ§½", "How about we clean you up? ðŸ§½"};
	Love = {"Awww you're so cute! ðŸ¥°", "Here's a special hug! ðŸ¥°"};
	Feed = {"Here's a yummy snack! ðŸ¥•", "Here, have this treat! ðŸ“", "Aww, I have a treat for you! ðŸ’"};
}
function QuickTween(arg1, arg2, arg3, arg4, arg5) -- Line 87
	local module = {}
	module.CFrame = arg2
	return game:GetService("TweenService"):Create(arg1, TweenInfo.new(arg3, arg4, arg5), module)
end
function QuickTransparencyTween(arg1, arg2, arg3, arg4, arg5) -- Line 100
	local module_10 = {}
	module_10.BackgroundTransparency = arg2
	return game:GetService("TweenService"):Create(arg1, TweenInfo.new(arg3, arg4, arg5, 2), module_10)
end
function GetWalkSpeed() -- Line 114
	--[[ Upvalues[1]:
		[1]: LocalPlayer_upvr (readonly)
	]]
	return LocalPlayer_upvr:GetAttribute("Speed") or 25
end
function GetPetSize(arg1) -- Line 119
	local Body = arg1:FindFirstChild("Body")
	if Body then
		return Body.Size
	end
	if arg1:FindFirstChild("Root") then
		return arg1.PrimaryPart.Size
	end
	local _, any_GetBoundingBox_result2 = arg1:GetBoundingBox()
	return any_GetBoundingBox_result2
end
function Welder(arg1, arg2, arg3, arg4, arg5) -- Line 134
	local Motor6D = Instance.new("Motor6D")
	Motor6D.Parent = arg1
	Motor6D.Name = arg1.Name..':'..arg2.Name
	Motor6D.Part0 = arg1
	Motor6D.Part1 = arg2
	if arg3 then
		Motor6D.C0 = CFrame.new()
		Motor6D.C1 = arg2.CFrame:inverse() * arg1.CFrame
	else
		Motor6D.C0 = arg4
		Motor6D.C1 = arg5
	end
	arg2.Anchored = false
	return Motor6D
end
local module_5_upvr = require(ReplicatedStorage_upvr:WaitForChild("Client"):WaitForChild("Components"):WaitForChild("UI"):WaitForChild("EventTracker"))
local module_3_upvr = require(ReplicatedStorage_upvr:WaitForChild("Shared"):WaitForChild("Components"):WaitForChild("Pets"):WaitForChild("LevelHandler"))
function module_8_upvr.FlashUI(arg1, arg2) -- Line 151
	--[[ Upvalues[5]:
		[1]: module_8_upvr (readonly)
		[2]: var11_upvw (read and write)
		[3]: tbl_upvr_2 (readonly)
		[4]: module_5_upvr (readonly)
		[5]: module_3_upvr (readonly)
	]]
	local var26
	if not var26 then
	else
		var26 = module_8_upvr.CurrentPet._UI
		if not var26 then return end
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var26 = tbl_upvr_2[var11_upvw]
			return var26
		end
		if not var11_upvw or not INLINED() then
			var26 = 0.45
		end
		module_5_upvr.CurrentTracker:FlashUI(arg2, var26)
		module_5_upvr.CurrentTracker:TrackProgress(arg2, var26)
		local QuickTransparencyTween_result1 = QuickTransparencyTween(module_8_upvr.CurrentPet._UI.Frame.Bar.Fill.Flashy, 0.35, 0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		QuickTransparencyTween_result1:Play()
		QuickTransparencyTween_result1.Completed:Connect(function() -- Line 166
			--[[ Upvalues[1]:
				[1]: module_8_upvr (copied, readonly)
			]]
			if not module_8_upvr.InteractiveUI then
			else
				if not module_8_upvr.CurrentPet then return end
				module_8_upvr.CurrentPet._UI.Frame.Bar.Fill.Flashy.BackgroundTransparency = 1
			end
		end)
		local any_GetProgress_result1 = module_3_upvr.GetProgress(module_8_upvr.CurrentPet._Level + 1)
		if any_GetProgress_result1.Progress == 0 then
			any_GetProgress_result1.Progress = 1
		end
		module_8_upvr.CurrentPet._UI.Frame.Bar.Fill:TweenSize(UDim2.new(math.clamp(any_GetProgress_result1.Progress, 0, 1), 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, var26, true)
	end
end
function FindPositionForShower(arg1, arg2) -- Line 180
	--[[ Upvalues[1]:
		[1]: ReplicatedStorage_upvr (readonly)
	]]
	local Size = ReplicatedStorage_upvr.Assets.Prefabs.Shower.PrimaryPart.Size
	local Position_6 = (arg1.CFrame * arg2._PetRotationOffset * CFrame.new(0, -arg1.Size.Y / 2, Size.Z / 2 + 5)).Position
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Include
	RaycastParams_new_result1.FilterDescendantsInstances = {game.Workspace.Maps}
	RaycastParams_new_result1.IgnoreWater = true
	local any_Raycast_result1 = game.Workspace:Raycast(Position_6 + Vector3.new(0, Size.Y, 0), Vector3.new(0, -100, 0), RaycastParams_new_result1)
	local var35
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var35 = any_Raycast_result1.Position
		return var35
	end
	if not any_Raycast_result1 or not INLINED_2() then
		var35 = Position_6
	end
	return CFrame.new(var35, Vector3.new(arg1.Position.X, var35.Y, arg1.Position.Z))
end
local TextChatService_upvr = game:GetService("TextChatService")
function module_8_upvr.PlayerSpeak(arg1, arg2) -- Line 206
	--[[ Upvalues[3]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: TextChatService_upvr (readonly)
	]]
	if not arg2 then
	else
		if not LocalPlayer_upvr.Character then return end
		if not tbl_upvr[arg2] then return end
		TextChatService_upvr:DisplayBubble(LocalPlayer_upvr.Character, tbl_upvr[arg2][math.random(1, #tbl_upvr[arg2])])
	end
end
local function _(arg1, arg2, arg3, arg4) -- Line 217, Named "QuadraticCurve"
	return (1 - arg4) * (1 - arg4) * arg1 + 2 * (1 - arg4) * arg4 * arg2 + arg4 * arg4 * arg3
end
local clone_15_upvr = ReplicatedStorage_upvr.Assets.Sounds.SteamSFX:Clone()
local clone_25_upvr = ReplicatedStorage_upvr.Assets.Sounds.ShowerRunningSFX:Clone()
function module_8_upvr.Bathe(arg1, arg2, arg3) -- Line 223
	--[[ Upvalues[9]:
		[1]: module_8_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: any_new_result1_upvr_4 (readonly)
		[6]: clone_15_upvr (readonly)
		[7]: clone_25_upvr (readonly)
		[8]: clone_8_upvr (readonly)
		[9]: module_11_upvr (readonly)
	]]
	if not arg3 and module_8_upvr.PerformingAction then
	else
		if not arg2 then return end
		if table.isfrozen(arg2) then return end
		if arg2._Player == LocalPlayer_upvr and LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("Humanoid") then
			LocalPlayer_upvr.Character.Humanoid.Sit = false
		end
		if not arg3 then
			require(game.ReplicatedStorage.Client.Components.UI.React.State).PieMenu.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set(true)
			module_8_upvr.PerformingAction = "Bathe"
			var11_upvw = "Bathe"
			module_8_upvr:PlayerSpeak("Bathe")
		end
		local clone_11 = ReplicatedStorage_upvr.Assets.Prefabs.Shower:Clone()
		clone_11.Parent = game.Workspace
		local _Root_6 = arg2._Root
		if _Root_6:FindFirstChild("Body") then
			_Root_6 = _Root_6.Body
		end
		local clone_18_upvr = ReplicatedStorage_upvr.Assets.VFX.HeartVFX.Attachment:Clone()
		clone_18_upvr.Parent = _Root_6
		local Parent_upvr = arg2._Root.Parent
		local GetPetSize_result1 = GetPetSize(Parent_upvr)
		local _PetRotationOffset = arg2._PetRotationOffset
		if not arg3 then
			local var46_upvw = false
			task.spawn(function() -- Line 277
				--[[ Upvalues[5]:
					[1]: any_new_result1_upvr_4 (copied, readonly)
					[2]: arg2 (readonly)
					[3]: var46_upvw (read and write)
					[4]: clone_18_upvr (readonly)
					[5]: module_8_upvr (copied, readonly)
				]]
				local any_InvokeServer_result1_4 = any_new_result1_upvr_4:InvokeServer({arg2._UID, "Bathed"})
				if any_InvokeServer_result1_4 and any_InvokeServer_result1_4[1] == "Success" then
					var46_upvw = true
					clone_18_upvr.Hearts.Enabled = true
					module_8_upvr:FlashUI("Stinky")
				else
					clone_18_upvr:Destroy()
				end
			end)
		else
			clone_18_upvr:Destroy()
		end
		clone_11:PivotTo(FindPositionForShower(arg2._Root, arg2) * CFrame.new(0, clone_11.PrimaryPart.Size.Y / 2, 0))
		local clone_13 = clone_15_upvr:Clone()
		clone_13.Parent = clone_11.PrimaryPart
		clone_13:Destroy()
		arg2:SetState("Interacting")
		arg2._AlignPosition.Position = (clone_11.PrimaryPart.PetStartPosition.WorldCFrame * CFrame.new(0, GetPetSize_result1.Y / 2, 0)).Position
		arg2._AlignOrientation.CFrame = clone_11.PrimaryPart.PetStartPosition.WorldCFrame * CFrame.new(0, GetPetSize_result1.Y / 2, 0) * _PetRotationOffset
		task.wait(0.3)
		arg2._AlignPosition.Position = (clone_11.PrimaryPart.PetPosition.WorldCFrame * CFrame.new(0, GetPetSize_result1.Y / 2, 0)).Position
		arg2._AlignOrientation.CFrame = clone_11.PrimaryPart.PetPosition.WorldCFrame * CFrame.new(0, GetPetSize_result1.Y / 2, 0) * _PetRotationOffset
		task.wait(0.5)
		local clone_30 = clone_25_upvr:Clone()
		clone_30.Parent = clone_11.PrimaryPart
		clone_30:Destroy()
		if not table.isfrozen(arg2) and arg2._BatheAnimation then
			arg2._BatheAnimation:Play()
		end
		clone_11.ShowerHead.Attachment.ParticleEmitter.Enabled = true
		task.wait(2)
		if not table.isfrozen(arg2) then
			if arg2._BatheAnimation then
				arg2._BatheAnimation:Stop()
			end
			arg2:SetState("Idle")
		end
		clone_11:Destroy()
		if not arg3 then
			if var46_upvw then
				task.delay(0.4, function() -- Line 347
					--[[ Upvalues[4]:
						[1]: clone_18_upvr (readonly)
						[2]: clone_8_upvr (copied, readonly)
						[3]: Parent_upvr (readonly)
						[4]: module_11_upvr (copied, readonly)
					]]
					for _, v in pairs(clone_18_upvr:GetChildren()) do
						v:Emit(20)
					end
					local clone_29 = clone_8_upvr:Clone()
					clone_29.Parent = Parent_upvr.PrimaryPart
					clone_29:Destroy()
					task.delay(0.5, function() -- Line 356
						--[[ Upvalues[3]:
							[1]: clone_18_upvr (copied, readonly)
							[2]: module_11_upvr (copied, readonly)
							[3]: Parent_upvr (copied, readonly)
						]]
						clone_18_upvr:Destroy()
						module_11_upvr:Create(Parent_upvr.PrimaryPart.CFrame, "Berry", 5, Parent_upvr.PrimaryPart, true, 1, true, false)
					end)
				end)
			end
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			require(game.ReplicatedStorage.Client.Components.UI.React.State).PieMenu.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set(nil)
			module_8_upvr.PerformingAction = false
		end
	end
end
local clone_3_upvr = ReplicatedStorage_upvr.Assets.Sounds.BiteSFX:Clone()
local clone_14_upvr = ReplicatedStorage_upvr.Assets.Sounds.EatingSFX:Clone()
function module_8_upvr.Feed(arg1, arg2, arg3) -- Line 369
	--[[ Upvalues[10]:
		[1]: module_8_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: any_new_result1_upvr_4 (readonly)
		[6]: RunService_upvr (readonly)
		[7]: clone_3_upvr (readonly)
		[8]: clone_14_upvr (readonly)
		[9]: clone_8_upvr (readonly)
		[10]: module_11_upvr (readonly)
	]]
	if not arg3 and module_8_upvr.PerformingAction then
	else
		if not arg2 then return end
		if table.isfrozen(arg2) then return end
		local var61_upvr
		if arg2._Player == LocalPlayer_upvr and LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("Humanoid") then
			LocalPlayer_upvr.Character.Humanoid.Sit = false
		end
		var61_upvr = game.ReplicatedStorage.Client.Components
		if not arg3 then
			var61_upvr = require(var61_upvr.UI.React.State).PieMenu
			var61_upvr = true
			var61_upvr.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set(var61_upvr)
			module_8_upvr.PerformingAction = "Feed"
			var11_upvw = "Feed"
			var61_upvr = "Feed"
			module_8_upvr:PlayerSpeak(var61_upvr)
		end
		local Parent_upvr_2 = arg2._Root.Parent
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			var61_upvr = LocalPlayer_upvr.Character
			return var61_upvr
		end
		if arg2._Player ~= game.Players.LocalPlayer or not INLINED_3() then
			var61_upvr = game.Workspace:FindFirstChild(arg2._Player.Name)
		end
		local any_LoadAnimation_result1 = var61_upvr.Humanoid:LoadAnimation(ReplicatedStorage_upvr.Assets.Animations.ThrowBerry)
		local clone_21_upvr = ReplicatedStorage_upvr.Assets.RewardsPrefab.Berry:Clone()
		clone_21_upvr.CanCollide = false
		clone_21_upvr.Anchored = true
		clone_21_upvr.ProximityPrompt:Destroy()
		local _Root_4 = arg2._Root
		if _Root_4:FindFirstChild("Body") then
			_Root_4 = _Root_4.Body
		end
		local clone_24_upvr = ReplicatedStorage_upvr.Assets.VFX.HeartVFX.Attachment:Clone()
		clone_24_upvr.Parent = _Root_4
		local Position_8 = var61_upvr.PrimaryPart.Position
		var61_upvr.Humanoid.WalkSpeed = 0
		if not arg3 then
			local var69_upvw = false
			task.spawn(function() -- Line 434
				--[[ Upvalues[5]:
					[1]: any_new_result1_upvr_4 (copied, readonly)
					[2]: arg2 (readonly)
					[3]: var69_upvw (read and write)
					[4]: clone_24_upvr (readonly)
					[5]: module_8_upvr (copied, readonly)
				]]
				local any_InvokeServer_result1_2 = any_new_result1_upvr_4:InvokeServer({arg2._UID, "Fed"})
				if any_InvokeServer_result1_2 and any_InvokeServer_result1_2[1] == "Success" then
					var69_upvw = true
					clone_24_upvr.Hearts.Enabled = true
					module_8_upvr:FlashUI("Hungry")
				else
					clone_24_upvr:Destroy()
				end
			end)
		else
			clone_24_upvr:Destroy()
		end
		task.wait(0.1)
		local var72 = Parent_upvr_2.PrimaryPart.CFrame * arg2._PetRotationOffset
		local Position_2_upvr = var61_upvr.RightHand.Position
		local var74_upvr = var72.Position + Vector3.new(0, 1, 0)
		local var75 = (Position_2_upvr + var74_upvr) / 2
		local QuickTween_result1 = QuickTween(var61_upvr.PrimaryPart, CFrame.new(Position_8, Vector3.new(var72.Position.X, Position_8.Y, var72.Position.Z)), 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		QuickTween_result1:Play()
		QuickTween_result1.Completed:Wait()
		any_LoadAnimation_result1:Play()
		repeat
			task.wait()
		until 0.6328358208955223 <= any_LoadAnimation_result1.TimePosition
		clone_21_upvr.Parent = game.Workspace.Terrain
		local tick_result1_upvr_2 = tick()
		local var79_upvw
		local vector3_upvr_3 = Vector3.new(var75.X, var75.Y + 20, var75.Z)
		var79_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 491
			--[[ Upvalues[6]:
				[1]: tick_result1_upvr_2 (readonly)
				[2]: var79_upvw (read and write)
				[3]: Position_2_upvr (readonly)
				[4]: vector3_upvr_3 (readonly)
				[5]: var74_upvr (readonly)
				[6]: clone_21_upvr (readonly)
			]]
			local var81 = tick() - tick_result1_upvr_2
			if 1 <= var81 then
				var79_upvw:Disconnect()
			else
				clone_21_upvr.CFrame = CFrame.new((1 - var81) * (1 - var81) * Position_2_upvr + 2 * (1 - var81) * var81 * vector3_upvr_3 + var81 * var81 * var74_upvr)
			end
		end)
		task.delay(0.94, function() -- Line 507
			--[[ Upvalues[4]:
				[1]: arg2 (readonly)
				[2]: Parent_upvr_2 (readonly)
				[3]: var74_upvr (readonly)
				[4]: clone_21_upvr (readonly)
			]]
			if table.isfrozen(arg2) then
			else
				if arg2._JumpAnimation then
					arg2._JumpAnimation:Play()
					return
				end
				Parent_upvr_2.PrimaryPart.Anchored = true
				local QuickTween_result1_2 = QuickTween(Parent_upvr_2.PrimaryPart, CFrame.new(var74_upvr, clone_21_upvr.CFrame.Position), 0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				QuickTween_result1_2:Play()
				QuickTween_result1_2.Completed:Wait()
				Parent_upvr_2.PrimaryPart.Anchored = false
			end
		end)
		task.delay(0.9, function() -- Line 525
			--[[ Upvalues[2]:
				[1]: clone_3_upvr (copied, readonly)
				[2]: Parent_upvr_2 (readonly)
			]]
			local clone_26 = clone_3_upvr:Clone()
			clone_26.Parent = Parent_upvr_2.PrimaryPart
			clone_26:Destroy()
		end)
		task.delay(1, function() -- Line 531
			--[[ Upvalues[4]:
				[1]: arg2 (readonly)
				[2]: clone_21_upvr (readonly)
				[3]: clone_14_upvr (copied, readonly)
				[4]: Parent_upvr_2 (readonly)
			]]
			if not table.isfrozen(arg2) then
				arg2:Chew(true)
			end
			clone_21_upvr:Destroy()
			local clone_19 = clone_14_upvr:Clone()
			clone_19.Parent = Parent_upvr_2.PrimaryPart
			clone_19:Destroy()
		end)
		local WalkSpeed_upvr_3 = var61_upvr.Humanoid.WalkSpeed
		task.delay(1, function() -- Line 543
			--[[ Upvalues[2]:
				[1]: var61_upvr (readonly)
				[2]: WalkSpeed_upvr_3 (readonly)
			]]
			local var90
			local function INLINED_4() -- Internal function, doesn't exist in bytecode
				var90 = GetWalkSpeed()
				return var90
			end
			if WalkSpeed_upvr_3 ~= 0 or not INLINED_4() then
				var90 = WalkSpeed_upvr_3
			end
			var61_upvr.Humanoid.WalkSpeed = var90
		end)
		task.wait(2)
		task.delay(1.35, function() -- Line 550
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			if table.isfrozen(arg2) then
			else
				arg2:Chew(false)
			end
		end)
		if not arg3 then
			if var69_upvw then
				task.delay(0.4, function() -- Line 558
					--[[ Upvalues[4]:
						[1]: clone_24_upvr (readonly)
						[2]: clone_8_upvr (copied, readonly)
						[3]: Parent_upvr_2 (readonly)
						[4]: module_11_upvr (copied, readonly)
					]]
					for _, v_2 in pairs(clone_24_upvr:GetChildren()) do
						v_2:Emit(20)
					end
					local clone_12 = clone_8_upvr:Clone()
					clone_12.Parent = Parent_upvr_2.PrimaryPart
					clone_12:Destroy()
					task.delay(0.5, function() -- Line 567
						--[[ Upvalues[3]:
							[1]: clone_24_upvr (copied, readonly)
							[2]: module_11_upvr (copied, readonly)
							[3]: Parent_upvr_2 (copied, readonly)
						]]
						clone_24_upvr:Destroy()
						module_11_upvr:Create(Parent_upvr_2.PrimaryPart.CFrame, "Berry", 5, Parent_upvr_2.PrimaryPart, true, 1, true, false)
					end)
				end)
			end
			module_8_upvr.PerformingAction = false
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			require(var61_upvr.UI.React.State).PieMenu.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set(nil)
		end
	end
end
local module_2_upvr = require(ReplicatedStorage_upvr:WaitForChild("Client"):WaitForChild("Components"):WaitForChild("Pet"):WaitForChild("FaceRig"))
local clone_17_upvr = ReplicatedStorage_upvr.Assets.Sounds.HappySFX:Clone()
local clone_5_upvr = ReplicatedStorage_upvr.Assets.Sounds.LandSFX:Clone()
function module_8_upvr.Love(arg1, arg2, arg3) -- Line 580
	--[[ Upvalues[13]:
		[1]: module_8_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var11_upvw (read and write)
		[4]: ReplicatedStorage_upvr (readonly)
		[5]: any_new_result1_upvr_4 (readonly)
		[6]: module_9_upvr (readonly)
		[7]: module_2_upvr (readonly)
		[8]: clone_28_upvr (readonly)
		[9]: RunService_upvr (readonly)
		[10]: clone_17_upvr (readonly)
		[11]: clone_5_upvr (readonly)
		[12]: clone_8_upvr (readonly)
		[13]: module_11_upvr (readonly)
	]]
	if not arg3 and module_8_upvr.PerformingAction then
	else
		if not arg2 then return end
		if table.isfrozen(arg2) then return end
		local var141_upvr
		if arg2._Player == LocalPlayer_upvr and LocalPlayer_upvr.Character then
			var141_upvr = "Humanoid"
			if LocalPlayer_upvr.Character:FindFirstChild(var141_upvr) then
				var141_upvr = LocalPlayer_upvr
				var141_upvr.Character.Humanoid.Sit = false
			end
		end
		var141_upvr = game.ReplicatedStorage.Client.Components.UI.React
		if not arg3 then
			var141_upvr = require(var141_upvr.State).PieMenu.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set
			var141_upvr(true)
			var141_upvr = module_8_upvr
			var141_upvr.PerformingAction = "Love"
			var141_upvr = "Love"
			var11_upvw = var141_upvr
			var141_upvr = module_8_upvr:PlayerSpeak
			var141_upvr("Love")
		end
		local function INLINED_7() -- Internal function, doesn't exist in bytecode
			var141_upvr = LocalPlayer_upvr.Character
			return var141_upvr
		end
		if arg2._Player ~= game.Players.LocalPlayer or not INLINED_7() then
			var141_upvr = game.Workspace:FindFirstChild(arg2._Player.Name)
		end
		local _Root_2 = arg2._Root
		if _Root_2:FindFirstChild("Body") then
			_Root_2 = _Root_2.Body
		end
		local clone_20_upvr = ReplicatedStorage_upvr.Assets.VFX.HeartVFX.Attachment:Clone()
		clone_20_upvr.Parent = _Root_2
		local Parent_upvr_3 = arg2._Root.Parent
		local _PetRotationOffset_5_upvr = arg2._PetRotationOffset
		local _PetRotationY_upvr_4 = arg2._PetRotationY
		local var147_upvw = false
		if not arg3 then
			task.spawn(function() -- Line 637
				--[[ Upvalues[5]:
					[1]: any_new_result1_upvr_4 (copied, readonly)
					[2]: arg2 (readonly)
					[3]: var147_upvw (read and write)
					[4]: clone_20_upvr (readonly)
					[5]: module_8_upvr (copied, readonly)
				]]
				local any_InvokeServer_result1 = any_new_result1_upvr_4:InvokeServer({arg2._UID, "Hugged"})
				if any_InvokeServer_result1 and any_InvokeServer_result1[1] == "Success" then
					var147_upvw = true
					clone_20_upvr.Hearts.Enabled = true
					module_8_upvr:FlashUI("Lonely")
				else
					clone_20_upvr:Destroy()
				end
			end)
		else
			clone_20_upvr:Destroy()
		end
		local Position = var141_upvr.PrimaryPart.Position
		var141_upvr.Humanoid.WalkSpeed = 0
		arg2:SetState("Interacting")
		local var152
		if not table.isfrozen(arg2) and arg2._Age ~= "Egg" then
			var152 = module_9_upvr.GetComponent(arg2._Root, module_2_upvr)
			if var152 then
				var152:RenderEyes("Happy", 2)
				var152:RenderEyebrows("Neutral", 1)
			end
		end
		arg2._LastHappyState.Lonely = false
		local Position_3_upvr = Parent_upvr_3:GetPivot().Position
		local Position_5_upvr = (CFrame.new(Position, Parent_upvr_3.PrimaryPart.Position) * CFrame.new(0, 0, -2)).Position
		local var155 = (Position_3_upvr + Position_5_upvr) / 2
		QuickTween(var141_upvr.PrimaryPart, CFrame.new(Position, Vector3.new(Parent_upvr_3.PrimaryPart.Position.X, Position.Y, Parent_upvr_3.PrimaryPart.Position.Z)), 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out):Play()
		local clone = clone_28_upvr:Clone()
		clone.Parent = Parent_upvr_3.PrimaryPart
		clone:Destroy()
		local tick_result1_upvr_5 = tick()
		local var159_upvw
		local vector3_upvr_5 = Vector3.new(var155.X, var155.Y + 20, var155.Z)
		var159_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 704
			--[[ Upvalues[8]:
				[1]: tick_result1_upvr_5 (readonly)
				[2]: var159_upvw (read and write)
				[3]: Position_3_upvr (readonly)
				[4]: vector3_upvr_5 (readonly)
				[5]: Position_5_upvr (readonly)
				[6]: arg2 (readonly)
				[7]: _PetRotationOffset_5_upvr (readonly)
				[8]: _PetRotationY_upvr_4 (readonly)
			]]
			local var161 = (tick() - tick_result1_upvr_5) * 2
			if 1 <= var161 then
				var159_upvw:Disconnect()
			else
				local var162 = (1 - var161) * (1 - var161) * Position_3_upvr + 2 * (1 - var161) * var161 * vector3_upvr_5 + var161 * var161 * Position_5_upvr
				arg2._AlignPosition.Responsiveness = 100
				arg2._AlignPosition.Position = var162
				arg2._AlignOrientation.CFrame = CFrame.new(var162) * _PetRotationOffset_5_upvr * CFrame.Angles((math.pi/2), math.rad(-20 + _PetRotationY_upvr_4), (math.pi/2))
			end
		end)
		local GetPetSize_result1_upvr_2 = GetPetSize(Parent_upvr_3)
		local any_LoadAnimation_result1_5_upvr = var141_upvr.Humanoid:LoadAnimation(ReplicatedStorage_upvr.Assets.Animations.CarryPet)
		local Responsiveness_upvr_7 = arg2._AlignPosition.Responsiveness
		local WalkSpeed_upvr_2 = var141_upvr.Humanoid.WalkSpeed
		task.delay(0.5, function() -- Line 723
			--[[ Upvalues[12]:
				[1]: var159_upvw (read and write)
				[2]: arg2 (readonly)
				[3]: GetPetSize_result1_upvr_2 (readonly)
				[4]: var141_upvr (readonly)
				[5]: _PetRotationOffset_5_upvr (readonly)
				[6]: _PetRotationY_upvr_4 (readonly)
				[7]: Parent_upvr_3 (readonly)
				[8]: any_LoadAnimation_result1_5_upvr (readonly)
				[9]: clone_17_upvr (copied, readonly)
				[10]: clone_5_upvr (copied, readonly)
				[11]: Responsiveness_upvr_7 (readonly)
				[12]: WalkSpeed_upvr_2 (readonly)
			]]
			-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
			local var168
			if var168 then
				var168 = var159_upvw:Disconnect
				var168()
			end
			local function INLINED_8() -- Internal function, doesn't exist in bytecode
				var168 = GetPetSize_result1_upvr_2.X / 2.5
				return var168
			end
			if not arg2._HasWings or not INLINED_8() then
				var168 = GetPetSize_result1_upvr_2.X / 2
			end
			var141_upvr.PrimaryPart.Anchored = true
			any_LoadAnimation_result1_5_upvr:Play()
			local clone_27 = clone_17_upvr:Clone()
			clone_27.Parent = Parent_upvr_3.PrimaryPart
			clone_27:Destroy()
			local clone_2 = clone_5_upvr:Clone()
			clone_2.Parent = Parent_upvr_3.PrimaryPart
			clone_2:Destroy()
			task.wait(1.5)
			if not table.isfrozen(arg2) then
				arg2._AlignPosition.Responsiveness = Responsiveness_upvr_7
			end
			any_LoadAnimation_result1_5_upvr:Stop()
			Welder(var141_upvr.UpperTorso, Parent_upvr_3.PrimaryPart, false, (var141_upvr.UpperTorso.CFrame:inverse()) * (var141_upvr.UpperTorso.CFrame * CFrame.new(0, 0, -var168) * _PetRotationOffset_5_upvr * CFrame.Angles((math.pi/2), math.rad(-20 + _PetRotationY_upvr_4), (math.pi/2))), CFrame.new()):Destroy()
			if WalkSpeed_upvr_2 ~= 0 or not GetWalkSpeed() then
			end
			var141_upvr.Humanoid.WalkSpeed = WalkSpeed_upvr_2
			var141_upvr.PrimaryPart.Anchored = false
		end)
		task.wait(2.3)
		if not table.isfrozen(arg2) then
			if var152 then
				var152:RenderEyebrows(nil, 1)
				var152:RenderEyes(nil, 2)
			end
			arg2:SetState("Idle")
		end
		if not arg3 then
			if var147_upvw then
				task.delay(0.4, function() -- Line 770
					--[[ Upvalues[4]:
						[1]: clone_20_upvr (readonly)
						[2]: clone_8_upvr (copied, readonly)
						[3]: Parent_upvr_3 (readonly)
						[4]: module_11_upvr (copied, readonly)
					]]
					for _, v_3 in pairs(clone_20_upvr:GetChildren()) do
						v_3:Emit(20)
					end
					local clone_10 = clone_8_upvr:Clone()
					clone_10.Parent = Parent_upvr_3.PrimaryPart
					clone_10:Destroy()
					task.delay(0.5, function() -- Line 779
						--[[ Upvalues[3]:
							[1]: clone_20_upvr (copied, readonly)
							[2]: module_11_upvr (copied, readonly)
							[3]: Parent_upvr_3 (copied, readonly)
						]]
						clone_20_upvr:Destroy()
						module_11_upvr:Create(Parent_upvr_3.PrimaryPart.CFrame, "Berry", 5, Parent_upvr_3.PrimaryPart, true, 1, true, false)
					end)
				end)
			end
			module_8_upvr.PerformingAction = false
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
			require(var141_upvr.State).PieMenu.Hide[game:GetService("HttpService"):GenerateGUID(false)]:Set(nil)
		end
	end
end
local tbl_upvr_3 = {
	Slide = function(arg1, arg2) -- Line 792, Named "Slide"
		--[[ Upvalues[3]:
			[1]: module_7_upvr (readonly)
			[2]: ReplicatedStorage_upvr (readonly)
			[3]: module_9_upvr (readonly)
		]]
		local any_new_result1_upvr_5 = module_7_upvr.new()
		local PetAnimations = ReplicatedStorage_upvr.Assets.PetAnimations
		local AnimationController_7 = arg1._Root.Parent:FindFirstChild("AnimationController")
		local Seated_upvr_6 = arg1._Root:GetAttribute("Seated")
		local Weld_upvr_2 = Instance.new("Weld")
		Weld_upvr_2.Parent = arg1._Root
		Weld_upvr_2.Part0 = arg1._Root
		Weld_upvr_2.Part1 = arg2.BodyOffsetRig.Offset
		Weld_upvr_2.C0 = CFrame.new(0, -arg1._Root.Size.Y / 2, 0)
		task.wait((string.byte(arg2.Name) - 64) * 0.25)
		if table.isfrozen(arg1) then
		elseif arg1._Root:GetAttribute("Seated") == Seated_upvr_6 then
			if AnimationController_7 then
				local any_LoadAnimation_result1_8_upvr = AnimationController_7:LoadAnimation(PetAnimations.Slide_BodyAnimation)
				any_LoadAnimation_result1_8_upvr.Priority = Enum.AnimationPriority.Action4
				any_LoadAnimation_result1_8_upvr:Play()
				local any_LoadAnimation_result1_4_upvr = arg2.BodyOffsetRig:FindFirstChild("AnimationController"):LoadAnimation(PetAnimations.Slide_BodyOffset)
				any_LoadAnimation_result1_4_upvr.Priority = Enum.AnimationPriority.Action4
				any_LoadAnimation_result1_4_upvr:Play()
				any_new_result1_upvr_5:Add(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 821
					--[[ Upvalues[6]:
						[1]: arg1 (readonly)
						[2]: Seated_upvr_6 (readonly)
						[3]: Weld_upvr_2 (readonly)
						[4]: any_LoadAnimation_result1_4_upvr (readonly)
						[5]: any_LoadAnimation_result1_8_upvr (readonly)
						[6]: any_new_result1_upvr_5 (readonly)
					]]
					if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_6 then
						if Weld_upvr_2 then
							Weld_upvr_2:Destroy()
						end
						any_LoadAnimation_result1_4_upvr:Stop()
						any_LoadAnimation_result1_8_upvr:Stop()
						any_new_result1_upvr_5:Clean()
					end
				end))
				any_new_result1_upvr_5:Add(arg1._Root.Destroying:Connect(function() -- Line 831
					--[[ Upvalues[4]:
						[1]: Weld_upvr_2 (readonly)
						[2]: any_LoadAnimation_result1_4_upvr (readonly)
						[3]: any_LoadAnimation_result1_8_upvr (readonly)
						[4]: any_new_result1_upvr_5 (readonly)
					]]
					if Weld_upvr_2 then
						Weld_upvr_2:Destroy()
					end
					any_LoadAnimation_result1_4_upvr:Stop()
					any_LoadAnimation_result1_8_upvr:Stop()
					any_new_result1_upvr_5:Clean()
				end))
			else
				any_LoadAnimation_result1_8_upvr = any_new_result1_upvr_5:Add
				any_LoadAnimation_result1_8_upvr(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 839
					--[[ Upvalues[4]:
						[1]: arg1 (readonly)
						[2]: Seated_upvr_6 (readonly)
						[3]: Weld_upvr_2 (readonly)
						[4]: any_new_result1_upvr_5 (readonly)
					]]
					if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_6 then
						if Weld_upvr_2 then
							Weld_upvr_2:Destroy()
						end
						any_new_result1_upvr_5:Clean()
					end
				end))
				any_LoadAnimation_result1_8_upvr = any_new_result1_upvr_5:Add
				any_LoadAnimation_result1_8_upvr(arg1._Root.Destroying:Connect(function() -- Line 847
					--[[ Upvalues[2]:
						[1]: Weld_upvr_2 (readonly)
						[2]: any_new_result1_upvr_5 (readonly)
					]]
					if Weld_upvr_2 then
						Weld_upvr_2:Destroy()
					end
					any_new_result1_upvr_5:Clean()
				end))
			end
			any_LoadAnimation_result1_8_upvr = require
			any_LoadAnimation_result1_4_upvr = ReplicatedStorage_upvr.Client.Components.Pet.FaceRig
			any_LoadAnimation_result1_8_upvr = any_LoadAnimation_result1_8_upvr(any_LoadAnimation_result1_4_upvr)
			any_LoadAnimation_result1_4_upvr = module_9_upvr.GetComponent(arg1._Root, any_LoadAnimation_result1_8_upvr)
			local var191_upvr = any_LoadAnimation_result1_4_upvr
			if arg1._Age ~= "Egg" and var191_upvr then
				var191_upvr:RenderEyes("Happy", 5)
				var191_upvr:RenderEyebrows("Neutral", 5)
				local var193_upvw
				var193_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 860
					--[[ Upvalues[4]:
						[1]: arg1 (readonly)
						[2]: Seated_upvr_6 (readonly)
						[3]: var191_upvr (readonly)
						[4]: var193_upvw (read and write)
					]]
					if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_6 then
						var191_upvr:RenderEyes(nil, 5)
						var191_upvr:RenderEyebrows(nil, 5)
						var193_upvw:Disconnect()
					end
				end)
			end
		end
	end;
	SwingHorse = function(arg1, arg2) -- Line 870, Named "SwingHorse"
		--[[ Upvalues[3]:
			[1]: module_7_upvr (readonly)
			[2]: ReplicatedStorage_upvr (readonly)
			[3]: module_9_upvr (readonly)
		]]
		local any_new_result1_upvr = module_7_upvr.new()
		local AnimationController_6 = arg1._Root.Parent:FindFirstChild("AnimationController")
		local Weld_upvr = Instance.new("Weld")
		Weld_upvr.Parent = arg1._Root
		Weld_upvr.Part0 = arg1._Root
		Weld_upvr.Part1 = arg2
		Weld_upvr.C0 = CFrame.new(0, -arg1._Root.Size.Y / 2, 0)
		if AnimationController_6 then
			local any_LoadAnimation_result1_2_upvr = AnimationController_6:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.Sit)
			any_LoadAnimation_result1_2_upvr.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_2_upvr:Play()
			local Seated_upvr = arg1._Root:GetAttribute("Seated")
			any_new_result1_upvr:Add(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 888
				--[[ Upvalues[5]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr (readonly)
					[3]: Weld_upvr (readonly)
					[4]: any_LoadAnimation_result1_2_upvr (readonly)
					[5]: any_new_result1_upvr (readonly)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr then
					if Weld_upvr then
						Weld_upvr:Destroy()
					end
					any_LoadAnimation_result1_2_upvr:Stop()
					any_new_result1_upvr:Clean()
				end
			end))
			any_new_result1_upvr:Add(arg1._Root.Destroying:Connect(function() -- Line 896
				--[[ Upvalues[3]:
					[1]: Weld_upvr (readonly)
					[2]: any_LoadAnimation_result1_2_upvr (readonly)
					[3]: any_new_result1_upvr (readonly)
				]]
				if Weld_upvr then
					Weld_upvr:Destroy()
				end
				any_LoadAnimation_result1_2_upvr:Stop()
				any_new_result1_upvr:Clean()
			end))
		else
			any_LoadAnimation_result1_2_upvr = any_new_result1_upvr:Add
			any_LoadAnimation_result1_2_upvr(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 902
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr (readonly)
					[3]: Weld_upvr (readonly)
					[4]: any_new_result1_upvr (readonly)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr then
					if Weld_upvr then
						Weld_upvr:Destroy()
					end
					any_new_result1_upvr:Clean()
				end
			end))
			any_LoadAnimation_result1_2_upvr = any_new_result1_upvr:Add
			any_LoadAnimation_result1_2_upvr(arg1._Root.Destroying:Connect(function() -- Line 909
				--[[ Upvalues[2]:
					[1]: Weld_upvr (readonly)
					[2]: any_new_result1_upvr (readonly)
				]]
				if Weld_upvr then
					Weld_upvr:Destroy()
				end
				any_new_result1_upvr:Clean()
			end))
		end
		any_LoadAnimation_result1_2_upvr = require(ReplicatedStorage_upvr.Client.Components.Pet.FaceRig)
		local any_GetComponent_result1_upvr_3 = module_9_upvr.GetComponent(arg1._Root, any_LoadAnimation_result1_2_upvr)
		if arg1._Age ~= "Egg" and any_GetComponent_result1_upvr_3 then
			any_GetComponent_result1_upvr_3:RenderEyes("Happy", 5)
			any_GetComponent_result1_upvr_3:RenderEyebrows("Neutral", 5)
			local var205_upvw
			var205_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 922
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr (readonly)
					[3]: any_GetComponent_result1_upvr_3 (readonly)
					[4]: var205_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr then
					any_GetComponent_result1_upvr_3:RenderEyes(nil, 5)
					any_GetComponent_result1_upvr_3:RenderEyebrows(nil, 5)
					var205_upvw:Disconnect()
				end
			end)
		end
	end;
	Swing = function(arg1, arg2) -- Line 931, Named "Swing"
		--[[ Upvalues[3]:
			[1]: module_7_upvr (readonly)
			[2]: ReplicatedStorage_upvr (readonly)
			[3]: module_9_upvr (readonly)
		]]
		local any_new_result1_upvr_3 = module_7_upvr.new()
		local AnimationController_4 = arg1._Root.Parent:FindFirstChild("AnimationController")
		local Weld_upvr_3 = Instance.new("Weld")
		Weld_upvr_3.Parent = arg1._Root
		Weld_upvr_3.Part0 = arg1._Root
		Weld_upvr_3.Part1 = arg2
		Weld_upvr_3.C0 = CFrame.new(0, -arg1._Root.Size.Y / 2, 0)
		if AnimationController_4 then
			local any_LoadAnimation_result1_9_upvr = AnimationController_4:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.Sit)
			any_LoadAnimation_result1_9_upvr.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_9_upvr:Play()
			local Seated_upvr_3 = arg1._Root:GetAttribute("Seated")
			any_new_result1_upvr_3:Add(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 949
				--[[ Upvalues[5]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_3 (readonly)
					[3]: Weld_upvr_3 (readonly)
					[4]: any_LoadAnimation_result1_9_upvr (readonly)
					[5]: any_new_result1_upvr_3 (readonly)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_3 then
					if Weld_upvr_3 then
						Weld_upvr_3:Destroy()
					end
					any_LoadAnimation_result1_9_upvr:Stop()
					any_new_result1_upvr_3:Clean()
				end
			end))
			any_new_result1_upvr_3:Add(arg1._Root.Destroying:Connect(function() -- Line 957
				--[[ Upvalues[3]:
					[1]: Weld_upvr_3 (readonly)
					[2]: any_LoadAnimation_result1_9_upvr (readonly)
					[3]: any_new_result1_upvr_3 (readonly)
				]]
				if Weld_upvr_3 then
					Weld_upvr_3:Destroy()
				end
				any_LoadAnimation_result1_9_upvr:Stop()
				any_new_result1_upvr_3:Clean()
			end))
		else
			any_LoadAnimation_result1_9_upvr = any_new_result1_upvr_3:Add
			any_LoadAnimation_result1_9_upvr(arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 963
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_3 (readonly)
					[3]: Weld_upvr_3 (readonly)
					[4]: any_new_result1_upvr_3 (readonly)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_3 then
					if Weld_upvr_3 then
						Weld_upvr_3:Destroy()
					end
					any_new_result1_upvr_3:Clean()
				end
			end))
			any_LoadAnimation_result1_9_upvr = any_new_result1_upvr_3:Add
			any_LoadAnimation_result1_9_upvr(arg1._Root.Destroying:Connect(function() -- Line 970
				--[[ Upvalues[2]:
					[1]: Weld_upvr_3 (readonly)
					[2]: any_new_result1_upvr_3 (readonly)
				]]
				if Weld_upvr_3 then
					Weld_upvr_3:Destroy()
				end
				any_new_result1_upvr_3:Clean()
			end))
		end
		any_LoadAnimation_result1_9_upvr = require(ReplicatedStorage_upvr.Client.Components.Pet.FaceRig)
		local any_GetComponent_result1_upvr = module_9_upvr.GetComponent(arg1._Root, any_LoadAnimation_result1_9_upvr)
		if arg1._Age ~= "Egg" and any_GetComponent_result1_upvr then
			any_GetComponent_result1_upvr:RenderEyes("Happy", 5)
			any_GetComponent_result1_upvr:RenderEyebrows("Neutral", 5)
			local var217_upvw
			var217_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 983
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_3 (readonly)
					[3]: any_GetComponent_result1_upvr (readonly)
					[4]: var217_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_3 then
					any_GetComponent_result1_upvr:RenderEyes(nil, 5)
					any_GetComponent_result1_upvr:RenderEyebrows(nil, 5)
					var217_upvw:Disconnect()
				end
			end)
		end
	end;
	MerryGoRound = function(arg1, arg2) -- Line 992, Named "MerryGoRound"
		--[[ Upvalues[3]:
			[1]: ReplicatedStorage_upvr (readonly)
			[2]: RunService_upvr (readonly)
			[3]: module_9_upvr (readonly)
		]]
		local AnimationController_5 = arg1._Root.Parent:FindFirstChild("AnimationController")
		arg1._AlignPosition.Responsiveness = 100
		arg1._AlignOrientation.Responsiveness = 100
		if AnimationController_5 then
			local any_LoadAnimation_result1_3_upvw = AnimationController_5:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.Sit)
			any_LoadAnimation_result1_3_upvw.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_3_upvw:Play()
			local Seated_upvr_4 = arg1._Root:GetAttribute("Seated")
			local any_Connect_result1_upvr = RunService_upvr.Heartbeat:Connect(function() -- Line 997
				--[[ Upvalues[2]:
					[1]: arg1 (readonly)
					[2]: arg2 (readonly)
				]]
				if not table.isfrozen(arg1) then
					arg1._AlignPosition.Position = (arg2.CFrame + arg2.CFrame.UpVector * arg1._Root.Size.Y / 2).Position
					arg1._AlignOrientation.CFrame = arg2.CFrame
				end
			end)
			local Responsiveness_upvr = arg1._AlignPosition.Responsiveness
			local Responsiveness_upvr_8 = arg1._AlignOrientation.Responsiveness
			local var226_upvw
			var226_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1015
				--[[ Upvalues[7]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_4 (readonly)
					[3]: any_Connect_result1_upvr (readonly)
					[4]: any_LoadAnimation_result1_3_upvw (readonly)
					[5]: Responsiveness_upvr (readonly)
					[6]: Responsiveness_upvr_8 (readonly)
					[7]: var226_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_4 then
					if any_Connect_result1_upvr then
						any_Connect_result1_upvr:Disconnect()
					end
					any_LoadAnimation_result1_3_upvw:Stop()
					arg1._AlignPosition.Responsiveness = Responsiveness_upvr
					arg1._AlignOrientation.Responsiveness = Responsiveness_upvr_8
					var226_upvw:Disconnect()
				end
			end)
		else
			any_LoadAnimation_result1_3_upvw = nil
			any_LoadAnimation_result1_3_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1026
				--[[ Upvalues[6]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_4 (readonly)
					[3]: any_Connect_result1_upvr (readonly)
					[4]: Responsiveness_upvr (readonly)
					[5]: Responsiveness_upvr_8 (readonly)
					[6]: any_LoadAnimation_result1_3_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_4 then
					if any_Connect_result1_upvr then
						any_Connect_result1_upvr:Disconnect()
					end
					arg1._AlignPosition.Responsiveness = Responsiveness_upvr
					arg1._AlignOrientation.Responsiveness = Responsiveness_upvr_8
					any_LoadAnimation_result1_3_upvw:Disconnect()
				end
			end)
		end
		local any_GetComponent_result1_upvr_2 = module_9_upvr.GetComponent(arg1._Root, require(ReplicatedStorage_upvr.Client.Components.Pet.FaceRig))
		if arg1._Age ~= "Egg" and any_GetComponent_result1_upvr_2 then
			any_GetComponent_result1_upvr_2:RenderEyes("Happy", 5)
			any_GetComponent_result1_upvr_2:RenderEyebrows("Neutral", 5)
			local var230_upvw
			var230_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1044
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_4 (readonly)
					[3]: any_GetComponent_result1_upvr_2 (readonly)
					[4]: var230_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_4 then
					any_GetComponent_result1_upvr_2:RenderEyes(nil, 5)
					any_GetComponent_result1_upvr_2:RenderEyebrows(nil, 5)
					var230_upvw:Disconnect()
				end
			end)
		end
	end;
	Trampoline = function(arg1, arg2) -- Line 1053, Named "Trampoline"
		--[[ Upvalues[2]:
			[1]: ReplicatedStorage_upvr (readonly)
			[2]: module_9_upvr (readonly)
		]]
		local AnimationController_3 = arg1._Root.Parent:FindFirstChild("AnimationController")
		if AnimationController_3 then
			local any_LoadAnimation_result1_6_upvw = AnimationController_3:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.Trampoline)
			any_LoadAnimation_result1_6_upvw.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_6_upvw:Play()
			arg1._AlignPosition.Responsiveness = 100
			arg1._AlignOrientation.Responsiveness = 100
			local Seated_upvr_5 = arg1._Root:GetAttribute("Seated")
			local Responsiveness_upvr_3 = arg1._AlignPosition.Responsiveness
			local Responsiveness_upvr_4 = arg1._AlignOrientation.Responsiveness
			local var237_upvw
			var237_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1069
				--[[ Upvalues[6]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_5 (readonly)
					[3]: any_LoadAnimation_result1_6_upvw (readonly)
					[4]: Responsiveness_upvr_3 (readonly)
					[5]: Responsiveness_upvr_4 (readonly)
					[6]: var237_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_5 then
					any_LoadAnimation_result1_6_upvw:Stop()
					arg1._AlignPosition.Responsiveness = Responsiveness_upvr_3
					arg1._AlignOrientation.Responsiveness = Responsiveness_upvr_4
					var237_upvw:Disconnect()
				end
			end)
		end
		Responsiveness_upvr_3 = require
		any_LoadAnimation_result1_6_upvw = ReplicatedStorage_upvr.Client.Components.Pet
		Responsiveness_upvr_4 = any_LoadAnimation_result1_6_upvw.FaceRig
		Responsiveness_upvr_3 = Responsiveness_upvr_3(Responsiveness_upvr_4)
		any_LoadAnimation_result1_6_upvw = module_9_upvr
		Responsiveness_upvr_4 = any_LoadAnimation_result1_6_upvw.GetComponent
		any_LoadAnimation_result1_6_upvw = arg1._Root
		Responsiveness_upvr_4 = Responsiveness_upvr_4(any_LoadAnimation_result1_6_upvw, Responsiveness_upvr_3)
		local var238_upvr = Responsiveness_upvr_4
		any_LoadAnimation_result1_6_upvw = arg1._Age
		if any_LoadAnimation_result1_6_upvw ~= "Egg" and var238_upvr then
			any_LoadAnimation_result1_6_upvw = var238_upvr:RenderEyes
			any_LoadAnimation_result1_6_upvw("Happy", 5)
			any_LoadAnimation_result1_6_upvw = var238_upvr:RenderEyebrows
			any_LoadAnimation_result1_6_upvw("Neutral", 5)
			any_LoadAnimation_result1_6_upvw = nil
			any_LoadAnimation_result1_6_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1086
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_5 (readonly)
					[3]: var238_upvr (readonly)
					[4]: any_LoadAnimation_result1_6_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_5 then
					var238_upvr:RenderEyes(nil, 5)
					var238_upvr:RenderEyebrows(nil, 5)
					any_LoadAnimation_result1_6_upvw:Disconnect()
				end
			end)
		end
	end;
	Fountain = function(arg1, arg2) -- Line 1095, Named "Fountain"
		--[[ Upvalues[2]:
			[1]: ReplicatedStorage_upvr (readonly)
			[2]: module_9_upvr (readonly)
		]]
		local AnimationController = arg1._Root.Parent:FindFirstChild("AnimationController")
		if AnimationController then
			if arg1._Root:FindFirstChild("main2", true) then
				arg1._AlignPosition.Position = (arg2.CFrame + arg2.CFrame.UpVector * arg1._Root.Size.Y * 0.9 + arg2.CFrame.LookVector * arg1._Root.Size.Y * 0.5).Position
			end
			local any_LoadAnimation_result1_upvw = AnimationController:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.WaterFloat)
			any_LoadAnimation_result1_upvw.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_upvw:Play()
			arg1._AlignPosition.Responsiveness = 100
			arg1._AlignOrientation.Responsiveness = 100
			local Seated_upvr_7 = arg1._Root:GetAttribute("Seated")
			local Responsiveness_upvr_6 = arg1._AlignPosition.Responsiveness
			local Responsiveness_upvr_2 = arg1._AlignOrientation.Responsiveness
			local var246_upvw
			var246_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1115
				--[[ Upvalues[6]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_7 (readonly)
					[3]: any_LoadAnimation_result1_upvw (readonly)
					[4]: Responsiveness_upvr_6 (readonly)
					[5]: Responsiveness_upvr_2 (readonly)
					[6]: var246_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_7 then
					any_LoadAnimation_result1_upvw:Stop()
					arg1._AlignPosition.Responsiveness = Responsiveness_upvr_6
					arg1._AlignOrientation.Responsiveness = Responsiveness_upvr_2
					var246_upvw:Disconnect()
				end
			end)
		end
		Responsiveness_upvr_6 = require
		any_LoadAnimation_result1_upvw = ReplicatedStorage_upvr.Client.Components.Pet
		Responsiveness_upvr_2 = any_LoadAnimation_result1_upvw.FaceRig
		Responsiveness_upvr_6 = Responsiveness_upvr_6(Responsiveness_upvr_2)
		any_LoadAnimation_result1_upvw = module_9_upvr
		Responsiveness_upvr_2 = any_LoadAnimation_result1_upvw.GetComponent
		any_LoadAnimation_result1_upvw = arg1._Root
		Responsiveness_upvr_2 = Responsiveness_upvr_2(any_LoadAnimation_result1_upvw, Responsiveness_upvr_6)
		local var247_upvr = Responsiveness_upvr_2
		any_LoadAnimation_result1_upvw = arg1._Age
		if any_LoadAnimation_result1_upvw ~= "Egg" and var247_upvr then
			any_LoadAnimation_result1_upvw = var247_upvr:RenderEyes
			any_LoadAnimation_result1_upvw("Happy", 5)
			any_LoadAnimation_result1_upvw = var247_upvr:RenderEyebrows
			any_LoadAnimation_result1_upvw("Neutral", 5)
			any_LoadAnimation_result1_upvw = nil
			any_LoadAnimation_result1_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1132
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_7 (readonly)
					[3]: var247_upvr (readonly)
					[4]: any_LoadAnimation_result1_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_7 then
					var247_upvr:RenderEyes(nil, 5)
					var247_upvr:RenderEyebrows(nil, 5)
					any_LoadAnimation_result1_upvw:Disconnect()
				end
			end)
		end
	end;
	Chair = function(arg1, arg2) -- Line 1141, Named "Chair"
		--[[ Upvalues[1]:
			[1]: ReplicatedStorage_upvr (readonly)
		]]
		local AnimationController_2 = arg1._Root.Parent:FindFirstChild("AnimationController")
		if AnimationController_2 then
			local any_LoadAnimation_result1_upvr = AnimationController_2:LoadAnimation(ReplicatedStorage_upvr.Assets.PetAnimations.Sit)
			any_LoadAnimation_result1_upvr.Priority = Enum.AnimationPriority.Action4
			any_LoadAnimation_result1_upvr:Play()
			local Seated_upvr_2 = arg1._Root:GetAttribute("Seated")
			local var253_upvw
			var253_upvw = arg1._Root:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1151
				--[[ Upvalues[4]:
					[1]: arg1 (readonly)
					[2]: Seated_upvr_2 (readonly)
					[3]: any_LoadAnimation_result1_upvr (readonly)
					[4]: var253_upvw (read and write)
				]]
				if arg1._Root:GetAttribute("Seated") ~= Seated_upvr_2 then
					any_LoadAnimation_result1_upvr:Stop()
					var253_upvw:Disconnect()
				end
			end)
		end
	end;
}
function module_8_upvr.SeatLoadingScene(arg1, arg2, arg3, arg4) -- Line 1162
	--[[ Upvalues[2]:
		[1]: clone_28_upvr (readonly)
		[2]: RunService_upvr (readonly)
	]]
	if table.isfrozen(arg2) then
	else
		local _Root_5_upvr = arg2._Root
		arg2:SetState("Transitional")
		arg2._isInteracting = false
		_Root_5_upvr.Anchored = true
		if arg2._WalkAnimation then
			arg2._WalkAnimation:Stop()
		end
		local var255_upvr = arg3.CFrame * CFrame.new(0, arg3.Size.Y / 2 + arg2._PetSize.Y / 2, 0)
		local Position_4_upvr = _Root_5_upvr.Position
		local Position_7_upvr = var255_upvr.Position
		local var258 = (Position_4_upvr + Position_7_upvr) / 2
		local clone_22 = clone_28_upvr:Clone()
		clone_22.Parent = _Root_5_upvr
		clone_22:Destroy()
		local tick_result1_upvr = tick()
		local vector3_upvr = Vector3.new(var258.X, var258.Y + 20, var258.Z)
		local _PetRotationOffset_4_upvr = arg2._PetRotationOffset
		local _PetRotationY_upvr_2 = arg2._PetRotationY
		task.spawn(function() -- Line 1197
			--[[ Upvalues[10]:
				[1]: RunService_upvr (copied, readonly)
				[2]: tick_result1_upvr (readonly)
				[3]: arg2 (readonly)
				[4]: Position_4_upvr (readonly)
				[5]: vector3_upvr (readonly)
				[6]: Position_7_upvr (readonly)
				[7]: _Root_5_upvr (readonly)
				[8]: _PetRotationOffset_4_upvr (readonly)
				[9]: _PetRotationY_upvr_2 (readonly)
				[10]: var255_upvr (readonly)
			]]
			local var266_upvw
			var266_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1200
				--[[ Upvalues[9]:
					[1]: tick_result1_upvr (copied, readonly)
					[2]: arg2 (copied, readonly)
					[3]: var266_upvw (read and write)
					[4]: Position_4_upvr (copied, readonly)
					[5]: vector3_upvr (copied, readonly)
					[6]: Position_7_upvr (copied, readonly)
					[7]: _Root_5_upvr (copied, readonly)
					[8]: _PetRotationOffset_4_upvr (copied, readonly)
					[9]: _PetRotationY_upvr_2 (copied, readonly)
				]]
				local var267 = (tick() - tick_result1_upvr) * 2
				if 1 <= var267 or table.isfrozen(arg2) then
					var266_upvw:Disconnect()
					var266_upvw = nil
				else
					_Root_5_upvr.Parent:PivotTo(CFrame.new((1 - var267) * (1 - var267) * Position_4_upvr + 2 * (1 - var267) * var267 * vector3_upvr + var267 * var267 * Position_7_upvr) * _PetRotationOffset_4_upvr * CFrame.Angles((math.pi/2), math.rad(-20 + _PetRotationY_upvr_2), (math.pi/2)))
				end
			end)
			repeat
				task.wait()
			until var266_upvw == nil
			if table.isfrozen(arg2) then
			else
				_Root_5_upvr.Parent:PivotTo(var255_upvr)
			end
		end)
	end
end
local module_4_upvr = require(ReplicatedStorage_upvr:WaitForChild("Remotes"))
function module_8_upvr.Seat(arg1, arg2, arg3, arg4) -- Line 1224
	--[[ Upvalues[7]:
		[1]: any_new_result1_upvr_4 (readonly)
		[2]: module_7_upvr (readonly)
		[3]: RunService_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
		[5]: module_4_upvr (readonly)
		[6]: clone_28_upvr (readonly)
		[7]: tbl_upvr_3 (readonly)
	]]
	local var269_upvr
	if arg2._Player ~= game.Players.LocalPlayer then
		var269_upvr = false
	else
		var269_upvr = true
	end
	local _UID_upvr = arg2._UID
	if var269_upvr then
		any_new_result1_upvr_4:InvokeServer({_UID_upvr, `Seat_{arg4}_{arg3:GetAttribute("SeatID")}`})
	end
	local _Root_3_upvr = arg2._Root
	local any_new_result1_upvr_2 = module_7_upvr.new()
	local function Clean() -- Line 1235
		--[[ Upvalues[5]:
			[1]: var269_upvr (readonly)
			[2]: any_new_result1_upvr_4 (copied, readonly)
			[3]: _UID_upvr (readonly)
			[4]: arg2 (readonly)
			[5]: any_new_result1_upvr_2 (readonly)
		]]
		if var269_upvr then
			any_new_result1_upvr_4:InvokeServer({_UID_upvr, "Stop"})
		end
		if not table.isfrozen(arg2) then
			arg2:SetState("Idle")
			arg2._isInteracting = false
		end
		any_new_result1_upvr_2:Clean()
	end
	if arg2._Player == game.Players.LocalPlayer then
		local var276_upvw = false
		any_new_result1_upvr_2:Add(RunService_upvr.Heartbeat:Connect(function() -- Line 1251
			--[[ Upvalues[5]:
				[1]: var276_upvw (read and write)
				[2]: LocalPlayer_upvr (copied, readonly)
				[3]: arg3 (readonly)
				[4]: module_4_upvr (copied, readonly)
				[5]: arg2 (readonly)
			]]
			if not var276_upvw and 72 < LocalPlayer_upvr:DistanceFromCharacter(arg3.Position) then
				var276_upvw = true
				module_4_upvr.Interaction_Chair:InvokeServer({
					Pet = arg2._Root;
				})
			end
		end))
	end
	any_new_result1_upvr_2:Add(_Root_3_upvr.Destroying:Connect(function() -- Line 1267
		--[[ Upvalues[1]:
			[1]: Clean (readonly)
		]]
		Clean()
	end))
	any_new_result1_upvr_2:Add(_Root_3_upvr:GetAttributeChangedSignal("Seated"):Connect(function() -- Line 1272
		--[[ Upvalues[2]:
			[1]: _Root_3_upvr (readonly)
			[2]: Clean (readonly)
		]]
		if not _Root_3_upvr:GetAttribute("Seated") then
			Clean()
		end
	end))
	if arg2._WalkAnimation then
		arg2._WalkAnimation:Stop()
	end
	local Position_12_upvr = _Root_3_upvr.Position
	local Position_11_upvr = (arg3.CFrame + arg3.CFrame.UpVector * _Root_3_upvr.Size.Y / 2).Position
	local var282 = (Position_12_upvr + Position_11_upvr) / 2
	local clone_6 = clone_28_upvr:Clone()
	clone_6.Parent = _Root_3_upvr
	clone_6:Destroy()
	local tick_result1_upvr_3 = tick()
	local vector3_upvr_2 = Vector3.new(var282.X, var282.Y + 20, var282.Z)
	local _PetRotationOffset_3_upvr = arg2._PetRotationOffset
	local _PetRotationY_upvr_3 = arg2._PetRotationY
	task.spawn(function() -- Line 1301
		--[[ Upvalues[12]:
			[1]: arg2 (readonly)
			[2]: RunService_upvr (copied, readonly)
			[3]: tick_result1_upvr_3 (readonly)
			[4]: Position_12_upvr (readonly)
			[5]: vector3_upvr_2 (readonly)
			[6]: Position_11_upvr (readonly)
			[7]: _PetRotationOffset_3_upvr (readonly)
			[8]: _PetRotationY_upvr_3 (readonly)
			[9]: _Root_3_upvr (readonly)
			[10]: arg3 (readonly)
			[11]: arg4 (readonly)
			[12]: tbl_upvr_3 (copied, readonly)
		]]
		local var290_upvw
		var290_upvw = RunService_upvr.Heartbeat:Connect(function() -- Line 1305
			--[[ Upvalues[8]:
				[1]: tick_result1_upvr_3 (copied, readonly)
				[2]: arg2 (copied, readonly)
				[3]: var290_upvw (read and write)
				[4]: Position_12_upvr (copied, readonly)
				[5]: vector3_upvr_2 (copied, readonly)
				[6]: Position_11_upvr (copied, readonly)
				[7]: _PetRotationOffset_3_upvr (copied, readonly)
				[8]: _PetRotationY_upvr_3 (copied, readonly)
			]]
			local var291 = (tick() - tick_result1_upvr_3) * 2
			if 1 <= var291 or table.isfrozen(arg2) then
				var290_upvw:Disconnect()
				var290_upvw = nil
			else
				local var292 = (1 - var291) * (1 - var291) * Position_12_upvr + 2 * (1 - var291) * var291 * vector3_upvr_2 + var291 * var291 * Position_11_upvr
				arg2._AlignPosition.Responsiveness = 100
				arg2._AlignPosition.Position = var292
				arg2._AlignOrientation.CFrame = CFrame.new(var292) * _PetRotationOffset_3_upvr * CFrame.Angles((math.pi/2), math.rad(-20 + _PetRotationY_upvr_3), (math.pi/2))
			end
		end)
		repeat
			task.wait()
		until var290_upvw == nil
		if table.isfrozen(arg2) then
		else
			if not _Root_3_upvr or not _Root_3_upvr:GetAttribute("Seated") then return end
			arg2._AlignPosition.Responsiveness = arg2._AlignPosition.Responsiveness
			arg2._AlignPosition.Position = (arg3.CFrame + arg3.CFrame.UpVector * _Root_3_upvr.Size.Y / 2).Position
			arg2._AlignOrientation.CFrame = arg3.CFrame
			if arg4 and tbl_upvr_3[arg4] then
				tbl_upvr_3[arg4](arg2, arg3)
			end
		end
	end)
	arg2:SetState("Interacting")
	arg2._isInteracting = true
end
local module_6_upvr = require(ReplicatedStorage_upvr:WaitForChild("Client"):WaitForChild("Components"):WaitForChild("UI"):WaitForChild("SoundManager"))
function module_8_upvr.Clean(arg1) -- Line 1341
	--[[ Upvalues[2]:
		[1]: module_8_upvr (readonly)
		[2]: module_6_upvr (readonly)
	]]
	if module_8_upvr.DestroyedConnection then
		module_8_upvr.DestroyedConnection:Disconnect()
	end
	if module_8_upvr.CurrentPet then
		module_8_upvr.CurrentPet._isInteracting = false
		module_6_upvr:Play("Selecting")
		module_8_upvr.isTweeningUI = true
		local _UI_upvr = module_8_upvr.CurrentPet._UI
		local _isTransitioning_upvr = module_8_upvr.CurrentPet._isTransitioning
		local _PetSize_upvr = module_8_upvr.CurrentPet._PetSize
		local _ChatUI_upvr = module_8_upvr.CurrentPet._ChatUI
		task.delay(0.1, function() -- Line 1359
			--[[ Upvalues[5]:
				[1]: _UI_upvr (readonly)
				[2]: _isTransitioning_upvr (readonly)
				[3]: _PetSize_upvr (readonly)
				[4]: _ChatUI_upvr (readonly)
				[5]: module_8_upvr (copied, readonly)
			]]
			if _UI_upvr and _UI_upvr:FindFirstChild("Frame") and not _isTransitioning_upvr then
				_UI_upvr.Enabled = true
				_UI_upvr.StudsOffset = Vector3.new(0, 2.5 + _PetSize_upvr.Y / 2, 0)
				_UI_upvr.Frame.InteractiveNameFrame.Visible = false
				_UI_upvr.Frame.NameLabel.Visible = true
			end
			if _ChatUI_upvr and not _isTransitioning_upvr then
				_ChatUI_upvr.Enabled = true
			end
			module_8_upvr.InteractiveUI.Adornee = nil
			module_8_upvr.InteractiveUI.Enabled = false
			module_8_upvr.isTweeningUI = false
		end)
	else
		_PetSize_upvr = module_8_upvr
		_UI_upvr = _PetSize_upvr.InteractiveUI
		_PetSize_upvr = nil
		_UI_upvr.Adornee = _PetSize_upvr
		_PetSize_upvr = module_8_upvr
		_UI_upvr = _PetSize_upvr.InteractiveUI
		_PetSize_upvr = false
		_UI_upvr.Enabled = _PetSize_upvr
	end
	_UI_upvr = module_8_upvr
	_PetSize_upvr = nil
	_UI_upvr.CurrentPet = _PetSize_upvr
end
function module_8_upvr.HatchPet(arg1, arg2) -- Line 1387
	--[[ Upvalues[2]:
		[1]: module_8_upvr (readonly)
		[2]: any_new_result1_upvr_4 (readonly)
	]]
	if module_8_upvr.PerformingAction then
	else
		if arg2._Age ~= "Egg" then return end
		if any_new_result1_upvr_4:InvokeServer({arg2._UID, "HatchNow"})[1] == "Success" then
			module_8_upvr:Clean()
			return
		end
	end
end
function module_8_upvr.Ride(arg1, arg2) -- Line 1402
	--[[ Upvalues[3]:
		[1]: module_8_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: any_new_result1_upvr_4 (readonly)
	]]
	if module_8_upvr.PerformingAction then
	else
		if arg2._Age == "Egg" then return end
		if arg2._Player == LocalPlayer_upvr and LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("Humanoid") then
			LocalPlayer_upvr.Character.Humanoid.Sit = false
		end
		if any_new_result1_upvr_4:InvokeServer({arg2._UID, "Ride"})[1] == "Success" then
			module_8_upvr.isRidingPet = true
			module_8_upvr:Clean()
			return
		end
	end
end
local State_upvr = require(ReplicatedStorage_upvr.Client.Components.UI.React.State)
function module_8_upvr.DressUp(arg1, arg2) -- Line 1420
	--[[ Upvalues[2]:
		[1]: module_8_upvr (readonly)
		[2]: State_upvr (readonly)
	]]
	if module_8_upvr.PerformingAction then
	else
		if arg2._Age == "Egg" then return end
		State_upvr.CustomizingPetGUID:Set(arg2._UID)
	end
end
function module_8_upvr.UpdateRide(arg1) -- Line 1430
	--[[ Upvalues[1]:
		[1]: module_8_upvr (readonly)
	]]
	if not module_8_upvr.isInteracting then
	else
		if not module_8_upvr.CurrentPet then return end
		if module_8_upvr.CurrentPet._Age == "Egg" then return end
		module_8_upvr.InteractiveUI.Buttons.BottomButtons.Ride.Locked.Visible = module_8_upvr.isRidingPet
	end
end
function module_8_upvr.ReplicateState(arg1, arg2, arg3, arg4, arg5) -- Line 1440
	--[[ Upvalues[1]:
		[1]: module_8_upvr (readonly)
	]]
	if arg3 == "Bathed" then
		module_8_upvr:Bathe(arg2, true)
	else
		if arg3 == "Fed" then
			module_8_upvr:Feed(arg2, true)
			return
		end
		if arg3 == "Hugged" then
			module_8_upvr:Love(arg2, true)
			return
		end
		if arg3 == "Seat" then
			if not arg4 then return end
			module_8_upvr:Seat(arg2, arg4, arg5)
		end
	end
end
return module_8_upvr

-- Decompiled with the Synapse Z Luau decompiler.
-- NOTE: Currently in beta! Not representative of final product.

local v0_0_ = game
local v0_2_ = "RunService"
v0_0_ = v0_0_:GetService(v0_2_)
local v0_1_ = require
local v0_3_ = script
v0_2_ = v0_3_.Client
v0_1_ = v0_1_(v0_2_)
v0_2_ = require
local v0_4_ = script
v0_3_ = v0_4_.PublicTypes
v0_2_ = v0_2_(v0_3_)
v0_3_ = require
local v0_5_ = script
v0_4_ = v0_5_.Server
v0_3_ = v0_3_(v0_4_)
v0_4_ = require
local v0_7_ = script
local v0_6_ = v0_7_.Studio
v0_5_ = v0_6_.MockBridge
v0_4_ = v0_4_(v0_5_)
v0_5_ = require
local v0_8_ = script
v0_7_ = v0_8_.Utilities
v0_6_ = v0_7_.NetworkUtils
v0_5_ = v0_5_(v0_6_)
v0_6_ = require
local v0_9_ = script
v0_8_ = v0_9_.Utilities
v0_7_ = v0_8_.Output
v0_6_ = v0_6_(v0_7_)
v0_7_ = require
local v0_10_ = script
v0_9_ = v0_10_.Utilities
v0_8_ = v0_9_.isEditMode
v0_7_ = v0_7_(v0_8_)
v0_8_ = require
v0_10_ = script
v0_9_ = v0_10_.version
v0_8_ = v0_8_(v0_9_)
v0_9_ = v0_0_:IsServer()
local spawn = task.spawn
local v0_11_ = function()
    local v1_0_ = v0_7_
    if not v1_0_ then
        v1_0_ = v0_9_
        if v1_0_ then
            local v1_1_ = v0_3_
            v1_0_ = v1_1_.start
            v1_0_()
            return
        end
        local v1_1_ = v0_1_
        v1_0_ = v1_1_.start
        v1_0_()
    end
end
spawn(v0_11_)
v0_10_ = {}
v0_11_ = v0_5_.ToHex
v0_10_.ToHex = v0_11_
v0_11_ = v0_5_.ToReadableHex
v0_10_.ToReadableHex = v0_11_
v0_11_ = v0_5_.FromHex
v0_10_.FromHex = v0_11_
v0_11_ = v0_5_.CreateUUID
v0_10_.CreateUUID = v0_11_
if v0_9_ then
    v0_11_ = v0_3_.makeIdentifier
else
    v0_11_ = v0_1_.makeIdentifier
end
v0_10_.ReferenceIdentifier = v0_11_
if v0_9_ then
    v0_11_ = v0_3_.deser
else
    v0_11_ = v0_1_.deser
end
v0_10_.Deserialize = v0_11_
if v0_9_ then
    v0_11_ = v0_3_.ser
else
    v0_11_ = v0_1_.ser
end
v0_10_.Serialize = v0_11_
local v0_12_ = v0_3_.playerContainers
v0_12_ = v0_12_()
v0_11_ = v0_12_.All
v0_10_.AllPlayers = v0_11_
v0_12_ = v0_3_.playerContainers
v0_12_ = v0_12_()
v0_11_ = v0_12_.Except
v0_10_.PlayersExcept = v0_11_
v0_12_ = v0_3_.playerContainers
v0_12_ = v0_12_()
v0_11_ = v0_12_.Players
v0_10_.Players = v0_11_
if v0_9_ then
    v0_11_ = v0_3_.makeBridge
else
    v0_11_ = v0_1_.makeBridge
end
v0_10_.ReferenceBridge = v0_11_
if v0_9_ then
    v0_11_ = v0_3_.makeBridge
else
    v0_11_ = nil
end
v0_10_.ServerBridge = v0_11_
if not v0_9_ then
    v0_11_ = v0_1_.makeBridge
else
    v0_11_ = nil
end
v0_10_.ClientBridge = v0_11_
v0_11_ = function(a1)
    local v2_2_ = v0_6_
    local v2_1_ = v2_2_.fatalAssert
    v2_2_ = v0_9_
    local v2_3_ = "Cannot call from client"
    v2_1_(v2_2_, v2_3_)
    v2_2_ = v0_3_
    v2_1_ = v2_2_.invalidPlayerhandler
    v2_2_ = a1
    v2_1_(v2_2_)
end
v0_10_.HandleInvalidPlayer = v0_11_
v0_10_.version = v0_8_
if v0_7_ then
    v0_11_ = v0_6_.log
    v0_12_ = "running BridgeNet2 in mock mode"
    v0_11_(v0_12_)
    v0_10_.ClientBridge = v0_4_
    v0_11_ = nil
    v0_10_.ServerBridge = v0_11_
    v0_10_.ReferenceBridge = v0_4_
    v0_11_ = function(a1)
        return a1
    end
    v0_10_.ReferenceIdentifier = v0_11_
    v0_11_ = function(a1)
        return a1
    end
    v0_10_.Serialize = v0_11_
    v0_11_ = function(a1)
        return a1
    end
    v0_10_.Deserialize = v0_11_
end
local freeze = table.freeze
v0_12_ = v0_10_
freeze(v0_12_)
return v0_10_

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2024-10-05 14:20:20
-- Luau version 6, Types version 3
-- Time taken: 0.001129 seconds

local ClientIdentifiers_upvr = require(script.ClientIdentifiers)
local isEditMode_upvr = require(script.Parent.Utilities.isEditMode)
local module = {}
local ClientProcess_upvr = require(script.ClientProcess)
function module.start() -- Line 12
	--[[ Upvalues[3]:
		[1]: isEditMode_upvr (readonly)
		[2]: ClientProcess_upvr (readonly)
		[3]: ClientIdentifiers_upvr (readonly)
	]]
	if isEditMode_upvr then
	else
		ClientProcess_upvr.start()
		ClientIdentifiers_upvr.start()
	end
end
function module.ser(arg1) -- Line 21
	--[[ Upvalues[2]:
		[1]: isEditMode_upvr (readonly)
		[2]: ClientIdentifiers_upvr (readonly)
	]]
	if isEditMode_upvr then
		return arg1
	end
	return ClientIdentifiers_upvr.ser(arg1)
end
function module.deser(arg1) -- Line 29
	--[[ Upvalues[2]:
		[1]: isEditMode_upvr (readonly)
		[2]: ClientIdentifiers_upvr (readonly)
	]]
	if isEditMode_upvr then
		return arg1
	end
	return ClientIdentifiers_upvr.deser(arg1)
end
function module.makeIdentifier(arg1, arg2) -- Line 37
	--[[ Upvalues[2]:
		[1]: isEditMode_upvr (readonly)
		[2]: ClientIdentifiers_upvr (readonly)
	]]
	if isEditMode_upvr then
		return arg1
	end
	return ClientIdentifiers_upvr.ref(arg1, arg2, false)
end
local tbl_upvr = {}
local ClientBridge_upvr = require(script.ClientBridge)
function module.makeBridge(arg1) -- Line 45
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: ClientBridge_upvr (readonly)
	]]
	if tbl_upvr[arg1] then
		return tbl_upvr[arg1]
	end
	local var6_result1 = ClientBridge_upvr(arg1)
	tbl_upvr[arg1] = var6_result1
	return var6_result1
end
return module




local MUI = loadstring(game:HttpGet("https://ui.api-x.site"))()

local ui = MUI:new("Raise a Rainbacorn")
local ex = ui:Sub("Extra")

local plrs = game:GetService("Players")
local ts = game:GetService("TweenService")
local vim = game:GetService("VirtualInputManager")
local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")

local lp = plrs.LocalPlayer
local dre = rs:WaitForChild("dataRemoteEvent")

local tn = {"Bush1", "Bush2", "Bush3", "Bush4"}
local sC, sM, sF = 20, 50, 100
local isM, cT = false, nil
local vUI = {}

local function tUI(h)
    for _, g in ipairs(lp.PlayerGui:GetChildren()) do
        if g:IsA("ScreenGui") and g.Enabled then
            vUI[g] = true
            g.Enabled = not h
        end
    end
    lp.PlayerGui:SetTopbarTransparency(h and 1 or 0)
end

local function fCam(t, c)
    local cam = workspace.CurrentCamera
    local tp = t:GetPrimaryPartCFrame().Position
    local cp = c.HumanoidRootPart.Position
    local o = (tp - cp).Unit * 5
    cam.CFrame = CFrame.new(cp + o, tp)
end

local function sClick()
    local cam = workspace.CurrentCamera
    local vs = cam.ViewportSize
    local cx, cy = vs.X / 2, vs.Y / 2
    vim:SendMouseButtonEvent(cx, cy, 0, true, game, 1)
    wait(0.1)
    vim:SendMouseButtonEvent(cx, cy, 0, false, game, 1)
end

local isAutoBush = false
local function mAA()
    if not isAutoBush or isM then return end
    
    local c = lp.Character
    if not c or not c:FindFirstChild("HumanoidRootPart") then return end
    local hrp = c.HumanoidRootPart

    local cT, cD = nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        for _, n in ipairs(tn) do
            if v:IsA("Model") and v.Name == n then
                local d = (v:GetPrimaryPartCFrame().Position - hrp.Position).Magnitude
                if d < cD then cT, cD = v, d end
            end
        end
    end
    
    if not cT or (cT == cT and cD < 3) then return end
    
    isM = true
    tUI(true)

    local s = cD < 50 and sC or (cD < 200 and sM or sF)
    local t = cD / s

    local tw = ts:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = cT:GetPrimaryPartCFrame()})
    tw:Play()
    tw.Completed:Wait()

    local cam = workspace.CurrentCamera
    local oCS, oCT, oCF = cam.CameraSubject, cam.CameraType, cam.CFrame
    cam.CameraType = Enum.CameraType.Scriptable

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = false
            pt.Transparency = 1
        end
    end

    local cD = false
    local cCon = uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            cD = true
        end
    end)

    local at = 0
    while not cD and at < 5 do
        fCam(cT, c)
        wait(0.5)
        sClick()
        wait(0.5)
        at = at + 1
        
        if not cD then
            local o = Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)).Unit * 2
            cam.CFrame = cam.CFrame * CFrame.new(o)
        end
    end

    cCon:Disconnect()

    for _, pt in pairs(c:GetDescendants()) do
        if pt:IsA("BasePart") then
            pt.CanCollide = true
            pt.Transparency = 0
        end
    end

    cam.CameraSubject, cam.CameraType, cam.CFrame = oCS, oCT, oCF
    
    tUI(false)
    isM = false
end

local function sItem(item)
    if item:IsA("ImageButton") and item.Visible then
        local sv = Instance.new("BoolValue")
        sv.Name = "IsActive"
        sv.Value = false
        sv.Parent = item

       local tb = Instance.new("TextButton")
tb.Name = "StatusButton"
tb.Size = UDim2.new(0.3, 0, 0.2, 0)
tb.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
tb.Text = "[OFF]"
tb.TextColor3 = Color3.new(1, 1, 1)
tb.TextStrokeTransparency = 0.8
tb.Parent = item
tb.Position = UDim2.new(0, 0, 0.3, 0)

        sv.Changed:Connect(function()
            tb.BackgroundColor3 = sv.Value and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            tb.Text = sv.Value and "[ON]" or "[OFF]"
        end)

        tb.MouseButton1Click:Connect(function()
            sv.Value = not sv.Value
        end)
    end
end

local pg = lp:WaitForChild("PlayerGui")
local ig = pg:WaitForChild("MainMenu"):WaitForChild("Root"):WaitForChild("Inventory"):WaitForChild("View")
local iG = ig:WaitForChild("Contents")

for _, item in pairs(iG:GetChildren()) do
    sItem(item)
end

iG.ChildAdded:Connect(sItem)

local act = {
    ["hug"] = "Hugged",
    ["bath"] = "Bathed",
    ["hungry"] = "Fed"
}

local ac = 15
local pat = {}
local ap = {}

local function sas(pn, a)
    local args = {
        [1] = {
            [1] = "PetInteractAction",
            [2] = "+",
            [3] = {
                [1] = "\1",
                [2] = {
                    [1] = pn,
                    [2] = a
                }
            },
            [4] = " "
        }
    }
    dre:FireServer(unpack(args))
end

local function dp(pn)
    local args = {
        [1] = {
            [1] = {
                ["GUID"] = pn,
                ["Category"] = "Pet"
            },
            [2] = "8"
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end

local function ep(pn)
    local args = {
        [1] = {
            [1] = {
                ["GUID"] = pn,
                ["Category"] = "Pet"
            },
            [2] = "8"
        }
    }
    game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end

local function fpn(i)
    while i and not i:IsA("Model") do
        i = i.Parent
    end
    return i and i:IsA("Model") and i.Name or "Unknown"
end

local function uap()
    ap = {}
    for _, item in pairs(iG:GetChildren()) do
        if item:IsA("ImageButton") and item.Visible then
            local sv = item:FindFirstChild("IsActive")
            if sv and sv.Value then
                table.insert(ap, item.Name)
            end
        end
    end
end

local function ipe(pn)
    local item = iG:FindFirstChild(pn)
    if not item then return false end
    
    local rotatedIcons = item:FindFirstChild("RotatedIcons")
    if not rotatedIcons then return false end
    
    local equippedIcon = rotatedIcons:FindFirstChild("EquippedIcon")
    return equippedIcon and equippedIcon:IsA("ImageLabel") and equippedIcon.Visible
end

local function fnuap()
    for _, pn in ipairs(ap) do
        if not ipe(pn) then
            return pn
        end
    end
end

spawn(function()
    local udn = lp.Name .. ":Debris"
    local ud = workspace:FindFirstChild(udn)
    if not ud then return end

    while true do
        wait(0.1)
        uap()

        for _, child in ipairs(ud:GetDescendants()) do
            if child.Name == "ChatList" then
                local cm = child:GetChildren()
                if #cm >= 2 then
                    local sc = cm[2]
                    if sc:IsA("Frame") then
                        local tl = sc:FindFirstChildOfClass("TextLabel")
                        if tl then
                            local mt = tl.Text:lower()
                            local cpn = fpn(sc)

                            for key, action in pairs(act) do
                                if mt:find(key) then
                                    local ct = tick()
                                    local lat = pat[cpn]

                                    if not lat or (ct - lat >= ac) then
                                        sas(cpn, action)
                                        pat[cpn] = ct
                                        ui:Notify("Pet Interaction: Waiting for server response", 3)
                                        wait(8)  

                                        local np = fnuap()
                                        if np then
                                            dp(cpn)
                                            ui:Notify("Rotating Pet: Deequipping Current Pet", 5)
                                            wait(5) 
                                            ep(np)
                                            ui:Notify("Rotating Pet: Equipping New", 5)
                                        else
                                            ui:Notify("No Pets Active: continue", 5)
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

spawn(function()
    while true do
        wait(0.3)
        local function aasa(a)
            for _, at in ipairs(a:GetPlayingAnimationTracks()) do
                at:AdjustSpeed(100)
            end
        end

        local function aaio(o)
            local a = o:FindFirstChildOfClass("Animator")
            if a then aasa(a) end
            for _, child in ipairs(o:GetChildren()) do
                aaio(child)
            end
        end

        aaio(workspace[lp.Name .. ":Debris"])
    end
end)

local isCollectingFlowers = false
ex:TBtn("Collect Flowers", function(b) 
    isCollectingFlowers = b
    while isCollectingFlowers do
        for _, h in ipairs(workspace.Activators:GetChildren()) do
            if h.Name == "Flower" and isCollectingFlowers then
                lp.Character.PrimaryPart.CFrame = h.Part.CFrame
                wait(0.5)
                fireproximityprompt(h.Part.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local isCollectingFeathers = false
ex:TBtn("Collect Magic Feathers", function(b) 
    isCollectingFeathers = b
    while isCollectingFeathers do
        for _, h in ipairs(workspace.Feathers:GetChildren()) do
            if h.Name == "Feather" and h:FindFirstChild("Root") and isCollectingFeathers then
                lp.Character.PrimaryPart.CFrame = h.Root.CFrame
                wait(0.5)
                fireproximityprompt(h.Root.ProximityPrompt)
                wait(0.2)
            end
        end
    end
end)

local isAutoClaimGift = false
ui:TBtn("Auto Claim Gift", function(b) 
    isAutoClaimGift = b
    while isAutoClaimGift do
        for i = 1, 9 do
            local args = {
                [1] = {
                    [1] = {
                        [1] = "\1",
                        [2] = "BERRIES_" .. i .. "00"
                    },
                    [2] = "="
                }
            }
            dre:FireServer(unpack(args))
            wait(1)
        end
    end
end)

ui:TBtn("Auto Bush Raiwb", function(b) 
    isAutoBush = b
    while isAutoBush do
        mAA()
        wait(1)
    end
end)

local isAutoEgg = false
ui:TBtn("Auto Egg Secret", function(b)
    isAutoEgg = b
    while isAutoEgg do
        local args = {
            [1] = {
                [1] = {
                    [1] = "\1",
                    [2] = "66111113-6A42-49B3-8F1E-2C5C5B646B57"
                },
                [2] = "K"
            }
        }
        dre:FireServer(unpack(args))
        wait(2)
    end
end)

ex:Btn("TP Secret Zone", function()
    lp.Character:MoveTo(Vector3.new(1356, 10, -3447))
    lp.Character.PrimaryPart.Anchored = true
    wait(3)
    lp.Character.PrimaryPart.Anchored = false
end)

ui:Notify("Auto Tasks Pet: Default Active", 5)

wait(0.7)
local is = ui:Sub("Info Script")
is:Txt("Version: 1.2")
is:Txt("Create: 20/07/24")
is:Txt("Update: 05/10/24")
is:Btn("Link YouTube", function()
   setclipboard("https://youtube.com/@onecreatorx") 
end)

is:Btn("Link Discord", function()
  setclipboard("https://discord.com/invite/UNJpdJx7c4")  
end)

lp.Idled:Connect(function()
    vim:CaptureController()
    vim:ClickButton2(Vector2.new())
end)