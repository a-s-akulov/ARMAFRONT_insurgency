//missionConfigFile >> "af_MainSlots"
class af_MainSlots
{
	idd = 456965;
	movingEnabled = false;
	class controls
	{
		class BackGrndPicture: RscPicture
		{
			idc = 999888;
			x = 0 * safezoneW + safezoneX;
			y = 0 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 1 * safezoneH;
			text = "scripts\af_slots\usa\USABackground1.jpg";
		};
		class FirstMessage: RscStructuredText
		{
			idc = 999777;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.005 * safezoneH + safezoneY;
			w = 0.98 * safezoneW;
			h = 0.025 * safezoneH;
			colorBackground[] = {1,1,1,0};
		};
		class Discription: RscStructuredText
		{
			idc = 999333;
			x = 0.23 * safezoneW + safezoneX;
			y = 0.795 * safezoneH + safezoneY;
			w = 0.54 * safezoneW;
			h = 0.2 * safezoneH;
			colorBackground[] = {1,1,1,0.4};
		};
		class InBattleBtn: RscButton
		{
			idc = 999444;
			x = 0.79 * safezoneW + safezoneX;
			y = 0.795 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.2 * safezoneH;
			sizeEx = 0.1;
			colorBackground[] = {1,0,0,1};
			colorBackgroundActive[] = {1,0.3,0,1};
			colorFocused[] = {1,0,0,1};
		};
		class CancelChoiseBtn: RscButton
		{
			idc = 999555;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.795 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.12 * safezoneH;
			sizeEx = 0.1;
			action = "private _control = findDisplay 456965; _control closeDisplay 0;";
			colorBackgroundActive[] = {1,1,1,0.2};
			colorFocused[] = {0,0,0,0.5};
		};
		class BackToRoleChoiseBtn: RscButton
		{
			idc = 999666;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.935 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.06 * safezoneH;
			action = "['closeDialog 0; private _control = findDisplay 456965; _control closeDisplay 0; failMission ""AF_SlotsBTRS"";','',localize 'SlotsBTRSHead',localize 'SlotsBTRSQuest'] spawn AF_question;";
			sizeEx = 0.05;
			colorBackgroundActive[] = {1,1,1,0.2};
			colorFocused[] = {0,0,0,0.5};
		};
		class AF_Controls_Slots: RscControlsGroup
		{
			idc = CT_CONTROLS_GROUP;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.04 * safezoneH + safezoneY;
			w = 0.76 * safezoneW;
			h = 0.75 * safezoneH;
			access = 0; // Control access (0 - ReadAndWrite, 1 - ReadAndCreate, 2 - ReadOnly, 3 - ReadOnlyVerified)
			type = CT_CONTROLS_GROUP; // Type
			style = LB_TEXTURES; // Style
			blinkingPeriod = 0; // Time in which control will fade out and back in. Use 0 to disable the effect.
			colorBackground[] = {1,1,1,0.3};
			colorText[] = {0,0,0,0};
			font = GUI_FONT_NORMAL;
			sizeEx = safezoneH;
			lineSpacing = 1;
			text = ""; 
/*///////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Katletka, v1.063, #Zelibo)
////////////////////////////////////////////////////////

class RscPicture_1200: RscPicture
{
	idc = 1200;
	text = "#(argb,8,8,3)color(1,1,1,1)";
	x = 0.537879;
	y = 0.537037;
	w = 0.1 * GUI_GRID_W;
	h = 0.1;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
///////////////////////////////////////////////////////*/

