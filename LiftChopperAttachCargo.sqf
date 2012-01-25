
//! Definite: Attach cargo script
//! Definite: Detects valid cargo and attaches or denies as necessary

//! Definite: variables. defines behaviour.

_maxLiftDistance = 10;		//! Definite: max distance in any direction before allowing a lift
_maxZDistance = 8;		//! Definite: max Z distance between chopper and cargo before allowing a lift
_minZDistance = 4;		//! Definite: min Z distance between chopper and cargo before allowing a lift
_maxXYDistance = 3;		//! Definite: max horizontal (X or Y) distance between chopper and cargo before allowing a lift
//_cargoMaxHeight = 10;		//! Definite: max Z height above ground that cargo can be lifted (so cargo must be on ground to lift)
_cargoAttachZDistance = -6;	//! Definite: Z distance from the chopper to attach the cargo

_validCargoTypes = ["AllVehicles"];						    //! Definite: valid base cargo types. use the broadest category here.
_forbiddenCargoTypes = ["Helicopter", "C130J", "MV22"];	    //! Definite: array of forbidden cargos. Used to prevent valid cargo's sub-types from being lifted. Will give a warning message that lifting not permitted
_ignoredCargoTypes = ["Man"];	//! Definite: cargo types that will be ignored when getting vehicles. These types won't give a warning message, it will behave as if they aren't there at all

//! Definite: start attach detection

_chopper = vehicle player;	//! Definite: get vehicle

//! Definite: make sure calling player is still in a vehicle, and is the driver
if((_chopper != player) && (driver _chopper == player)) then 
{
	//! Definite: check that this vehicle doesn't already have a vehicle cargo attached
	_cargoAttached = _chopper getVariable "vehicleCargoAttached";

	//! Definite: if variable does not exist, set to false
	if(isnil "_cargoAttached") then { _cargoAttached = 0; };

	//! Definite: only continue if nothing already attached
	if(_cargoAttached == 0) then
	{
		//! Definite: get nearest valid cargos. these will be sorted by distance
		_cargoArray = nearestObjects [_chopper, _validCargoTypes, (_maxLiftDistance * 2)];	

		_cargo = objNull;

		//! Definite: iterate through array of found objects
		if(true) then
		{
		    scopeName "vehicleFound";
		    {
				//! Definite: check that found cargo isn't the lift chopper itself
				if(_x != _chopper) then
				{
					//! Definite: make sure cargo isn't in the ignore list. here's hoping that nested loops work
					_ignoredCargo = 0;

					//! Definite: use a for loop since can't use nested forEach loops
					for [{_i = 0}, {_i < count _ignoredCargoTypes}, {_i = _i + 1}] do
					{
						//! Definite: if current found object is in the ignored cargo list, flag as ignored
						if(_x isKindOf (_ignoredCargoTypes select _i)) then
						{
							_ignoredCargo = 1;
						};
					};

					//! Definite: confirm an ignore cargo was not found
					if(_ignoredCargo == 0) then
					{
						_cargo = _x;		//! Definite: If non-ignored vehicle found, set this as cargo

						breakOut "vehicleFound";	//! Definite: break out of the loop
					};
				};
		    }
		    forEach _cargoArray;
 		};

		//! Definite: check that cargo exists
		if(!(isNull _cargo)) then
		{
			//! Definite: check that cargo does not exist in the forbiden cargo subtype array
			_invalidCargo = 0;
			//if(true) then
			{
				if(_cargo isKindOf _x) then
				{
					_invalidCargo = 1;
				};
			}
			forEach _forbiddenCargoTypes;

			//! Definite: check that found cargo is not forbidden
			if(_invalidCargo == 0) then
			{
				//! Definite: check that chopper and lift cargo are within _minLiftDistance units apart
				if(_chopper distance _cargo <= _maxLiftDistance) then
				{
					//! Definite: get chopper and cargo positions to perform more details comparisons
					_cargopos = getposATL _cargo;
					_cargoX = _cargopos select 0;
					_cargoY = _cargopos select 1;
					_cargoZ = _cargopos select 2;

					//! Definite: check that cargo is below max height (from ground). This ensures cargo is on or close to ground before allowing lifting
					//if(_cargoZ <= _cargoMaxHeight) then
					if(true) then	//! Definite: removed cargo height restriction since it is based on height from terrain. this prevents being able to pick up boats if enabled
					{
						_chopperpos = getposATL _chopper;
						_chopperX = _chopperpos select 0;
						_chopperY = _chopperpos select 1;
						_chopperZ = _chopperpos select 2;

						//! Definite: check horizontal/vertical distances between chopper and cargo
						_chopperCargoXDistance = _chopperX - _cargoX;
						_chopperCargoYDistance = _chopperY - _cargoY;
						_chopperCargoXDistanceABS = abs _chopperCargoXDistance;		//! Definite: absolute value since relative isn't important in horizontal direction
						_chopperCargoYDistanceABS = abs _chopperCargoYDistance;
						_chopperCargoZDistance = _chopperZ - _cargoZ;			//! Definite: not using absolute value since chopper must be ABOVE cargo
						  
						//! Definite: check cargo is within specified distances from the chopper
						if((_chopperCargoXDistanceABS <= _maxXYDistance) && (_chopperCargoYDistanceABS <= _maxXYDistance)) then
						{
						    if(_chopperCargoZDistance >= _minZDistance) then
						    {
							if(_chopperCargoZDistance <= _maxZDistance) then
							{
								//! Definite: attach the vehicle to the chopper
								_cargo attachTo [_chopper, [0,0,_cargoAttachZDistance]];	

								//! Definite: set variable on vehicle to record attachment
								_chopper setVariable ["vehicleCargoAttached", 1, true];

								//! Definite: record which vehicle has been attached
								_chopper setVariable ["vehicleCargo", _cargo, true];

								//! Definite: alert the vehicle that attach succeeded
								vehicle player vehicleChat "Vehicle lifted";	
							}
							else
							{
								//! Definite: alert vehicle too far away
								vehicle player vehicleChat "Move closer to lift vehicle";
							};
						    }
						    else
						    {
							vehicle player vehicleChat "Too close to lift vehicle";
						    };
						}
						else
						{
						    //! Definite: alert vehicle too far away
						    vehicle player vehicleChat "Move closer to lift vehicle";
						};
					}
					else
					{
						//! Definite: alert vehicle must be on ground to lift
						vehicle player vehicleChat "Vehicle must be on ground to lift";
					};
				}
				else
				{
					//! Definite: alert vehicle too far away
					vehicle player vehicleChat "Vehicle too far away to lift";
				};
			}
			else
			{
				//! Definite: alert invalid cargo type
				vehicle player vehicleChat "Cannot lift this type of vehicle";	
			};
		}
		else
		{
			//! Definite: warn that no liftable vehicle found in range
			vehicle player vehicleChat "No liftable vehicle found in range";	
		};
	}
	else
	{
		//! Definite: warn that a vehicle is already attached
		vehicle player vehicleChat "Already carrying a vehicle";
	};
}
else
{
	//! Definite: might want to put a "you must be the driver to use this" warning here
    //vehicle player vehicleChat "Error: (_chopper == player) || (driver _chopper != player)";
};


