-- Script for educational purposes to demonstrate targeting and overlay capabilities in games.
-- This script simulates an aim assistance feature and visual enhancements (ESP) for educational and testing purposes only.

-- Global variable to store the currently targeted player
local targetedPlayer = nil

-- Boolean to toggle the general ESP functionality
local generalESPEnabled = false

-- Function to handle aiming logic; triggered by the Think hook
local function AimAssist()
    -- Check if the left ALT key (key code '64' for ALT) is pressed
    if input.IsKeyDown(KEY_LALT) then
        local localPlayer = LocalPlayer()
        local bestTarget = nil
        local smallestDistance = math.huge

        -- Iterate over all entities to find the nearest targetable player
        for _, ent in pairs(ents.GetAll()) do
            if ent ~= localPlayer and ent:IsPlayer() and ent:Health() > 0 then
                local screenPos = ent:GetPos():ToScreen()  -- Convert player position to screen coordinates
                local xDist = screenPos.x - ScrW() / 2
                local yDist = screenPos.y - ScrH() / 2
                local distance = math.sqrt(xDist^2 + yDist^2)  -- Calculate distance to crosshair

                -- Perform line-of-sight check
                local tr = util.TraceLine({
                    start = localPlayer:GetShootPos(),
                    endpos = ent:GetPos() + ent:OBBCenter(),
                    filter = function(check) return check == ent end
                })

                -- Select the closest target that is hit by the trace line
                if distance < smallestDistance and tr.Hit then
                    smallestDistance = distance
                    bestTarget = ent
                    targetedPlayer = ent
                end
            end
        end

        -- If a target is found, calculate the angle to the target
        if bestTarget then
            local aimPos = bestTarget:GetPos() + bestTarget:OBBCenter()
            local angleToTarget = (aimPos - localPlayer:GetShootPos()):Angle()

            -- Smoothly adjust the player's aim to the target
            if localPlayer:GetActiveWeapon():IsValid() then
                localPlayer:SetEyeAngles(LerpAngle(0.1, localPlayer:EyeAngles(), angleToTarget))
            end
        end
    end
end

-- Register the aim assist function to the "Think" hook
hook.Add("Think", "CustomAimbot", AimAssist)

-- Function to draw enhanced visual elements (ESP) for the targeted player
local function DrawTargetedPlayerESP()
    if input.IsKeyDown(KEY_LALT) and targetedPlayer then
        local pos = targetedPlayer:GetPos():ToScreen()
        draw.SimpleTextOutlined(targetedPlayer:Nick(), "TargetID", pos.x, pos.y - 20, Color(255, 33, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
        draw.SimpleTextOutlined(targetedPlayer:Health(), "TargetID", pos.x, pos.y - 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    end
end

-- Register the ESP drawing function to the "HUDPaint" hook
hook.Add("HUDPaint", "DrawESPForAimbot", DrawTargetedPlayerESP)

-- Console command to toggle the ESP functionality
concommand.Add("toggle_esp", function()
    generalESPEnabled = not generalESPEnabled
    print(generalESPEnabled and "ESP enabled" or "ESP disabled")
end)

-- Function to draw ESP boxes and health/name information for all players except the local player
local function DrawESPForAll()
    for _, ent in pairs(player.GetAll()) do
        if ent:Health() > 0 and not ent == LocalPlayer() then
            local min, max = ent:GetHitBoxBounds(0, 0)
            if min and max then
                local posMin = ent:LocalToWorld(min):ToScreen()
                local posMax = ent:LocalToWorld(max):ToScreen()

                -- Draw a box around the player
                surface.SetDrawColor(255, 0, 0, 255)
                surface.DrawLine(posMin.x, posMin.y, posMax.x, posMin.y)
                surface.DrawLine(posMax.x, posMin.y, posMax.x, posMax.y)
                surface.DrawLine(posMax.x, posMax.y, posMin.x, posMax.y)
                surface.DrawLine(posMin.x, posMax.y, posMin.x, posMin.y)

                -- Draw health and name above the player
                local posHead = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1")):ToScreen()
                draw.SimpleText(ent:Health() .. " HP", "Default", posHead.x, posHead.y - 20, Color(0, 255, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                draw.SimpleText(ent:GetName(), "Default", posHead.x, posHead.y - 35, Color(0, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end
    end
end

-- Conditionally execute the ESP drawing for all players based on the toggle state
hook.Add("HUDPaint", "DrawESP", function()
    if generalESPEnabled then
        DrawESPForAll()
    end
end)
