local name, addon = ...;


--[[----------------------------------------------------------------------------
	Stat conversion factors (data taken from simc)
	https:--https://github.com/simulationcraft/simc/blob/dragonflight/engine/dbc/generated/sc_scale_data.inc
------------------------------------------------------------------------------]]
local hst_cnv =   {
    2.602257204,	2.602257204,	2.602257204,	2.602257204,	2.602257204,	--    5
    2.602257204,	2.602257204,	2.602257204,	2.602257204,	2.602257204,	--   10
    2.602257204,	2.732370064,	2.862482924,	2.992595784,	3.122708644,	--   15
    3.252821504,	3.382934365,	3.513047225,	3.643160085,	3.773272945,	--   20
    3.926373495,	4.087943764,	4.258513218,	4.438648327,	4.628955374,	--   25
    4.830083485,	5.04272791,	5.267633575,	5.505598922,	5.757480073,	--   30
    6.024195337,	6.306730098,	6.60614211,	6.923567238,	7.260225695,	--   35
    7.617428799,	7.996586318,	8.399214439,	8.826944434,	9.281532073,	--   40
    9.764867855,	10.27898815,	10.82608729,	11.40853079,	12.02886965,	--   45
    12.68985604,	13.39446029,	14.14588952,	14.9476078,	15.80335835,	--   50
    16.80575161,	17.8717258,	19.0053138,	20.2108043,	21.49275802,	--   55
    22.85602494,	24.3057627,	25.84745605,	27.48693768,	33.0561305,	--   60
    37.8893756,	43.42930529,	49.77924624,	57.05763286,	65.40021622,	--   65
    74.96259601,	85.92312267,	98.48622383,	112.8862171,	169.9954204,	--   70
  };
	
local crt_cnv =  {
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--    5
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--   10
    2.755331157,	2.893097715,	3.030864272,	3.16863083,	3.306397388,	--   15
    3.444163946,	3.581930504,	3.719697062,	3.857463619,	3.995230177,	--   20
    4.157336642,	4.328411045,	4.509013995,	4.699745287,	4.901246867,	--   25
    5.114206043,	5.339358964,	5.577494374,	5.829457682,	6.096155371,	--   30
    6.378559769,	6.677714222,	6.994738704,	7.330835899,	7.687297795,	--   35
    8.065512846,	8.466973748,	8.893285876,	9.34617646,	9.827504547,	--   40
    10.33927185,	10.88363451,	11.46291596,	12.07962083,	12.73645022,	--   45
    13.43631816,	14.18236972,	14.97800066,	15.82687885,	16.73296767,	--   50
    17.79432523,	18.92300378,	20.12327343,	21.39967514,	22.7570379,	--   55
    24.20049699,	25.73551344,	27.36789465,	29.10381637,	35.00060877,	--   60
    40.1181624,	45.98397031,	52.7074372,	60.4139642,	69.24728776,	--   65
    79.37216048,	90.977424,	104.2795311,	119.5265829,	179.995151,	--   70
};

local mst_cnv =  {
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--    5
    2.755331157,	2.755331157,	2.755331157,	2.755331157,	2.755331157,	--   10
    2.755331157,	2.893097715,	3.030864272,	3.16863083,	3.306397388,	--   15
    3.444163946,	3.581930504,	3.719697062,	3.857463619,	3.995230177,	--   20
    4.157336642,	4.328411045,	4.509013995,	4.699745287,	4.901246867,	--   25
    5.114206043,	5.339358964,	5.577494374,	5.829457682,	6.096155371,	--   30
    6.378559769,	6.677714222,	6.994738704,	7.330835899,	7.687297795,	--   35
    8.065512846,	8.466973748,	8.893285876,	9.34617646,	9.827504547,	--   40
    10.33927185,	10.88363451,	11.46291596,	12.07962083,	12.73645022,	--   45
    13.43631816,	14.18236972,	14.97800066,	15.82687885,	16.73296767,	--   50
    17.79432523,	18.92300378,	20.12327343,	21.39967514,	22.7570379,	--   55
    24.20049699,	25.73551344,	27.36789465,	29.10381637,	35.00060877,	--   60
    40.1181624,	45.98397031,	52.7074372,	60.4139642,	69.24728776,	--   65
    79.37216048,	90.977424,	104.2795311,	119.5265829,	179.995151,	--   70
  };

local vrs_cnv =     {
    3.13801604,	3.13801604,	3.13801604,	3.13801604,	3.13801604,	--    5
    3.13801604,	3.13801604,	3.13801604,	3.13801604,	3.13801604,	--   10
    3.13801604,	3.294916842,	3.451817644,	3.608718446,	3.765619248,	--   15
    3.92252005,	4.079420852,	4.236321654,	4.393222455,	4.550123257,	--   20
    4.734744509,	4.929579245,	5.135265939,	5.352487688,	5.581975598,	--   25
    5.824512438,	6.080936598,	6.35214637,	6.639104582,	6.942843617,	--   30
    7.264470848,	7.60517453,	7.966230191,	8.349007552,	8.754978044,	--   35
    9.185722964,	9.642942324,	10.12846447,	10.64425652,	11.19243573,	--   40
    11.77528183,	12.39525041,	13.05498762,	13.75734595,	14.50540164,	--   45
    15.30247346,	16.1521433,	17.05827853,	18.02505647,	19.05699095,	--   50
    20.26575929,	21.55119875,	22.91817252,	24.37185225,	25.91773761,	--   55
    27.56167713,	29.30989031,	31.16899113,	33.14601309,	39.86180443,	--   60
    45.6901294,	52.37063285,	60.02791459,	68.80479256,	78.86496662,	--   65
    90.39607166,	103.6131773,	118.7627993,	136.1274971,	204.9944775,	--   70
  };

local lee_cnv =    {
    1.683813485,	1.683813485,	1.683813485,	1.683813485,	1.683813485,	--    5
    1.683813485,	1.683813485,	1.683813485,	1.683813485,	1.683813485,	--   10
    1.683813485,	1.768004159,	1.852194833,	1.936385507,	2.020576182,	--   15
    2.104766856,	2.18895753,	2.273148204,	2.357338879,	2.441529553,	--   20
    2.540594614,	2.645140083,	2.755508553,	2.872066565,	2.995206418,	--   25
    3.125348137,	3.262941589,	3.408468784,	3.562446361,	3.725428282,	--   30
    3.898008747,	4.080825358,	4.274562542,	4.479955272,	4.697793097,	--   35
    4.928924517,	5.174261735,	5.434785813,	5.711552281,	6.005697223,	--   40
    6.318443906,	6.651109978,	7.005115307,	7.38199051,	7.783386244,	--   45
    8.211083318,	8.667003719,	9.153222628,	9.67198152,	10.22570246,	--   50
    10.87430986,	11.56405787,	12.29755599,	13.07757925,	13.90707872,	--   55
    14.78919261,	15.72725821,	16.72482451,	17.78566556,	21.38926091,	--   60
    24.5166548,	28.10131519,	32.21010051,	36.91964479,	42.31778696,	--   65
    48.50520918,	55.59731467,	63.72638012,	73.04402286,	109.9970367,	--   70
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

function addon.tsv:GetTrueStatRatingAdded(statId,amountStr)
    local amountStr = amountStr:gsub(",",""); --numbers are big enough to have commas now
    local amount = tonumber(amountStr);
    local currentTrueRating = addon.TrueStatInfo[statId].trueRating;
    local addedTrueRating = self:GetStatDiminishBracket(statId,amount);
    local diff = addedTrueRating - currentTrueRating;
    diff = math.floor(0.005+100*diff)/100;
    return diff;
end