;;;
; Allow blue suit colors to show up under water
;

handle_non_liquid_physics_not_spin_jumping = $91D9EA

org $91D9CF
BRA handle_non_liquid_physics_not_spin_jumping
warnpc $91D9D1
