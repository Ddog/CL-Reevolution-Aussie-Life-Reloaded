//Sets the Check to false
DuMusicFull = 0;
DuMusicLite = 0;

//Checks for Down Under Music Pack Full Version
if (isClass(configFile >> "CfgPatches" >> "DUmusicFull")) then
{
_h = [] execVM "CLAY_CarRadio\initCarRadio.sqf";

waitUntil{scriptDone  _h};
DuMusicFull = 1;
};
//Checks for Down Under Music Pack Lite Version
if (isClass(configFile >> "CfgPatches" >> "DUmusicLite")) then
{
_h = [] execVM "CLAY_CarRadioLite\initCarRadio.sqf";

waitUntil{scriptDone  _h};
DuMusicLite = 1;
};
sleep 60;
//Lets the player know which version they have.
if (DuMusicFull == 1) exitwith {hint "Full Car Radio Enabled"}; 
if (DuMusicLite == 1) exitwith {hint "Lite Car Radio Enabled Full Version on AddonSync"};
if (DuMusicFull == 0) exitwith {hint "Car Radio is Not Installed, Available on request"};        


//Script by Weed for the Down Under Community