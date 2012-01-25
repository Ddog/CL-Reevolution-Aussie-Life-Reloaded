
//! Definite: Custom lift chopper script

//! Definite: LiftInit only adds lifting commands to valid chopper types. Cargo checks done in LiftChopperAttachCargo.sqf 
//! Definite: valid choppers have lift/drop commands present at all times

//! Definite: array of lift choppers
_liftChoppers = ["Mi17_CDF", "Mi17_Ins", "Mi17_rockets_RU", "Mi17_medevac_CDF", "Mi17_medevac_Ins", "Mi17_medevac_RU", "Ka52", "Ka52Black", "UH1Y", "MH60S", "MV22"];

//! Definite: loop script indefinitely while server running so all choppers re-checked
while {true} do 
{
	//! Definite: make sure player is in a vehicle
    if (vehicle player != player) then 
    {
		_chopper = vehicle player;
		_vehicleType = typeOf _chopper;		

		//! Definite: confirm player is in the correct lift chopper type, player is the driver of the vehicle, and the vehicle is still alive
		if((_vehicleType in _liftChoppers) && (driver _chopper == player) && (alive _chopper)) then
		{
			//! Definite: add lift commands to chopper first time only
			_actionAdded = _chopper getVariable "liftChopperActionsAdded";

			//! Definite: confirm actions haven't already been added to this vehicle
			if(isNil "_actionAdded") then
			{
				_chopper setVariable ["liftChopperActionsAdded", 1, true];		//! Definite: set actions added flag so not added a second time
				_chopper setVariable ["vehicleCargoAttached", 0, true];			//! Definite: set attachment variables false since definitely nothing attached yet

				//! Definite: valid lift chopper, so add the lift/release actions
				liftChopper_LiftVehicleActionID = _chopper addAction ["Lift Vehicle","LiftChopperAttachCargo.sqf"];
				liftChopper_DropVehicleActionID = _chopper addAction ["Release Vehicle","LiftChopperDetachCargo.sqf"];
			};
		};
    };

	sleep 1;	//! Definite: wait 1 second between loops, shouldn't need to check more often than this
};











