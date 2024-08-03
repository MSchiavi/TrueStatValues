local name, addon = ...;


--[[----------------------------------------------------------------------------
	Stat conversion factors (data taken from simc)
	https:--https:--github.com/simulationcraft/simc/blob/dragonflight/engine/dbc/generated/sc_scale_data.inc
------------------------------------------------------------------------------]]
local hst_cnv =   {
    2.948095354,	2.948095354,	2.948095354,	2.948095354,	2.948095354,	--    5
    2.948095354,	2.948095354,	2.948095354,	2.948095354,	2.948095354,	--   10
    2.948095354,	3.095500122,	3.242904889,	3.390309657,	3.537714425,	--   15
    3.685119192,	3.83252396,	3.979928728,	4.127333496,	4.274738263,	--   20
    4.453978039,	4.649329515,	4.862222314,	5.094247563,	5.347176954,	--   25
    5.622984341,	5.923870234,	6.252289599,	6.610983454,	7.003014772,	--   30
    7.431809367,	7.901202447,	8.415491714,	8.979497968,	9.598634353,	--   35
    10.27898556,	11.02739849,	11.85158626,	12.76024738,	13.76320282,	--   40
    14.87155354,	16.09786185,	17.45636041,	18.96319344,	20.63669526,	--   45
    22.49771244,	24.56997673,	26.88053735,	29.46026251,	32.34442221,	--   50
    35.57336588,	39.1933116,	43.25726608,	47.82609852,	52.96979542,	--   55
    58.76892862,	65.31637495,	72.71933289,	81.10169039,	90.60680851,	--   60
    95.70270333,	101.0852007,	106.7704197,	112.775386,	119.1180827,	--   65
    125.8175044,	132.893714,	140.3679028,	148.2624537,	174.7114226,	--   70
    195.1745499,	218.0344269,	243.5717739,	272.1001901,	303.9700056,	--   75
    339.5725827,	379.3451222,	423.7760322,	473.4109257,	660,	--   80
  };
	
local crt_cnv =  {
    3.1267678,	3.1267678,	3.1267678,	3.1267678,	3.1267678,	--    5
    3.1267678,	3.1267678,	3.1267678,	3.1267678,	3.1267678,	--   10
    3.1267678,	3.28310619,	3.43944458,	3.59578297,	3.75212136,	--   15
    3.90845975,	4.06479814,	4.221136529,	4.377474919,	4.533813309,	--   20
    4.723916102,	4.931107062,	5.156902454,	5.402989839,	5.671248285,	--   25
    5.963771271,	6.282892672,	6.631216242,	7.011649117,	7.42743991,	--   30
    7.882222056,	8.380063201,	8.925521515,	9.523709967,	10.18036977,	--   35
    10.90195438,	11.69572568,	12.56986421,	13.5335957,	14.59733632,	--   40
    15.77285982,	17.07348984,	18.51432165,	20.11247789,	21.88740407,	--   45
    23.86121016,	26.05906623,	28.50966082,	31.24573297,	34.30469023,	--   50
    37.72932745,	41.56866382,	45.87891857,	50.72464994,	56.18008605,	--   55
    62.33068187,	69.27494313,	77.12656519,	86.01694436,	96.09813024,	--   60
    101.5028672,	107.2115765,	113.2413543,	119.6102579,	126.3373604,	--   65
    133.4428077,	140.9478785,	148.8750484,	157.248057,	185.2999937,	--   70
    207.0033105,	231.2486346,	258.3336995,	288.5911108,	322.3924302,	--   75
    360.1527393,	402.3357357,	449.4594281,	502.102497,	700,	--   80
};

