with PUMP;
with PUMP_UNIT;
with sPrint; use sPrint;
with Ada.Text_IO; use Ada.Text_IO;
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

   --tankSize : UNIT.P.FLOAT_NUMBER;
   ---------------------------------------
   -- PUMP_UNIT_ID  ----------------------
   ---------------------------------------
   type PUMP_UNIT_ID is
      record
         ID:UNIT.UNIT_ID_TYPE;
         TO_PAY : UNIT.P.FLOAT_NUMBER;
         PUMPED :UNIT.P.FLOAT_NUMBER;
         FUEL: UNIT.P.FUEL_TYPES;
      end record;
   ---------------------------------------
   -- CASH_REGISTER  ---------------------
   ---------------------------------------
   type CASH_REGISTER is
      record

         UNIT_1: PUMP_UNIT_ID;
      end record;
   cashRegister: CASH_REGISTER;
   ---------------------------------------
   -- payFuel  ----------------------------
   ---------------------------------------
   procedure payFuel (pumpUnit: in out UNIT.PUMP_UNIT; pump_r: in out UNIT.P.PUMP; AMOUNT: in  UNIT.P.FLOAT_NUMBER)is
      id: UNIT.UNIT_ID_TYPE;
      topay: UNIT.P.FLOAT_NUMBER;
      use all type UNIT.P.FLOAT_NUMBER;

   begin

      id := UNIT.GET_ID(pumpUnit);
      topay:= UNIT.GET_TO_PAY(pumpUnit);
      if UNIT.P.STATE_TYPE'Pos(UNIT.GET_PUMP_UNIT_STATE(pumpUnit)) /= UNIT.P.STATE_TYPE'Pos(UNIT.P.STATE_TYPE'Val(3))
        and UNIT.P.NOZZLE_TYPE'Pos(UNIT.GET_PUMP_NOZZLE_STATE(pumpUnit)) /=  UNIT.P.NOZZLE_TYPE'Pos(UNIT.P.NOZZLE_TYPE'Val(5)) then
         print("you need return nozzle or pumping first");
      else


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
      end if;

   end payFuel;
   ---------------------------------------
   -- SET_PUMPED_INFO_TO_CASH_REGISTER  --
   ---------------------------------------
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
   ---------------------------------------
   -- variable----------------------------
   ---------------------------------------

   CAR_TANK_SPACE: UNIT.P.FLOAT_NUMBER;
   AMOUNT_TO_FILL: UNIT.P.FLOAT_NUMBER;
   isTest: Boolean;
   input_unit: String(1..6);
   input_fuel_type: String(1..6);
   input_action: String(1..6);

begin
   --fuel
   U91 :=UNIT.P.FUEL_TYPES'Val(F_U91);
   U95 :=UNIT.P.FUEL_TYPES'Val(F_U95);
   Diesel :=UNIT.P.FUEL_TYPES'Val(F_Diesel);
   -- add pumps
   UNIT.SET_UNIT_ID(UNIT_1,"UNIT_1");
   UNIT.ADD_PUMP(UNIT_1,UNIT_1_91, U91);
   UNIT.ADD_PUMP(UNIT_1,UNIT_1_95, U95);
   UNIT.ADD_PUMP(UNIT_1, UNIT_1_Diesel,Diesel);
   --pumps
   UNIT_1_91:= UNIT.GET_PUMP(UNIT_1,U91);
   UNIT_1_95:= UNIT.GET_PUMP(UNIT_1,U95);
   UNIT_1_Diesel:= UNIT.GET_PUMP(UNIT_1,Diesel);

   --test
   isTest := True;
   if isTest = True then
      print("");
      print("TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST ");
      print("");
      --set initial car condition
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 2.50;
      --test left nozzle and return nozzle
      UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
      UNIT.RETURN_NOZZLE(UNIT_1, UNIT_1_91);
      UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
      --test pumping
      UNIT.START_PUMPING(UNIT_1,UNIT_1_95,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      --test sensor
      UNIT.START_PUMPING(UNIT_1,UNIT_1_91, 0.00, CAR_TANK_SPACE);
      --test if car tank full
      UNIT.START_PUMPING(UNIT_1,UNIT_1_95, 0.00, CAR_TANK_SPACE);
      UNIT.STOP_PUMPING(UNIT_1,UNIT_1_95);
      --send info to cash register
      SET_PUMPED_INFO_TO_CASH_REGISTER(UNIT_1);
      --pay
      payFuel(UNIT_1,UNIT_1_95,UNIT.GET_TO_PAY(UNIT_1));
      payFuel(UNIT_1,UNIT_1_95,50.00);
      print("");
      print("TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST ");
      print("");

   else
      print("SELECT PUMP UNIT (INPUT FORMAT: UNIT_1 )");
      if UNIT.UNIT_IS_USING(UNIT_1) = False then
         print("UNIT_1 is available");
      end if;
      put("Enter: ");
      get(input_unit);
      if input_unit = UNIT.GET_ID(UNIT_1) and UNIT.UNIT_IS_USING(UNIT_1) = False then
         print("SELECT FUEL TYPE (INPUT FORMAT: U91 or U95 or Diesel)");
         put("Enter: ");
         get(input_fuel_type);
         if UNIT.P.FUEL_TYPES'Pos(UNIT.P.FUEL_TYPES'Value(input_fuel_type))>=0 then
            print("input actions: Lift, Replace,Start, Stop, Pay");
            put("Enter: ");
            get(input_action);
            if UNIT.P.NOZZLE_TYPE'Pos(UNIT.P.NOZZLE_TYPE'Value(input_action))>=0 then
               if input_fuel_type = "U91" then
                  UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_91,U91);
               elsif input_fuel_type ="U95" then
                  UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_95, U95);
               elsif input_fuel_type = "Diesel" then
                  UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_Diesel, Diesel);
               end if;
            else
               print("input right action:Lift, Replace,Start, Stop, Pay ");
            end if;


         end if;

      end if;

   end if;
end Main;


