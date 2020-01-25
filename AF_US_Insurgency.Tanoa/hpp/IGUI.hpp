	
class AFPoints {
    idd = 277745;
    movingEnable =  0;
    enableSimulation = 1;
    enableDisplay = 1;
    duration     =  10e10;
    fadein       =  0;
    fadeout      =  0;
    name = "AFPoints";
    onLoad = "with uiNameSpace do { AFPoints = _this select 0 }";
	class controls {
	    class structuredText {
            access = 0;
            type = 13;
            idc = 1001;
            onLoad = "[clientOwner,{ [[AF_cDeads,AF_cMaxKill,0],[AF_pDT,AF_pMaxDT,0],AF_cacheCount,true] remoteExec ['AF_statIGUI',_this]; }] remoteExec ['spawn',2];";
            style = 0x00;
            lineSpacing = 1;
			x = 0.103165 * safezoneW + safezoneX;
			y = 0.007996 * safezoneH + safezoneY;//0.757996
			w = 0.778208 * safezoneW;
			h = 0.0660106 * safezoneH;
            size = 0.055;//0.020
            colorBackground[] = {0,0,0,0};
            colorText[] = {0.34,0.33,0.33,0};//{1,1,1,1}
            text = "fsdfds";
            font = "PuristaSemiBold";
			class Attributes {
				font = "PuristaSemiBold";
				color = "#C1C0BB";//"#FFFFFF";
				align = "CENTER";
				valign = "top";
				shadow = true;
				shadowColor = "#000000";
				underline = false;
				size = "0.75";//4
			};
        };
	};
};