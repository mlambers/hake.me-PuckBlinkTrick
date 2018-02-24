local puckBlink = {}

puckBlink.optionEnable = Menu.AddOption({"Hero Specific", "Puck"}, "Enable", "Enable script.")
puckBlink.optionShowDirection = Menu.AddOption({"Hero Specific", "Puck"}, "Show My Direction", "Shows the line where Puck facing")
puckBlink.optionUnitKey = Menu.AddKeyOption({"Hero Specific", "Puck" }, "Blink key", Enum.ButtonCode.KEY_F)
puckBlink.font = Renderer.LoadFont("Tahoma", 40, Enum.FontWeight.EXTRABOLD)

function puckBlink.OnUpdate() 
    if not Menu.IsEnabled(puckBlink.optionEnable) then return end

    local myHero = Heroes.GetLocal()
	
    if not myHero or not Entity.IsAlive(myHero) then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_puck" then return end
	
	local item = NPC.GetItem(myHero, "item_blink", true)
	if not item then return end
	local myPos = Entity.GetOrigin(myHero)
	local angle = Entity.GetRotation(myHero)
    local angleOffset = Angle(0, 45, 0)
	angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
	local x,y,z = angle:GetVectors()
    local direction = x + y + z
    local name = NPC.GetUnitName(myHero)
    direction:SetZ(0)
    direction:Normalize()
   
    direction:Scale(1200)
   

    local origin = NPC.GetAbsOrigin(myHero)
	asd = origin + direction
	local x, y = Renderer.WorldToScreen(asd)
	if Menu.IsKeyDown(puckBlink.optionUnitKey) then
		Ability.CastPosition(item, asd)
		return
	end
	
end

function puckBlink.OnDraw() 
    if not Menu.IsEnabled(puckBlink.optionEnable) then return end
	if not Menu.IsEnabled(puckBlink.optionShowDirection) then return end
    local myHero = Heroes.GetLocal()

    if not myHero or not Entity.IsAlive(myHero) then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_puck" then return end
	
	local myPos = Entity.GetOrigin(myHero)
	local angle = Entity.GetRotation(myHero)
    local angleOffset = Angle(0, 45, 0)
	angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
	local x,y,z = angle:GetVectors()
	local x1,y1, visible1 =  Renderer.WorldToScreen(myPos)
    local direction = x + y + z
    local name = NPC.GetUnitName(myHero)
    direction:SetZ(0)
    direction:Normalize()
   
    direction:Scale(1200)
   

    local origin = NPC.GetAbsOrigin(myHero)
	asd = origin + direction
	local x, y = Renderer.WorldToScreen(asd)
    Renderer.SetDrawColor(255, 255, 255)
    --Renderer.DrawTextCenteredX(puckBlink.font, x+5, y+5, "x", 0)
	
	if not visible1 then return end
	
	Renderer.DrawLine(x1, y1, x, y)
end

return puckBlink