local name, addon = ...;


--[[----------------------------------------------------------------------------
	Stat conversion factors (data taken from simc)
	https:--github.com/simulationcraft/simc/blob/shadowlands/engine/dbc/generated/sc_scale_data.inc
------------------------------------------------------------------------------]]
local hst_cnv = {
    2.581816727,	2.581816727,	2.581816727,	2.581816727,	2.581816727,	--    5
    2.581816727,	2.581816727,	2.581816727,	2.581816727,	2.581816727,	--   10
    2.581816727,	2.710907563,	2.8399984,	2.969089236,	3.098180072,	--   15
    3.227270909,	3.356361745,	3.485452581,	3.614543418,	3.743634254,	--   20
    3.87272509,	4.001815927,	4.130906763,	4.259997599,	4.389088436,	--   25
    4.521990033,	4.660182049,	4.803902063,	4.953399496,	5.10893624,	--   30
    5.27078734,	5.439241703,	5.614602856,	5.797189741,	5.987337564,	--   35
    6.185398691,	6.391743591,	6.606761845,	6.830863207,	7.064478729,	--   40
    7.327766523,	7.600866855,	7.88414543,	8.177981584,	8.48276879,	--   45
    8.798915185,	9.126844118,	9.466994715,	9.819822469,	10.18579985,	--   50
    11.24564228,	12.41576236,	13.70763458,	15.13392736,	16.7086273,	--   55
    18.44717631,	20.36662305,	22.4857901,	24.82545855,	33.409091,	--   60
    38.93984445,	45.38619401,	52.89971328,	61.65706833,	71.86417165,	--   65
    83.76102378,	97.62735649,	113.7892101,	132.6265998,	209.9999998,	--   70
  };
	
local crt_cnv =     {
    2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381,	--    5
    2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381,	--   10
    2.704760381,	2.8399984,	2.975236419,	3.110474438,	3.245712457,	--   15
    3.380950476,	3.516188495,	3.651426514,	3.786664533,	3.921902552,	--   20
    4.057140571,	4.19237859,	4.327616609,	4.462854628,	4.598092647,	--   25
    4.737322892,	4.88209548,	5.032659304,	5.189275662,	5.352218918,	--   30
    5.521777213,	5.698253213,	5.881964896,	6.073246395,	6.272448877,	--   35
    6.479941485,	6.696112333,	6.921369552,	7.156142407,	7.400882478,	--   40
    7.676707786,	7.962812896,	8.259580927,	8.567409279,	8.886710161,	--   45
    9.217911147,	9.561455743,	9.917803988,	10.28743306,	10.67083793,	--   50
    11.78114906,	13.00698914,	14.36037908,	15.85459057,	17.50427622,	--   55
    19.32561328,	21.33646224,	23.55654201,	26.00762324,	35.00000009,	--   60
    40.79412275,	47.54744134,	55.41874725,	64.59311921,	75.28627506,	--   65
    87.74964396,	102.2762782,	119.2077439,	138.9421522,	219.9999998,	--   70
  };

local mst_cnv =     {
    2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381,	--    5
    2.704760381,	2.704760381,	2.704760381,	2.704760381,	2.704760381,	--   10
    2.704760381,	2.8399984,	2.975236419,	3.110474438,	3.245712457,	--   15
    3.380950476,	3.516188495,	3.651426514,	3.786664533,	3.921902552,	--   20
    4.057140571,	4.19237859,	4.327616609,	4.462854628,	4.598092647,	--   25
    4.737322892,	4.88209548,	5.032659304,	5.189275662,	5.352218918,	--   30
    5.521777213,	5.698253213,	5.881964896,	6.073246395,	6.272448877,	--   35
    6.479941485,	6.696112333,	6.921369552,	7.156142407,	7.400882478,	--   40
    7.676707786,	7.962812896,	8.259580927,	8.567409279,	8.886710161,	--   45
    9.217911147,	9.561455743,	9.917803988,	10.28743306,	10.67083793,	--   50
    11.78114906,	13.00698914,	14.36037908,	15.85459057,	17.50427622,	--   55
    19.32561328,	21.33646224,	23.55654201,	26.00762324,	35.00000009,	--   60
    40.79412275,	47.54744134,	55.41874725,	64.59311921,	75.28627506,	--   65
    87.74964396,	102.2762782,	119.2077439,	138.9421522,	219.9999998,	--   70
  };

