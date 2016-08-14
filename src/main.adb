with PUMP;
with PUMP_UNIT;
with CASH_REGISTER;
with sPrint; use sPrint;
with Ada.Text_IO; use Ada.Text_IO;
procedure Main is

--     type UNIT is new PUMP_UNIT;
   use all type PUMP.STATE_TYPE;
   use all type PUMP.FUEL_TYPES;

   --records
   UNIT_1 : PUMP_UNIT.PUMP_UNIT;
   UNIT_1_91: PUMP.PUMP;
   UNIT_1_95: PUMP.PUMP;
   UNIT_1_Diesel: PUMP.PUMP;

   U91: PUMP.FUEL_TYPES;
   U95: PUMP.FUEL_TYPES;
   Diesel: PUMP.FUEL_TYPES;
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

   --tankSize : PUMP.FLOAT_NUMBER;

   ---------------------------------------
   -- variable----------------------------
   ---------------------------------------

   CAR_TANK_SPACE: PUMP.FLOAT_NUMBER;
   AMOUNT_TO_FILL: PUMP.FLOAT_NUMBER;
   isTest: Boolean;
   input_unit: String(1..6);
   input_fuel_type: String(1..6);
   input_action: String(1..6);

begin
   --fuel
   U91 :=PUMP.FUEL_TYPES'Val(F_U91);
   U95 :=PUMP.FUEL_TYPES'Val(F_U95);
   Diesel :=PUMP.FUEL_TYPES'Val(F_Diesel);
   -- add pumps
   PUMP_UNIT.SET_UNIT_ID(UNIT_1,"UNIT_1");
   PUMP_UNIT.ADD_PUMP(UNIT_1,UNIT_1_91, U91);
   PUMP_UNIT.ADD_PUMP(UNIT_1,UNIT_1_95, U95);
   PUMP_UNIT.ADD_PUMP(UNIT_1, UNIT_1_Diesel,Diesel);
   --pumps
   UNIT_1_91:= PUMP_UNIT.GET_PUMP(UNIT_1,U91);
   UNIT_1_95:= PUMP_UNIT.GET_PUMP(UNIT_1,U95);
   UNIT_1_Diesel:= PUMP_UNIT.GET_PUMP(UNIT_1,Diesel);

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
--        PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
--        PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
--        PUMP_UNIT.RETURN_NOZZLE(UNIT_1, UNIT_1_91);
      PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_95,U95);
      --test pumping
      PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_95,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      --test sensor
--        PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91, 0.00, CAR_TANK_SPACE);
      --test if car tank full
      PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_95, 0.00, CAR_TANK_SPACE);
      PUMP_UNIT.RETURN_NOZZLE(UNIT_1,UNIT_1_95);
      --        PUMP_UNIT.STOP_PUMPING(UNIT_1,UNIT_1_95);
      --send info to cash register
      CASH_REGISTER.SET_PUMPED_INFO_TO_CASH_REGISTER(UNIT_1);
      --pay
      CASH_REGISTER.payFuel(UNIT_1,UNIT_1_95,PUMP_UNIT.GET_TO_PAY(UNIT_1));
      CASH_REGISTER.payFuel(UNIT_1,UNIT_1_95,50.00);
      print("");
      print("TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST ");
      print("");

   else
      print("SELECT PUMP UNIT (INPUT FORMAT: UNIT_1 )");
      if PUMP_UNIT.UNIT_IS_USING(UNIT_1) = False then
         print("UNIT_1 is available");
      end if;
      put("Enter: ");
      get(input_unit);
      if input_unit = PUMP_UNIT.GET_ID(UNIT_1) and PUMP_UNIT.UNIT_IS_USING(UNIT_1) = False then
         print("SELECT FUEL TYPE (INPUT FORMAT: U91 or U95 or Diesel)");
         put("Enter: ");
         get(input_fuel_type);
         if PUMP.FUEL_TYPES'Pos(PUMP.FUEL_TYPES'Value(input_fuel_type))>=0 then
            print("input actions: Lift, Replace,Start, Stop, Pay");
            put("Enter: ");
            get(input_action);
            if PUMP.NOZZLE_TYPE'Pos(PUMP.NOZZLE_TYPE'Value(input_action))>=0 then
               if input_fuel_type = "U91" then
                  PUMP_UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_91,U91);
               elsif input_fuel_type ="U95" then
                  PUMP_UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_95, U95);
               elsif input_fuel_type = "Diesel" then
                  PUMP_UNIT.LEFT_NOZZLE(UNIT_1, UNIT_1_Diesel, Diesel);
               end if;
            else
               print("input right action:Lift, Replace,Start, Stop, Pay ");
            end if;


         end if;

      end if;

   end if;
end Main;


