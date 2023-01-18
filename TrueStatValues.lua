local name, addon = ...;


--[[----------------------------------------------------------------------------
	Stat conversion factors (data taken from simc)
	https:--github.com/simulationcraft/simc/blob/shadowlands/engine/dbc/generated/sc_scale_data.inc
------------------------------------------------------------------------------]]
local hst_cnv =   {
    2.550202644,	2.550202644,	2.550202644,	2.550202644,	2.550202644,	
    2.550202644,	2.550202644,	2.550202644,	2.550202644,	2.550202644,	
    2.550202644,	2.677712777,	2.805222909,	2.932733041,	3.060243173,	
    3.187753306,	3.315263438,	3.44277357,	3.570283702,	3.697793835,	
    3.825303967,	3.952814099,	4.080324231,	4.207834363,	4.335344496,	
    4.466618727,	4.603118595,	4.745078773,	4.892745624,	5.046377837,	
    5.206247087,	5.372638744,	5.545852617,	5.726203744,	5.914023226,	
    6.109659115,	6.313477343,	6.525862721,	6.747219984,	6.977974908,	
    7.23803877,	7.507795016,	7.787604874,	8.077843034,	8.378898152,	
    8.691173367,	9.015086844,	9.351072331,	9.699579745,	10.06107577,	
    11.10794054,	12.26373262,	13.53978599,	14.94861396,	16.50403187,	
    18.22129252,	20.11723583,	22.21045389,	24.52147334,	33.00000009,	
};
	
local crt_cnv =   {
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
};

local mst_cnv =   {
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
};

local vrs_cnv =   {
    3.091154721,	3.091154721,	3.091154721,	3.091154721,	3.091154721,	--    5
    3.091154721,	3.091154721,	3.091154721,	3.091154721,	3.091154721,	--   10
    3.091154721,	3.245712457,	3.400270193,	3.554827929,	3.709385665,	--   15
    3.863943401,	4.018501137,	4.173058873,	4.327616609,	4.482174345,	--   20
    4.636732081,	4.791289817,	4.945847553,	5.100405289,	5.254963025,	--   25
    5.414083305,	5.579537691,	5.751610634,	5.930600757,	6.11682162,	--   30
    6.310602529,	6.512289386,	6.722245596,	6.940853023,	7.168513002,	--   35
    7.405647412,	7.65269981,	7.910136631,	8.178448466,	8.458151403,	--   40
    8.773380327,	9.100357595,	9.439521059,	9.79132489,	10.15624018,	--   45
    10.5347556,	10.92737799,	11.33463313,	11.75706636,	12.19524335,	--   50
    13.46417035,	14.86513044,	16.4118618,	18.11953208,	20.00488711,	--   55
    22.08641518,	24.38452828,	26.92176229,	29.72299799,	40.0000001,	--   60
};

local lee_cnv =   {
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