local vrs_cnv =     {
    3.073591342,	3.073591342,	3.073591342,	3.073591342,	3.073591342,	--    5
    3.073591342,	3.073591342,	3.073591342,	3.073591342,	3.073591342,	--   10
    3.073591342,	3.227270909,	3.380950476,	3.534630043,	3.68830961,	--   15
    3.841989177,	3.995668744,	4.149348311,	4.303027878,	4.456707445,	--   20
    4.610387012,	4.764066579,	4.917746146,	5.071425713,	5.225105281,	--   25
    5.383321468,	5.547835773,	5.718931028,	5.896904161,	6.082066952,	--   30
    6.274746833,	6.475287742,	6.684051019,	6.901416358,	7.127782814,	--   35
    7.36356987,	7.609218561,	7.865192673,	8.131980008,	8.410093725,	--   40
    8.723531575,	9.048651018,	9.385887417,	9.735692362,	10.09853427,	--   45
    10.47489903,	10.86529062,	11.2702318,	11.69026484,	12.1259522,	--   50
    13.38766938,	14.78066948,	16.31861259,	18.01658019,	19.89122298,	--   55
    21.96092418,	24.24597982,	26.76879773,	29.55411732,	39.77272738,	--   60
    46.35695768,	54.03118334,	62.97584915,	73.40127183,	85.5525853,	--   65
    99.7155045,	116.2230434,	135.4633454,	157.8888093,	249.9999998,	--   70
  };

local lee_cnv =     {
    1.622856228,	1.622856228,	1.622856228,	1.622856228,	1.622856228,	--    5
    1.622856228,	1.622856228,	1.622856228,	1.622856228,	1.622856228,	--   10
    1.622856228,	1.70399904,	1.785141851,	1.866284663,	1.947427474,	--   15
    2.028570285,	2.109713097,	2.190855908,	2.27199872,	2.353141531,	--   20
    2.434284342,	2.515427154,	2.596569965,	2.677712777,	2.758855588,	--   25
    2.842393735,	2.929257288,	3.019595583,	3.113565397,	3.211331351,	--   30
    3.313066328,	3.418951928,	3.529178938,	3.643947837,	3.763469326,	--   35
    3.887964891,	4.0176674,	4.152821731,	4.293685444,	4.440529487,	--   40
    4.606024672,	4.777687737,	4.955748556,	5.140445567,	5.332026097,	--   45
    5.530746688,	5.736873446,	5.950682393,	6.172459837,	6.40250276,	--   50
    7.068689434,	7.804193483,	8.616227447,	9.51275434,	10.50256573,	--   55
    11.59536797,	12.80187735,	14.1339252,	15.60457394,	21.00000006,	--   60
    24.47647365,	28.52846481,	33.25124835,	38.75587152,	45.17176504,	--   65
    52.64978637,	61.36576694,	71.52464636,	83.36529132,	131.9999999,	--   70
  };

function addon.tsv:SetupConversionFactors()
	local level = UnitLevel("Player");
    level = math.max(level,1);
    
	addon.CritConv 		= crt_cnv[level];
	addon.HasteConv 	= hst_cnv[level];
	addon.VersConv 		= vrs_cnv[level];
	addon.MasteryConv 	= mst_cnv[level];
	--addon.LeechConv		= lee_cnv[level]*100;
end

local statIdMap = {
    [CR_CRIT_SPELL]={["conversionFactor"]="CritConv",["rating"]="BaseCritRating"},
    [CR_HASTE_SPELL]={["conversionFactor"]="HasteConv",["rating"]="BaseHasteRating"},
    [CR_MASTERY]={["conversionFactor"]="MasteryConv",["rating"]="BaseMasteryRating"},
    [CR_VERSATILITY_DAMAGE_DONE]={["conversionFactor"]="VersConv",["rating"]="BaseVersatilityRating"}
}


