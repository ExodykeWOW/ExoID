local select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc =
    select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc

local function addLine(self,id,isItem)
    if isItem then
        self:AddDoubleLine("|cffFFFF00ID|r |cffFF4500предмета|r:","|cffffffff"..id)  -----|cffFFFF00ID|r |cffFF4500нпц|r: 
    else
        self:AddDoubleLine("|cffFFFF00ID|r |cffFF4500спелла:|r","|cffffffff"..id)
    end
    self:Show()
end 

----------------------------------------====== БАФЫ/ДЕБАФЫ/АУРЫ/СПЕЛЛЫ ======----------------------------------------

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
    local id = select(11,UnitBuff(...))
    if id then addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
    local id = select(11,UnitDebuff(...))
    if id then addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
    local id = select(11,UnitAura(...))
    if id then addLine(self,id) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
    local id = select(3,self:GetSpell())
    if id then addLine(self,id) end
end)

----------------------------------------====== ПРЕДМЕТЫ ======----------------------------------------

hooksecurefunc("SetItemRef", function(link, ...)
    local id = tonumber(link:match("spell:(%d+)"))
    if id then addLine(ItemRefTooltip,id) end
end)

local function attachItemTooltip(self)
    local link = select(2,self:GetItem())
    if not link then return end
    local id = select(3,strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
    if id then addLine(self,id,true) end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)



----------------------------------------====== НПЦ ======----------------------------------------

local function idnps(npsID, ...)
    local sName, iUnit = npsID:GetUnit()
    local isPlayer = UnitIsPlayer("mouseover")
    if (iUnit == "mouseover") then
        if isPlayer == nil then
            npsID:AddLine("|cffFFFF00ID|r |cffFF4500нпц|r: " .. tonumber(string.sub(UnitGUID("mouseover"), 9, 12), 16))
        end
    end
end
GameTooltip:HookScript("OnTooltipSetUnit", idnps)

----------------------------------------====== GUID ПЕРСОНАЖЕЙ ======----------------------------------------

local function GUIDPlayer(PlayerGUID, ...)
    local sName, iUnit = PlayerGUID:GetUnit()
    local isPlayer = UnitIsPlayer("mouseover")
    if (iUnit == "mouseover") then
        if isPlayer == 1 then
            PlayerGUID:AddLine("|cffFFFF00Guid|r |cffFF4500персонажа|r: " .. tonumber(string.sub(UnitGUID("mouseover"), 9, 18), 16))
        end
    end
end
GameTooltip:HookScript("OnTooltipSetUnit", GUIDPlayer)  

