with Ada.Text_IO; use Ada.Text_IO;
with PUMP;
with PUMP_UNIT;
with sPrint; use sPrint;
procedure Main is
   package UNIT is new PUMP_UNIT;
   use all type UNIT.P.STATE_TPYE;
   pumpStateType: UNIT.P.STATE_TPYE;

   UNIT_1_R : UNIT.PUMP_UNIT_R;
   U91 : UNIT.FUEL_TYPE := 1;
   U95 : UNIT.FUEL_TYPE := 2;
   Diesel : UNIT.FUEL_TYPE := 3;

   Base: Integer := 0;
   Ready: Integer := 1;
   Pumping: Integer := 2;
   Waiting: Integer := 3;


   tankSize : UNIT.P.TANK_SIZE;
begin
   -- add pumps
   UNIT.ADD_PUMP(UNIT_1_R, U91);
   UNIT.ADD_PUMP(UNIT_1_R, U95);
   UNIT.ADD_PUMP(UNIT_1_R, Diesel);
   UNIT.SET_IS_USING(UNIT_1_R);
   UNIT.SET_IS_PAID(UNIT_1_R);

   tankSize := UNIT.GET_TANKS_SIZE(UNIT_1_R,U91);
   print(tankSize'Image);
   pumpStateType := UNIT.P.STATE_TPYE'val(Base);
   UNIT.SET_PUMP_ACTIVE(UNIT_1_R, U91, pumpStateType);
   --print(UNIT.P.GET_STATE(U91);


end Main;