--[[
    https://www.wowhead.com/news=318435/update-on-diminishing-returns-for-secondary-stats-in-shadowlands-new-thresholds-

    From 0 to 30%, there's no penalty.
    From 30% to 39%, there's a 10% penalty.
    From 39% to 47%, there's a 20% penalty.
    From 47% to 54%, there's a 30% penalty.
    From 54% to 66%, there's a 40% penalty.
    From 66% to 126%, there's a 50% penalty.
    You can't get more than 126% from gear rating.
]]
addon.tsv.StatBrackets = {
    {["size"]=30,["penalty"]=0},
    {["size"]=9,["penalty"]=0.1},
    {["size"]=8,["penalty"]=0.2},
    {["size"]=7,["penalty"]=0.3},
    {["size"]=12,["penalty"]=0.4},
    {["size"]=60,["penalty"]=0.5},
    {["size"]=60,["penalty"]=1.0},
    {["size"]=100000,["penalty"]=1.0},
}

--penatly is the % penalty currently
--trueRating is how much stat you effectively have after accounting for diminishes
--bracketRating is how far into the current bracket you are.
--bracketMaxRating is the total rating in your current bracket
function addon.tsv:GetStatDiminishBracket(statId,amount)
    local stat = statIdMap[statId];
    if ( not stat ) then
        return;
    end

    local rating = addon[stat.rating];
    local conversionFactor = addon[stat.conversionFactor];
    local amount = amount or 0;

    local percent = (rating+amount) / conversionFactor;
    local bracket_rating = 0;
    local bracket_max_rating = 0;
    local bracket_penalty = 0;
    local bracket_next_penalty = 0.1;
    local true_rating = 0;

    for i,bracket in ipairs(self.StatBrackets) do
        if ( percent < bracket.size ) then
            bracket_rating = math.floor(0.5+percent * conversionFactor);
            bracket_max_rating = math.floor(0.5+bracket.size * conversionFactor);
            bracket_penalty = bracket.penalty;
            bracket_next_penalty = self.StatBrackets[i+1] and self.StatBrackets[i+1].penalty or 1;
            true_rating = true_rating + (percent * conversionFactor * (1.0 - bracket.penalty) );
            break;
        else
            true_rating = true_rating + (bracket.size * conversionFactor * (1.0 - bracket.penalty) );
        end
        percent = percent - bracket.size;
    end

    true_rating = math.floor(0.005+100*true_rating)/100;
    return true_rating, bracket_penalty, bracket_next_penalty, bracket_rating, bracket_max_rating
end


function addon.tsv:RecalculateTrueStatRatings() 
    addon.BaseCritRating = GetCombatRating(CR_CRIT_SPELL);
    addon.BaseHasteRating = GetCombatRating(CR_HASTE_SPELL);
    addon.BaseMasteryRating = GetCombatRating(CR_MASTERY);
    addon.BaseVersatilityRating = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);

    addon.TrueStatInfo = addon.TrueStatInfo or {};
    for statId,stat in pairs(statIdMap) do 
        local true_rating, bracket_penalty, bracket_next_penalty, bracket_rating, bracket_max_rating = self:GetStatDiminishBracket(statId);
        addon.TrueStatInfo[statId] = {
            bracketPenalty = bracket_penalty,
            bracketNextPenalty = bracket_next_penalty,
            bracketRating = bracket_rating,
            bracketMaxRating = bracket_max_rating,
            trueRating = true_rating,
            baseRating = addon[stat.rating],
            conversionFactor = addon[stat.conversionFactor]
        };
    end
end

function addon.tsv:GetTrueStatRatingAdded(statId,amount)
    local amount = tonumber(amount);
    local currentTrueRating = addon.TrueStatInfo[statId].trueRating;
    local addedTrueRating = self:GetStatDiminishBracket(statId,amount);
    local diff = addedTrueRating - currentTrueRating;
    diff = math.floor(0.005+100*diff)/100;
    return diff;
end