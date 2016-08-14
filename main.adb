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

   type FLOAT_NUMBER is delta 0.01 digits 10;
   CAR_TANK_SPACE: UNIT.P.FLOAT_NUMBER;
   AMOUNT_TO_FILL: UNIT.P.FLOAT_NUMBER;
   --tankSize : UNIT.P.FLOAT_NUMBER;
    type PUMP_UNIT_ID is
      record
         ID:UNIT.UNIT_ID_TYPE;
         TO_PAY : UNIT.P.FLOAT_NUMBER;
         PUMPED :UNIT.P.FLOAT_NUMBER;
         FUEL: UNIT.P.FUEL_TYPES;
      end record;
   type CASH_REGISTER is
      record

         UNIT_1: PUMP_UNIT_ID;
         UNIT_2: PUMP_UNIT_ID;
      end record;
   cashRegister: CASH_REGISTER;
   procedure payFuel (pumpUnit: in out UNIT.PUMP_UNIT; pump_r: in out UNIT.P.PUMP; AMOUNT: in  UNIT.P.FLOAT_NUMBER)is
      id: UNIT.UNIT_ID_TYPE;
      topay: UNIT.P.FLOAT_NUMBER;
      use all type UNIT.P.FLOAT_NUMBER;
   begin
      id:= UNIT.GET_ID(pumpUnit);
      topay:= UNIT.GET_TO_PAY(pumpUnit);
      print("Pay for: "&cashRegister.UNIT_1.ID);
      print("Amount to pay: "&topay'Image&"   Actual amount given: "&AMOUNT'Image);
      if id = cashRegister.UNIT_1.ID  and UNIT.GET_TO_PAY(pumpUnit) /= 0.00 then
         if AMOUNT = topay then
            print("paid for UNIT_1:  " & AMOUNT'Image);
            cashRegister.UNIT_1.TO_PAY:= 0.00;
            cashRegister.UNIT_1.PUMPED:=0.00;
            UNIT.P.SET_PUMP_STATE(pump_r,UNIT.P.STATE_TYPE'Val(0));
            UNIT.P.SET_PUMPED(pump_r,0.00);
            UNIT.SET_IS_PAID(pumpUnit);
            UNIT.SET_PUMPED(pumpUnit, 0.00);
            UNIt.SET_TO_PAY(pumpUnit,0.00);

            --              UNIT.PUMP_UNIT

         else
            print("amount not equal");

         end if;
      elsif UNIT.GET_TO_PAY(pumpUnit) = 0.00 then
            print("already paid");
      end if;
   end payFuel;

   procedure SET_PUMPED_INFO_TO_CASH_REGISTER
     (pumpUnit: in out UNIT.PUMP_UNIT)
   is
      topay: UNIT.P.FLOAT_NUMBER;
      pumpUnitId: PUMP_UNIT_ID;
   begin
      topay:= UNIT.GET_TO_PAY(pumpUnit);
      pumpUnitId.ID :=UNIT.GET_ID(pumpUnit);
      pumpUnitId.TO_PAY := topay;
      pumpUnitId.PUMPED := UNIT.GET_PUMPED(pumpUnit);
      pumpUnitId.FUEL := UNIT.GET_FUEL(pumpUnit);
      cashRegister.UNIT_1 := pumpUnitId;
      print("set pumpunit value to cash regesiter");
   end SET_PUMPED_INFO_TO_CASH_REGISTER;
begin
   --fuel
   U91 :=UNIT.P.FUEL_TYPES'Val(F_U91);
   U95 :=UNIT.P.FUEL_TYPES'Val(F_U95);
   Diesel :=UNIT.P.FUEL_TYPES'Val(F_Diesel);
   -- add pumps
   UNIT.SET_UNIT_ID(UNIT_1,"UNIT_1");
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
   SET_PUMPED_INFO_TO_CASH_REGISTER(UNIT_1);
   payFuel(UNIT_1,UNIT_1_95,UNIT.GET_TO_PAY(UNIT_1));
   payFuel(UNIT_1,UNIT_1_95,50.00);

end Main;


