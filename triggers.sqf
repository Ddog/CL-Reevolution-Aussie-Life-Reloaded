RadioTrigger_1 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_1 setTriggerArea       [0, 0, 0, false];
RadioTrigger_1 setTriggerActivation ["ALPHA", "NOT PRESENT", true];
RadioTrigger_1 setTriggerStatements ["this", "[""Einstellungen""] execVM ""settings.sqf"";", ""];
1 setRadioMsg "Settings";
RadioTrigger_6 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_6 setTriggerArea       [0, 0, 0, false];
RadioTrigger_6 setTriggerActivation ["FOXTROT", "NOT PRESENT", true];
RadioTrigger_6 setTriggerStatements ["this", "[RadioTextMsg_1, RadioTextArt_1] call SayDirectSpeach;", ""];
6 setRadioMsg "Say Text 1";
RadioTrigger_7 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_7 setTriggerArea       [0, 0, 0, false];
RadioTrigger_7 setTriggerActivation ["GOLF", "NOT PRESENT", true];
RadioTrigger_7 setTriggerStatements ["this", "[RadioTextMsg_2, RadioTextArt_2] call SayDirectSpeach;", ""];
7 setRadioMsg "Say Text 2";
RadioTrigger_8 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_8 setTriggerArea       [0, 0, 0, false];
RadioTrigger_8 setTriggerActivation ["HOTEL", "NOT PRESENT", true];
RadioTrigger_8 setTriggerStatements ["this", "[RadioTextMsg_3, RadioTextArt_3] call SayDirectSpeach;", ""];
8 setRadioMsg "Say Text 3";
RadioTrigger_9 = createTrigger      ["EmptyDetector", [0,0,0]];
RadioTrigger_9 setTriggerArea       [0, 0, 0, false];
RadioTrigger_9 setTriggerActivation ["INDIA", "NOT PRESENT", true];
RadioTrigger_9 setTriggerStatements ["this", "[RadioTextMsg_4, RadioTextArt_4] call SayDirectSpeach;", ""];
9 setRadioMsg "Say Text 4";
_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "Server Load"; 
_trg setTriggerActivation ["CHARLIE", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
	if (serverLoadHint) exitWith { player groupChat "You may only check the server load every 30 seconds to prevent network lag"; }; 
	serverLoadHint = true; 
	[nil,server,"loc",rSPAWN,player,{
		[nil,_this,"loc",rSPAWN,diag_fps,{
			hint format["nAiUnits: %1\nnGroups: %2\nServer FPS: %3\n Run Time: %4 mins", numberOfAI, count allGroups, round _this, round (time/60)];
			sleep 30;
			serverLoadHint = false;	
		}] call RE;
	}] call RE;	
	', ""]; 
_trg = createTrigger ["EmptyDetector", position player]; 
_trg setTriggerText "Unflip Vehicle"; 
_trg setTriggerActivation ["ECHO", "PRESENT", true]; 
_trg setTriggerStatements ["this", '
_vehicle = vehicle player;
if (player != _vehicle) then {
	_vehicle setPos [getPos _vehicle select 0, getPos _vehicle select 1, 0.5];
	_vehicle setVelocity [0,0,-0.5];
};
if (player == _vehicle) then {
	_objects = player nearEntities[["Car","Motorcycle","Air"],5];
	{	
		if (count _objects > 0) then {		
			_x setPos [getPos _x select 0, getPos _x select 1, 0.5];
			_x setVelocity [0,0,-0.5];
		};
	} forEach _objects;
};


', ""]; 

if(Debug)then

{

_trgobj = createTrigger ["EmptyDetector", position player ];
_trgobj setTriggerText "teleport";
_trgobj setTriggerActivation ["BRAVO", "PRESENT", true];
_trgobj setTriggerStatements ["this", 'hint "Click on map to select teleport destination"; openMap [true, false]; onMapSingleClick "vehicle player setpos _pos; player setPos _pos; (units group player select 1) setpos _pos; onMapSingleClick """";(vehicle player) setpos [_pos select 0, _pos select 1, 0] " ',""];

};