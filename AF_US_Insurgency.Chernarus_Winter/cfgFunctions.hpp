class cfgFunctions {
	class DMC {
		class ServerFunctions {
			class spawnAirPatrol {
				// Path to file (%ROOT%(mission root / game root)\myFile.sqf)
				// 1 to call the function upon mission start, before objects are initialized.
				preInit = 0; // Passed arguments are ["preInit"]
				// 1 to call the function upon mission start, after objects are initialized.
				postInit = 0; // Passed arguments are ["postInit"]
				// 1 to recompile the function upon mission start
				recompile = 0; // Mission functions are always compiled on init. No need to be redundant.
				// Set file type, can be ".sqf" or ".fsm" (meaning scripted FSM).
				ext = ".sqf"; // Default is ".sqf".
			};
		};
	};
};
