local name, addon = ...;

local function RGBPercToHex(r, g, b)
    r = r <= 1 and r >= 0 and r or 0
    g = g <= 1 and g >= 0 and g or 0
    b = b <= 1 and b >= 0 and b or 0
    return string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
end

local statLabelMap = {
    [CR_MASTERY] = function()
        local primaryTalentTree = GetSpecialization();
        if (primaryTalentTree) then
            local masterySpell, masterySpell2 = GetSpecializationMasterySpells(primaryTalentTree);
            if (masterySpell) then
                local name = GetSpellInfo(masterySpell);
                return name;
            end
        end
        return nil;
    end,
    [CR_CRIT_SPELL] = function()
        return format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_CRITICAL_STRIKE)
    end,
    [CR_VERSATILITY_DAMAGE_DONE] = function()
        return format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_VERSATILITY)
    end,
    [CR_HASTE_SPELL] = function()
        return format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_HASTE)
    end
}

local statEventMap = {
    [CR_MASTERY] = "OnTooltipSetSpell",
    [CR_CRIT_SPELL] = "OnShow",
    [CR_VERSATILITY_DAMAGE_DONE] = "OnShow",
    [CR_HASTE_SPELL] = "OnShow"
}

local patterns = {
    [CR_MASTERY] = "%s([,0-9]+) " .. STAT_MASTERY,
    [CR_CRIT_SPELL] = "%s([,0-9]+) " .. STAT_CRITICAL_STRIKE,
    [CR_VERSATILITY_DAMAGE_DONE] = "%s([,0-9]+) " .. STAT_VERSATILITY,
    [CR_HASTE_SPELL] = "%s([,0-9]+) " .. STAT_HASTE
}

function addon.tsv:OnTooltip(ev, tooltip, ...)
    if (addon.tsv.db.global.showStatTooltips) then
        local tt1 = GameTooltipTextLeft1;
        if (tt1) then
            local text = tt1:GetText();
            if (text) then
                for statId, labelGenerator in pairs(statLabelMap) do
                    if (statEventMap[statId] == ev) then
                        local label = labelGenerator();
                        if (label) then
                            label = label:gsub("%-", "%%-")
                            local s, e = text:find(label)
                            if (s and s <= 11) then
                                self:AddTrueStatValuesTooltip(tooltip, statId);
                            end
                        end
                    end
                end
            end
        end
    end
    if (addon.tsv.db.global.showItemTooltips and ev == "OnTooltipSetItem") then
        local name, link = tooltip:GetItem();

        if (name ~= nil and link ~= nil) then
            local isEquipped = IsEquippedItem(name);
            local itemString = select(3, string.find(link, "|H(.+)|h"));
            -- print(GetItemInfo(link));

            for i = 1, 20, 1 do
                local textleft = "GameTooltipTextLeft" .. tostring(i);
                if (_G[textleft] and _G[textleft].GetText) then
                    local text = _G[textleft]:GetText();
                    if (text and text ~= "") then
                        for statId, pattern in pairs(patterns) do
                            local amount = string.match(text, pattern);
                            if (amount) then
                                local s, e = string.find(text, pattern);
                                local trueAmount = self:GetTrueStatRatingAdded(statId, amount);
                                local r, g, b = addon.tsv.db.global.fontColor.r, addon.tsv.db.global.fontColor.g,
                                    addon.tsv.db.global.fontColor.b;
                                local hexStr = RGBPercToHex(r, g, b);

                                local trueText = text:sub(1, e) .. " |cff" .. hexStr .. "(" .. tostring(trueAmount) ..
                                                     ")|r" .. text:sub(e + 1);
                                _G[textleft]:SetText(trueText);

                            end
                        end
                    end
                end
            end

        end

        _G["FRM"] = tooltip;

    end
end

function addon.tsv:AddTrueStatValuesTooltip(tooltip, statId)
    local statInfo = addon.TrueStatInfo[statId]; 
    local pctLabel = (statInfo.bracketPenalty > 0) and ("-" .. tostring(statInfo.bracketPenalty * 100) .. "%") or ("0%");
    local barLabel =
        tostring(statInfo.bracketRating) .. "/" .. tostring(statInfo.bracketMaxRating) .. " [" .. pctLabel ..
            " penalty]";
    local r, g, b = addon.tsv.db.global.fontColor.r, addon.tsv.db.global.fontColor.g, addon.tsv.db.global.fontColor.b;

    -- barLabel = "|cff0000ff"..barLabel.."|r";
    local lostRating = (statInfo.baseRating - statInfo.trueRating);
    lostRating = math.floor(0.005 + 100 * lostRating) / 100;

    tooltip:AddDoubleLine("True Rating:", statInfo.trueRating, r, g, b, r, g, b);
    tooltip:AddDoubleLine("Lost Rating:", lostRating, r, g, b, r, g, b);
    GameTooltip_ShowProgressBar(tooltip, 0, statInfo.bracketMaxRating, statInfo.bracketRating, barLabel);

    local frames = tooltip.insertedFrames;
    local frames_n = #frames;
    local insertedFrame = frames[frames_n];

    if (insertedFrame and insertedFrame.Bar) then
        insertedFrame.Bar:SetStatusBarColor(r, g, b, 1);
    end

    tooltip:AddLine("\n");
    tooltip:Show();
end

--[[
	hooksecurefunc('PaperDollFrame_UpdateStats', function()
		if IsAddOnLoaded('DejaCharacterStats') then return end

		for _, Table in ipairs({_G.CharacterStatsPane.statsFramePool:EnumerateActive()}) do
			if type(Table) == 'table' then
				for statFrame in pairs(Table) do
					ColorizeStatPane(statFrame)
					if statFrame.Background:IsShown() then
						statFrame.leftGrad:Show()
						statFrame.rightGrad:Show()
					else
						statFrame.leftGrad:Hide()
						statFrame.rightGrad:Hide()
					end
				end
			end
		end
	end)

	function PaperDollFrame_SetLabelAndText(statFrame, label, text, isPercentage, numericValue)
		if ( statFrame.Label ) then
			statFrame.Label:SetText(format(STAT_FORMAT, label));
		end
		if ( isPercentage ) then
			text = format("%d%%", numericValue + 0.5);
		end
		statFrame.Value:SetText(text);
		statFrame.numericValue = numericValue;
	end
]]