local mst_cnv =  {
    3.1267678,	3.1267678,	3.1267678,	3.1267678,	3.1267678,	--    5
    3.1267678,	3.1267678,	3.1267678,	3.1267678,	3.1267678,	--   10
    3.1267678,	3.28310619,	3.43944458,	3.59578297,	3.75212136,	--   15
    3.90845975,	4.06479814,	4.221136529,	4.377474919,	4.533813309,	--   20
    4.723916102,	4.931107062,	5.156902454,	5.402989839,	5.671248285,	--   25
    5.963771271,	6.282892672,	6.631216242,	7.011649117,	7.42743991,	--   30
    7.882222056,	8.380063201,	8.925521515,	9.523709967,	10.18036977,	--   35
    10.90195438,	11.69572568,	12.56986421,	13.5335957,	14.59733632,	--   40
    15.77285982,	17.07348984,	18.51432165,	20.11247789,	21.88740407,	--   45
    23.86121016,	26.05906623,	28.50966082,	31.24573297,	34.30469023,	--   50
    37.72932745,	41.56866382,	45.87891857,	50.72464994,	56.18008605,	--   55
    62.33068187,	69.27494313,	77.12656519,	86.01694436,	96.09813024,	--   60
    101.5028672,	107.2115765,	113.2413543,	119.6102579,	126.3373604,	--   65
    133.4428077,	140.9478785,	148.8750484,	157.248057,	185.2999937,	--   70
    207.0033105,	231.2486346,	258.3336995,	288.5911108,	322.3924302,	--   75
    360.1527393,	402.3357357,	449.4594281,	502.102497,	700,	--   80
  };

local vrs_cnv =     {
    3.484112691,	3.484112691,	3.484112691,	3.484112691,	3.484112691,	--    5
    3.484112691,	3.484112691,	3.484112691,	3.484112691,	3.484112691,	--   10
    3.484112691,	3.658318326,	3.83252396,	4.006729595,	4.180935229,	--   15
    4.355140864,	4.529346498,	4.703552133,	4.877757767,	5.051963402,	--   20
    5.263792227,	5.494662155,	5.746262735,	6.020474392,	6.319390946,	--   25
    6.645345131,	7.000937549,	7.389069526,	7.812980445,	8.276290186,	--   30
    8.783047434,	9.33778471,	9.945581116,	10.61213396,	11.3438406,	--   35
    12.14789202,	13.03238004,	14.00642012,	15.08029235,	16.26560333,	--   40
    17.57547237,	19.02474582,	20.63024412,	22.41104679,	24.38882167,	--   45
    26.58820561,	29.03724523,	31.76790777,	34.81667388,	38.22522625,	--   50
    42.04125059,	46.31936825,	51.12222354,	56.5217528,	62.60066731,	--   55
    69.45418837,	77.19207949,	85.94102978,	95.84745228,	107.0807737,	--   60
    113.1031948,	119.4643281,	126.1832233,	133.2800016,	140.7759159,	--   65
    148.6934143,	157.0562075,	165.8893396,	175.2192635,	206.4771359,	--   70
    230.6608317,	257.67705,	287.8575509,	321.572952,	359.2372794,	--   75
    401.3130523,	448.3169626,	500.8262199,	559.4856395,	780,	--   80
  };


function addon.tsv:SetupConversionFactors()
	local level = UnitLevel("Player");
    level = math.max(level,1);
    
	addon.CritConv 		= crt_cnv[level];
	addon.HasteConv 	= hst_cnv[level];
	addon.VersConv 		= vrs_cnv[level];
	addon.MasteryConv 	= mst_cnv[level];
end

local statIdMap = {
    [CR_CRIT_SPELL]={["conversionFactor"]="CritConv",["rating"]="BaseCritRating"},
    [CR_HASTE_SPELL]={["conversionFactor"]="HasteConv",["rating"]="BaseHasteRating"},
    [CR_MASTERY]={["conversionFactor"]="MasteryConv",["rating"]="BaseMasteryRating"},
    [CR_VERSATILITY_DAMAGE_DONE]={["conversionFactor"]="VersConv",["rating"]="BaseVersatilityRating"}
}


--[[
    https:--www.wowhead.com/news=318435/update-on-diminishing-returns-for-secondary-stats-in-shadowlands-new-thresholds-

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

function addon.tsv:GetTrueStatRatingAdded(statId,amountStr)
    local amountStr = amountStr:gsub(",",""); --numbers are big enough to have commas now
    local amount = tonumber(amountStr);
    local currentTrueRating = addon.TrueStatInfo[statId].trueRating;
    local addedTrueRating = self:GetStatDiminishBracket(statId,amount);
    local diff = addedTrueRating - currentTrueRating;
    diff = math.floor(0.005+100*diff)/100;
    return diff;
end