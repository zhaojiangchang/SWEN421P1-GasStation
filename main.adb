with Ada.Text_IO; use Ada.Text_IO;
with PUMP;
with PUMP_UNIT;
with sPrint; use sPrint;
procedure Main is
   package UNIT is new PUMP_UNIT;

   UNIT_R : UNIT.PUMP_UNIT_R;
   U91 : UNIT.FUEL_TYPE := 1;
   U95 : UNIT.FUEL_TYPE := 2;
   Diesel : UNIT.FUEL_TYPE := 3;
   tankSize : UNIT.P.TANK_SIZE;
begin
   -- add pumps
   UNIT.ADD_PUMP(UNIT_R, U91);
   UNIT.ADD_PUMP(UNIT_R, U95);
   UNIT.ADD_PUMP(UNIT_R, Diesel);
   UNIT.SET_IS_USING(UNIT_R);
   UNIT.SET_IS_PAID(UNIT_R);

   tankSize := UNIT.GET_TANKS_SIZE(UNIT_R,U91);
   print(tankSize'Image);


end Main;
