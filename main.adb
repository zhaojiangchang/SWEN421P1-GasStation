with PUMP;
with PUMP_UNIT;
with sPrint; use sPrint;
procedure Main is
   package UNIT is new PUMP_UNIT;
   use all type UNIT.P.STATE_TPYE;
   use all type UNIT.P.FUEL_TYPES;
   --use all type UNIT.P.NOZZLE_TYPE;
   pumpStateType: UNIT.P.STATE_TPYE;
  -- nozzleStateType: UNIT.P.NOZZLE_TYPE;
   --records
   UNIT_1 : UNIT.PUMP_UNIT;

   U91: UNIT.P.FUEL_TYPES;
   U95: UNIT.P.FUEL_TYPES;
   Diesel: UNIT.P.FUEL_TYPES;
 --fuel
   F_U91: Integer :=0;
   F_U95: Integer :=1;
   F_Diesel: Integer :=2;

   --pump state
   Base: Integer := 0;
   Ready: Integer := 1;
   Pumping: Integer := 2;
   Waiting: Integer := 3;
   --nozzle state
   NozzleBase: Integer := 0;
   Left: Integer := 1;
   Replace: Integer := 2;
   Start: Integer := 3;
   Stop : Integer := 4;
   Pay: Integer:=5;

   tankSize : UNIT.P.TANK_SIZE;
begin
   U91 :=UNIT.P.FUEL_TYPES'Val(F_U91);
   U95 :=UNIT.P.FUEL_TYPES'Val(F_U95);
   Diesel :=UNIT.P.FUEL_TYPES'Val(F_Diesel);
   -- add pumps
   UNIT.ADD_PUMP(UNIT_1, U91);
   UNIT.ADD_PUMP(UNIT_1, U95);
   UNIT.ADD_PUMP(UNIT_1, Diesel);

   --TEST GET TANK 91 SIZE
   tankSize := UNIT.GET_TANKS_SIZE(UNIT_1,U91);
   print("Test current tank size: "&tankSize'Image);
   --TEST SET PUMP SATE TO BASE
   pumpStateType := UNIT.P.STATE_TPYE'val(Base);
   UNIT.SET_PUMP_ACTIVE(UNIT_1, U91, pumpStateType);



end Main;
