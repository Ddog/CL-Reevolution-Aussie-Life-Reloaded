 // This script is for refuelling a vehicle //

 _art = _this select 0;
 _vcl	= vehicle player;
 _item 	= _this select 1;
if (_art == "use") then 
 {
  _item = _this select 1;
_anzahl = _this select 2;
    if (player == vehicle player)  exitWith {
player groupChat localize "STRS_inv_items_repair_refuel_notincar";
};

//if(_vcl iskindof "LandVehicle" or _vcl iskindof "Air" and (_item == "kanister"))exitwith{player groupchat "you must go to a fuel servo!"};

   if (!(player == driver vehicle player)) exitWith {
player groupChat localize "STRS_inv_items_repair_refuel_notdriver";
};

    if ((fuel vehicle player) == 1)  exitWith {
player groupChat localize "STRS_inv_items_refuel_notneeded";
};

player groupchat "Refueling Vehicle!";
[_item, -1] call INV_AddInventoryItem;
sleep 15;

vehicle player setFuel 1;
player groupChat localize "STRS_inv_items_refuel_refueled";
};

