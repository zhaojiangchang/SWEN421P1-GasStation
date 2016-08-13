with PUMP;
with PUMP_UNIT;
with sPrint; use sPrint;
procedure Main is
   package UNIT is new PUMP_UNIT;
   use all type UNIT.P.STATE_TYPE;
   use all type UNIT.P.FUEL_TYPES;

   --records
   UNIT_1 : UNIT.PUMP_UNIT;
   UNIT_1_91: UNIT.P.PUMP;
   UNIT_1_95: UNIT.P.PUMP;
   UNIT_1_Diesel: UNIT.P.PUMP;


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

   CAR_TANK_SPACE: UNIT.P.FLOAT_NUMBER;
   AMOUNT_TO_FILL: UNIT.P.FLOAT_NUMBER;
   --tankSize : UNIT.P.FLOAT_NUMBER;
begin
   --fuel
   U91 :=UNIT.P.FUEL_TYPES'Val(F_U91);
   U95 :=UNIT.P.FUEL_TYPES'Val(F_U95);
   Diesel :=UNIT.P.FUEL_TYPES'Val(F_Diesel);
   -- add pumps
   UNIT.ADD_PUMP(UNIT_1, U91);
   UNIT.ADD_PUMP(UNIT_1, U95);
   UNIT.ADD_PUMP(UNIT_1, Diesel);
   --pumps
   UNIT_1_91:= UNIT.GET_PUMP(UNIT_1,U91);
   UNIT_1_95:= UNIT.GET_PUMP(UNIT_1,U95);
   UNIT_1_Diesel:= UNIT.GET_PUMP(UNIT_1,Diesel);
--     --TEST GET TANK 91 SIZE
--     tankSize := UNIT.GET_TANKS_SIZE(UNIT_1,U91);
--     print("Test current tank size: "&tankSize'Image);
--     --TEST SET PUMP SATE TO BASE
--     pumpStateType := UNIT.P.STATE_TPYE'val(Base);
--     UNIT.SET_PUMP_ACTIVE_STATE(UNIT_1, U91, pumpStateType);

   UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
   UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
   UNIT.RETURN_NOZZLE(UNIT_1, UNIT_1_91);
   UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
   CAR_TANK_SPACE := 70.00;
   AMOUNT_TO_FILL := 50.00;
   UNIT.START_PUMPING(UNIT_1,UNIT_1_95,AMOUNT_TO_FILL, CAR_TANK_SPACE);
   UNIT.START_PUMPING(UNIT_1,UNIT_1_91, 0.00, CAR_TANK_SPACE);
   UNIT.START_PUMPING(UNIT_1,UNIT_1_95, 0.00, CAR_TANK_SPACE);
   UNIT.STOP_PUMPING(UNIT_1,UNIT_1_95);



end Main;