			class Controls
			{
				// PICTURES STARTS
				class 999001: RscPicture
				{
					idc = 999001;
					text = "";
					x = 0;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999002: RscPicture
				{
					idc = 999002;
					text = "";
					x = 0.22 * safezoneW;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999003: RscPicture
				{
					idc = 999003;
					text = "";
					x = 0.22 * safezoneW * 2;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999004: RscPicture
				{
					idc = 999004;
					text = "";
					x = 0.22 * safezoneW * 3;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999005: RscPicture
				{
					idc = 999005;
					text = "";
					x = 0.22 * safezoneW * 4;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999006: RscPicture
				{
					idc = 999006;
					text = "";
					x = 0.22 * safezoneW * 5;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999007: RscPicture
				{
					idc = 999007;
					text = "";
					x = 0.22 * safezoneW * 6;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999008: RscPicture
				{
					idc = 999008;
					text = "";
					x = 0.22 * safezoneW * 7;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999009: RscPicture
				{
					idc = 999009;
					text = "";
					x = 0.22 * safezoneW * 8;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				class 999010: RscPicture
				{
					idc = 999010;
					text = "";
					x = 0.22 * safezoneW * 9;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
				};
				// PICTURES ENDS
				// FRAMES STARTS
				class 999201: RscFrame
				{
					idc = 999201;
					x = 0;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999202: RscFrame
				{
					idc = 999202;
					x = 0.22 * safezoneW;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999203: RscFrame
				{
					idc = 999203;
					x = 0.22 * safezoneW * 2;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999204: RscFrame
				{
					idc = 999204;
					x = 0.22 * safezoneW * 3;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999205: RscFrame
				{
					idc = 999205;
					x = 0.22 * safezoneW * 4;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999206: RscFrame
				{
					idc = 999206;
					x = 0.22 * safezoneW * 5;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999207: RscFrame
				{
					idc = 999207;
					x = 0.22 * safezoneW * 6;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999208: RscFrame
				{
					idc = 999208;
					x = 0.22 * safezoneW * 7;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999209: RscFrame
				{
					idc = 999209;
					x = 0.22 * safezoneW * 8;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				class 999210: RscFrame
				{
					idc = 999210;
					x = 0.22 * safezoneW * 9;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorText[] = {0,0.8,0,0};
					shadow = 0;
				};
				// FRAMES ENDS
				// BUTTONS STARTS
				class 999101: RscButton
				{
					idc = 999101;
					x = 0;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999102: RscButton
				{
					idc = 999102;
					x = 0.22 * safezoneW;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999103: RscButton
				{
					idc = 999103;
					x = 0.22 * safezoneW * 2;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999104: RscButton
				{
					idc = 999104;
					x = 0.22 * safezoneW * 3;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999105: RscButton
				{
					idc = 999105;
					x = 0.22 * safezoneW * 4;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999106: RscButton
				{
					idc = 999106;
					x = 0.22 * safezoneW * 5;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999107: RscButton
				{
					idc = 999107;
					x = 0.22 * safezoneW * 6;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999108: RscButton
				{
					idc = 999108;
					x = 0.22 * safezoneW * 7;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999109: RscButton
				{
					idc = 999109;
					x = 0.22 * safezoneW * 8;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				class 999110: RscButton
				{
					idc = 999110;
					x = 0.22 * safezoneW * 9;
					y = 0;
					w = 0.2 * safezoneW;
					h = 0.7 * safezoneH;
					colorBackground[] = {1,1,1,0};
					colorBackgroundActive[] = {1,1,1,0.2};
					colorFocused[] = {1,1,1,0};
					colorBackgroundDisabled[] = {1,1,1,0};
				};
				// BUTTONS ENDS
			};
			// Scrollbar configuration (applied only when LB_TEXTURES style is used)

			class HScrollBar
			{
				idc = 4567654;
				width = 0; // Unknown?
				height = 0.05; // Unknown?
				scrollSpeed = 0.01; // Unknown?

				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa"; // Arrow
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa"; // Arrow when clicked on
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa"; // Slider background (stretched vertically)
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa"; // Dragging element (stretched vertically)

				color[] = {1,1,1,1}; // Scrollbar color
			};
			class VScrollBar {};
		};
		class AFInfoSlots: RscStructuredText
		{
			idc = 999778;
			x = 0.79 * safezoneW + safezoneX;
			y = 0.129 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.661 * safezoneH;
			colorBackground[] = {1,1,1,0.4};
		};
		class AFLogoSlots: RscPicture
		{
			idc = 999878;
			text = "Scripts\AF_Slots\armafront_logo.jpg";
			x = 0.79 * safezoneW + safezoneX;
			y = 0.04 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.085 * safezoneH;
		};
	};
};