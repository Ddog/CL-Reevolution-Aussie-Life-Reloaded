//Shit Animation by Hellop modifed and refined for arma2 by Jan templar

_obj = _this select 0;
_obj switchMove "miles_c0briefing_odpovedel_loop6";
_pos = getpos _obj;
_obj say ["FIRE",5];

_PS1 = "#particlesource" createVehicleLocal _pos;
_PS1 setParticleCircle [0, [0, 0, 0]];
_PS1 setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_PS1 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 8,  1, 1, 8], "", "Billboard", 5, 5, [0, 0, 0.4], [0, 0, -0.1], 0, 100, 78.41, 0, [0.1], [[0.15, 0.12, 0.12, 1],  [0.15, 0.13, 0.12, 1], [0.15, 0.12, 0.12, 1]], [0], 0, 0, "", "", _obj];
_PS1 setDropInterval 0.3;

_PS2 = "#particlesource" createVehicleLocal _pos;
_PS2 setParticleCircle [0, [0, 0, 0]];
_PS2 setParticleRandom [0, [0.08, 0.08, 0.01], [0, 0, 0], 0, 0.25, [0, 0, 0, 0.1], 0,  0];
_PS2 setParticleParams [["\Ca\Data\ParticleEffects\Universal\Universal.p3d", 8,  1, 1, 8], "", "Billboard", 5, 13.5, [0, 0, 0.1], [0, 0, 0], 0, 100, 78.43, 0, [0.1], [[0.15, 0.12, 0.12, 1],  [0.15, 0.13, 0.12, 1], [0.15, 0.12, 0.12, 1]], [0], 0, 0, "", "", _obj];
_PS2 setDropInterval 0.3;

sleep 10;
deleteVehicle _PS1;
deleteVehicle _PS2;
deleteVehicle _triggerSoundFire;

_obj switchMove "";