
//! Definite: detach vehicle cargo

_chopper = vehicle player;	//! Definite: get vehicle

//! Definite: make sure calling player is still in a vehicle, and is the driver
if((_chopper != player) && (driver _chopper == player)) then 
{
	//! Definite: check that vehicle is actually carrying a vehicle cargo
	_cargoAttached = _chopper getVariable "vehicleCargoAttached";

	//! Definite: confirm that variable exists. if not, set it to false
	if(isnil "_cargoAttached") then { _cargoAttached = 0; };
	
	//! Definite: confirm cargo is attached
	if(_cargoAttached == 1) then
	{
		//! Definite: get the attached vehicle as recorded
		_cargo = _chopper getVariable "vehicleCargo";
		
		//! Definite: confirm that variable exists
		if(!(isnil "_cargo")) then
		{
 			//! Definite: confirm that the cargo exists
			if(!(isnull _cargo)) then
			{
				//! Definite: release the vehicle cargo
				detach _cargo;

				//! Definite: set vehicle to no cargo state
				_chopper setVariable ["vehicleCargoAttached", 0, true];
				//_chopper setVariable ["vehicleCargo", nil];		// probably dont need to null this because 

				//! Definite: alert vehicle of the release
				vehicle player vehicleChat "Vehicle released";
			}
			else
			{	
				vehicle player vehicleChat "Error: _cargo is null";
			};
		}
		else
		{
			vehicle player vehicleChat "Error: _cargo is nill";
		};
	}
	else
	{
		//! Definite: warn that no vehicle is attached
		vehicle player vehicleChat "Not carrying a vehicle";
	};
};


