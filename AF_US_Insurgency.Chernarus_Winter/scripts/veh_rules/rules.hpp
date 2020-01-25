/*
	by KOKaKOJIbKA
*/
class KOKa_rules
{
	idd = 11400;
	movingEnable = false;
	onLoad = "hintSilent """"";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by KOKaKOJIbKA, v1.063, #Wyhigo)
		////////////////////////////////////////////////////////
		class KOKa_main_frame: RscFrame
		{
			idc = 11401;
			x = 0.301917 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.396166 * safezoneW;
			h = 0.572 * safezoneH;
		};
		class KOKa_main_iguiback: IGUIBack
		{
			idc = 11402;
			x = 0.301917 * safezoneW + safezoneX;
			y = 0.214 * safezoneH + safezoneY;
			w = 0.396166 * safezoneW;
			h = 0.572 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class KOKa_RscFrame_1801: RscFrame
		{
			idc = 11403;
			x = 0.301917 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.18842 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class KOKa_RscFrame_1802: RscFrame
		{
			idc = 11404;
			x = 0.509663 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.18842 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class KOKa_RscButton_1600: RscButton
		{
			idc = 11405;
			x = 0.301917 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.18842 * safezoneW;
			h = 0.044 * safezoneH;
			text = "";
			colorBackground[] = {0.5,0,0,1};
			colorText[] = {0.82,0.82,0.82,1};
			onButtonClick = "['out','BeeBlip'] execVM 'scripts\veh_rules\rules_confirmed.sqf'; failMission 'Kat_RulesOut';";
		};
		class KOKa_RscButton_1601: RscButton
		{
			idc = 11406;
			x = 0.509663 * safezoneW + safezoneX;
			y = 0.808 * safezoneH + safezoneY;
			w = 0.18842 * safezoneW;
			h = 0.044 * safezoneH;
			text = "";
			colorBackground[] = {0,0.5,0,1};
			colorText[] = {0.82,0.82,0.82,1};
			onButtonClick = "playSound 'KatTarget'; closeDialog 0; ['confirmed','BeeBlip'] execVM 'scripts\veh_rules\rules_confirmed.sqf'; private _id = player getVariable 'VR_id'; player removeEventHandler ['GetInMan',_id select 0]; player removeEventHandler ['SeatSwitchedMan',_id select 1]; player setVariable ['VR_id',nil];";
		};
		class KOKa_name_server: RscStructuredText
		{
			idc = 11407;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				align = "center";
				color = "#595923";
			};
		};
		class KOKa_rules_1: RscStructuredText
		{
			idc = 11408;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				color = "#99ffffff";
			};
		};
		class KOKa_rules_2: RscStructuredText
		{
			idc = 11409;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				color = "#99ffffff";
			};
		};
		class KOKa_rules_3: RscStructuredText
		{
			idc = 11410;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				color = "#99ffffff";
			};
		};
		class KOKa_rules_4: RscStructuredText
		{
			idc = 11411;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				color = "#99ffffff";
			};
		};
		class KOKa_rules_5: RscStructuredText
		{
			idc = 11412;
			x = 0.306748 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.386503 * safezoneW;
			h = 0.066 * safezoneH;
			text = "";
			class Attributes
			{
				color = "#99ffffff";
			};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
