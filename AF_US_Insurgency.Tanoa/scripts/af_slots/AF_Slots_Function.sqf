_rtrn = 0;
switch (side player) do
{
	case west:
	{
		switch pRole do
		{
			case 0: // role switcher (type of player) ||  Squad Leader
			{
				switch (_this) do
				{
					//	table of contents with name of role (to localize)		first clot's Image								second slot's image										third slot's image
					case 0: { _rtrn = [localize "SlotsSquadLeader",localize "SlotsSquadLeaderDis","scripts\af_slots\usa\squad_leader\Squad_leader_1.jpg","scripts\af_slots\usa\squad_leader\Squad_leader_2.jpg","scripts\af_slots\usa\squad_leader\Squad_leader_3.jpg","scripts\af_slots\usa\squad_leader\Squad_leader_4.jpg","scripts\af_slots\usa\squad_leader\Squad_leader_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\squad_leader\Squad_leader_1.sqf"; }; // first slot's file
					case 2: { _rtrn = "scripts\af_slots\usa\squad_leader\Squad_leader_2.sqf"; }; // second slot's file
					case 3: { _rtrn = "scripts\af_slots\usa\squad_leader\Squad_leader_3.sqf"; }; // third slot's file
					case 4: { _rtrn = "scripts\af_slots\usa\squad_leader\Squad_leader_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\squad_leader\Squad_leader_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSquadLeader1"]; }; // first slot's discription (to localize)
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSquadLeader2"]; }; // second slot's discription (to localize)
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSquadLeader3"]; }; // third slot's discription (to localize)
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSquadLeader4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSquadLeader5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 1: // Medic
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsMedic",localize "SlotsMedicDis","scripts\af_slots\usa\medic\Medic_1.jpg","scripts\af_slots\usa\medic\Medic_2.jpg","scripts\af_slots\usa\medic\Medic_3.jpg","scripts\af_slots\usa\medic\Medic_4.jpg","scripts\af_slots\usa\medic\Medic_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\medic\Medic_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\medic\Medic_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\medic\Medic_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\medic\Medic_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\medic\Medic_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMedic1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMedic2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMedic3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMedic4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMedic5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 2: // Engineer
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsEngineer",localize "SlotsEngineerDis","scripts\af_slots\usa\engineer\Engineer_1.jpg","scripts\af_slots\usa\engineer\Engineer_2.jpg","scripts\af_slots\usa\engineer\Engineer_3.jpg","scripts\af_slots\usa\engineer\Engineer_4.jpg","scripts\af_slots\usa\engineer\Engineer_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\engineer\Engineer_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\engineer\Engineer_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\engineer\Engineer_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\engineer\Engineer_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\engineer\Engineer_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsEngineer1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsEngineer2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsEngineer3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsEngineer4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsEngineer5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 3: // Grenadier
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsGrenadier",localize "SlotsGrenadierDis","scripts\af_slots\usa\grenadier\Grenadier_1.jpg","scripts\af_slots\usa\grenadier\Grenadier_2.jpg","scripts\af_slots\usa\grenadier\Grenadier_3.jpg","scripts\af_slots\usa\grenadier\Grenadier_4.jpg","scripts\af_slots\usa\grenadier\Grenadier_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\grenadier\Grenadier_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\grenadier\Grenadier_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\grenadier\Grenadier_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\grenadier\Grenadier_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\grenadier\Grenadier_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsGrenadier1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsGrenadier2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsGrenadier3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsGrenadier4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsGrenadier5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 4: // Machinegunner
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsMachinegunner",localize "SlotsMachinegunnerDis","scripts\af_slots\usa\machinegunner\Machinegunner_1.jpg","scripts\af_slots\usa\machinegunner\Machinegunner_2.jpg","scripts\af_slots\usa\machinegunner\Machinegunner_3.jpg","scripts\af_slots\usa\machinegunner\Machinegunner_4.jpg","scripts\af_slots\usa\machinegunner\Machinegunner_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\machinegunner\Machinegunner_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\machinegunner\Machinegunner_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\machinegunner\Machinegunner_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\machinegunner\Machinegunner_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\machinegunner\Machinegunner_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMachinegunner1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMachinegunner2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMachinegunner3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMachinegunner4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsMachinegunner5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 5: // Sniper
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsSniper",localize "SlotsSniperDis","scripts\af_slots\usa\sniper\Sniper_1.jpg","scripts\af_slots\usa\sniper\Sniper_2.jpg","scripts\af_slots\usa\sniper\Sniper_3.jpg","scripts\af_slots\usa\sniper\Sniper_4.jpg","scripts\af_slots\usa\sniper\Sniper_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\sniper\Sniper_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\sniper\Sniper_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\sniper\Sniper_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\sniper\Sniper_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\sniper\Sniper_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSniper1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSniper2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSniper3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSniper4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsSniper5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 6: // Rifleman
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsRifleman",localize "SlotsRiflemanDis","scripts\af_slots\usa\rifleman\rifleman_1.jpg","scripts\af_slots\usa\rifleman\rifleman_2.jpg","scripts\af_slots\usa\rifleman\rifleman_3.jpg","scripts\af_slots\usa\rifleman\rifleman_4.jpg","scripts\af_slots\usa\rifleman\rifleman_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\rifleman\Rifleman_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\rifleman\Rifleman_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\rifleman\Rifleman_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\rifleman\Rifleman_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\rifleman\Rifleman_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsRifleman1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsRifleman2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsRifleman3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsRifleman4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsRifleman5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 7: // Breacher
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsBreacher",localize "SlotsBreacherDis","scripts\af_slots\usa\breacher\Breacher_1.jpg","scripts\af_slots\usa\breacher\Breacher_2.jpg","scripts\af_slots\usa\breacher\Breacher_3.jpg","scripts\af_slots\usa\breacher\Breacher_4.jpg","scripts\af_slots\usa\breacher\Breacher_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\breacher\Breacher_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\breacher\Breacher_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\breacher\Breacher_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\breacher\Breacher_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\breacher\Breacher_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsBreacher1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsBreacher2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsBreacher3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsBreacher4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsBreacher5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 8: // Crewman
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsCrewman",localize "SlotsCrewmanDis","scripts\af_slots\usa\crewman\Crewman_1.jpg","scripts\af_slots\usa\crewman\Crewman_2.jpg","scripts\af_slots\usa\crewman\Crewman_3.jpg","scripts\af_slots\usa\crewman\Crewman_4.jpg","scripts\af_slots\usa\crewman\Crewman_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\crewman\Crewman_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\crewman\Crewman_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\crewman\Crewman_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\crewman\Crewman_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\crewman\Crewman_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsCrewman1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsCrewman2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsCrewman3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsCrewman4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsCrewman5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			case 9: // Pilot
			{
				switch (_this) do
				{
					case 0: { _rtrn = [localize "SlotsPilot",localize "SlotsPilotDis","scripts\af_slots\usa\pilot\Pilot_1.jpg","scripts\af_slots\usa\pilot\Pilot_2.jpg","scripts\af_slots\usa\pilot\Pilot_3.jpg","scripts\af_slots\usa\pilot\Pilot_4.jpg","scripts\af_slots\usa\pilot\Pilot_5.jpg"]; };
					case 1: { _rtrn = "scripts\af_slots\usa\pilot\Pilot_1.sqf"; };
					case 2: { _rtrn = "scripts\af_slots\usa\pilot\Pilot_2.sqf"; };
					case 3: { _rtrn = "scripts\af_slots\usa\pilot\Pilot_3.sqf"; };
					case 4: { _rtrn = "scripts\af_slots\usa\pilot\Pilot_4.sqf"; };
					case 5: { _rtrn = "scripts\af_slots\usa\pilot\Pilot_5.sqf"; };
					case "Discription_1": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsPilot1"]; };
					case "Discription_2": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsPilot2"]; };
					case "Discription_3": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsPilot3"]; };
					case "Discription_4": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsPilot4"]; };
					case "Discription_5": { _rtrn = format ["<t color='#000000'>%1</t>",localize "AFSlotsPilot5"]; };
					default { systemChat str ["Function return (DEFAULT, switch _this) ",_this]; }; // default - error message of this function, not using
				};
			};
			default { systemChat str ["Function return (DEFAULT, switch typeOf player) ",typeOf player]; }; // default - error message of this function, not using
		};
	};
	case east: { systemChat str ["Function return CASE EAST"]; };
	default { systemChat str ["Function return (DEFAULT, switch side player) ",side player]; }; // default - error message of this function, not using
};
_rtrn