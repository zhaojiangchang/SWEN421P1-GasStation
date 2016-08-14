with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with sPrint;
package body PUMP_UNIT.Test is
   use all type PUMP.FUEL_TYPES;

   UNIT_1 : PUMP_UNIT;
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

   CAR_TANK_SPACE: PUMP.FLOAT_NUMBER;
   AMOUNT_TO_FILL: PUMP.FLOAT_NUMBER;

   type FLOAT_NUMBER is delta 0.01 digits 10;

   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      New_Line;
      Put_Line ("Set up case ..");
      U91 :=PUMP.FUEL_TYPES'Val(F_U91);
      U95 :=PUMP.FUEL_TYPES'Val(F_U95);
      Diesel :=PUMP.FUEL_TYPES'Val(F_Diesel);
      SET_UNIT_ID(UNIT_1,"UNIT_1");
       --set initial car condition
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;
--        ADD_PUMP(UNIT_1,UNIT_1_91, U91);
--        ADD_PUMP(UNIT_1,UNIT_1_95, U95);
--        ADD_PUMP(UNIT_1, UNIT_1_Diesel,Diesel);
--        --pumps
--        UNIT_1_91:= GET_PUMP(UNIT_1,U91);
--        UNIT_1_95:= GET_PUMP(UNIT_1,U95);
--        UNIT_1_Diesel:= GET_PUMP(UNIT_1,Diesel);
   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");

   end;

   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");

      UNIT_1.IS_USING:=False;
      UNIT_1.IS_PAID:=True;
      UNIT_1.TO_PAY:= 0.00;
      UNIT_1.PUMPED:=0.00;
      UNIT_1.PUMP_ACTIVE_FUEL:= PUMP.U91;
      UNIT_1.PUMP_ACTIVE_STATE:= PUMP.Base;
      UNIT_1.PUMP_NOZZLE_STATE:= PUMP.NozzleBase;
      UNIT_1_91.NOZZLE_STATE:= PUMP.NozzleBase;
      UNIT_1_91.PUMP_STATE:=PUMP.Base;
      UNIT_1_91.FUEL_TYPE:= PUMP.U91;
      UNIT_1_91.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_91.PUMPED:= 0.00;
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;


   end;

   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");
      UNIT_1.IS_USING:=False;
      UNIT_1.IS_PAID:=True;
      UNIT_1.TO_PAY:= 0.00;
      UNIT_1.PUMPED:=0.00;
      UNIT_1.PUMP_ACTIVE_FUEL:= PUMP.U91;
      UNIT_1.PUMP_ACTIVE_STATE:= PUMP.Base;
      UNIT_1.PUMP_NOZZLE_STATE:= PUMP.NozzleBase;
      UNIT_1_91.NOZZLE_STATE:= PUMP.NozzleBase;
      UNIT_1_91.PUMP_STATE:=PUMP.Base;
      UNIT_1_91.FUEL_TYPE:= PUMP.U91;
      UNIT_1_91.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_91.PUMPED:= 0.00;
     CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;
   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

--     procedure Test_AddPump (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        ADD_PUMP(UNIT_1,UNIT_1_91, U91);
--
--        Assert (Condition => (GET_TANKS_SIZE(UNIT_1.PUMP_91) = 1000.00),
--                Message => "Did not add pump to pump unit");
--     end Test_AddPump;

   procedure Test_AddPump (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      ADD_PUMP(UNIT_1,UNIT_1_91, U91);
      ADD_PUMP(UNIT_1,UNIT_1_95, U95);
      ADD_PUMP(UNIT_1, UNIT_1_Diesel,Diesel);

      Assert (Condition => (GET_TANKS_SIZE(UNIT_1.PUMP_95) = 1000.00),
              Message => "Did not add  95 pump to pump unit");
      Assert (Condition => (GET_TANKS_SIZE(UNIT_1.PUMP_91) = 1000.00),
              Message => "Did not add 91 pump to pump unit");
      Assert (Condition => (GET_TANKS_SIZE(UNIT_1.PUMP_Diesel) = 1000.00),
              Message => "Did not add diesel pump to pump unit");
   end Test_AddPump;

   procedure Test_LEFT_NOZZLE (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is

   begin
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      Assert (Condition => (UNIT_1.PUMP_NOZZLE_STATE) = PUMP.Lift,
              Message => "did not left U91 nozzle");
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "91 pump sate suppose ready");
      START_PUMPING(UNIT_1,UNIT_1_91,2.00, CAR_TANK_SPACE);
      RETURN_NOZZLE(UNIT_1, UNIT_1_91);
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "91 pump sate suppose ready state");
--        START_PUMPING(UNIT_1,UNIT_1_91,1.00, CAR_TANK_SPACE);
--        LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
--        Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Base,
--                 Message => "Assertion test fails - as planned");

   end Test_LEFT_NOZZLE;

    procedure Test_RETURN_NOZZLE (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      RETURN_NOZZLE(UNIT_1, UNIT_1_91);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Base,
               Message => "91 pump sate suppose base state");
--        RETURN_NOZZLE(UNIT_1,UNIT_1_95);
--         Assert (Condition => (UNIT_1_95.PUMP_STATE) = PUMP.Ready,
--                 Message => "Assertion test fails - as planned");

   end Test_RETURN_NOZZLE;

       procedure Test_START_PUMPING_C1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 4.00;
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 1.00;
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "sensor true add 1.00");
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 4.00;
      CAR_TANK_SPACE := 1.00;
      AMOUNT_TO_FILL := 3.00;
      START_PUMPING(UNIT_1,UNIT_1_91,3.00, CAR_TANK_SPACE);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "car tank full");
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 1.00;
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 2.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "tank empty");
   end Test_START_PUMPING_C1;

   procedure Test_START_PUMPING_C2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 10.00;
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 0.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);

      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "support car tank full");
       UNIT_1_91.RESERVOIR_INFO.TOTAL:= 2.00;
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 0.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "support tank empty");
   end Test_START_PUMPING_C2;

   procedure Test_STOP_PUMPING (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 10.00;
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 0.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
       Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
               Message => "should stop pumping");

   end Test_STOP_PUMPING;

   procedure Test_SET_GET (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      temp: Boolean;
      temp_State: PUMP.STATE_TYPE;
      temp_Pump: PUMP.PUMP;
   begin
      SET_PUMPED(UNIT_1, 100.00);
      SET_TO_PAY(UNIT_1,3.00);
      UNIT_1_91.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_95.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_Diesel.RESERVOIR_INFO.TOTAL:=1000.00;
      temp_Pump:=GET_PUMP(UNIT_1,U91);
      temp_Pump:=GET_PUMP(UNIT_1,U95);
      temp_Pump:=GET_PUMP(UNIT_1,Diesel);
       Assert (Condition => (  GET_TANKS_SIZE(UNIT_1,U91)) = 1000.00,
               Message => "get ");
       Assert (Condition => (  GET_TANKS_SIZE(UNIT_1,U95)) = 1000.00,
               Message => "get ");
       Assert (Condition => (  GET_TANKS_SIZE(UNIT_1,Diesel)) = 1000.00,
               Message => "get ");
       Assert (Condition => ( GET_ID(UNIT_1)) = "UNIT_1",
               Message => "get ");
       Assert (Condition => (  GET_TO_PAY(UNIT_1)) = 3.00,
               Message => "get ");
       Assert (Condition => (  GET_PUMPED(UNIT_1)) = 100.00,
               Message => "get ");
       Assert (Condition => (  GET_FUEL(UNIT_1)) = U91,
               Message => "get ");
         Assert (Condition => (  GET_PUMP_NOZZLE_STATE(UNIT_1)) = PUMP.NozzleBase,
               Message => "get ");
      SET_IS_USING(UNIT_1);
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.PUMP_STATE:= PUMP.Ready;
      SET_IS_USING(UNIT_1);
      UNIT_1.IS_PAID := False;
      SET_IS_PAID(UNIT_1);
      UNIT_1.IS_PAID := True;
      SET_IS_PAID(UNIT_1);
      SET_PUMP_ACTIVE_STATE(UNIT_1,U91,PUMP.Base);
      SET_PUMP_ACTIVE_STATE(UNIT_1,U95,PUMP.Base);
      SET_PUMP_ACTIVE_STATE(UNIT_1,Diesel,PUMP.Base);

      SET_PUMP_NOZZLE_STATE(UNIT_1,U91,PUMP.NozzleBase);
      SET_PUMP_NOZZLE_STATE(UNIT_1,U95,PUMP.NozzleBase);
      SET_PUMP_NOZZLE_STATE(UNIT_1,Diesel,PUMP.NozzleBase);

      temp := UNIT_IS_USING(UNIT_1);
      temp := UNIT_IS_PAID(UNIT_1);
      temp_State := GET_PUMP_UNIT_STATE(UNIT_1);

   end Test_SET_GET;
   --
   --
--     procedure Test_Secial_Addition (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        I1 := 1;
--        I2 := 1;
--        I1 := I1 + I2;
--        Assert (Condition => (I1 = Expected_3),
--                Message => "Incorrect result after addition");
--     end Test_Secial_Addition;
--
--     procedure Test_Subtraction (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        Assert(Condition => (I1 - I2 = Expected_2),
--               Message => "Incorrect result after subtraction");
--     end Test_Subtraction;
--
--     procedure Test_Multiplication (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        I1 := 2;
--        I2 := 4;
--        Assert(Condition => (I1 * I2 = Expected_1),
--               Message => "Incorrect result after multiplication");
--     end Test_Multiplication;
--
--     procedure Test_Devision (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        I1 := 32;
--        I2 := 4;
--        Assert(Condition => (I1 / I2 = Expected_1),
--               Message => "Incorrect result after multiplication");
--     end Test_Devision;
--
--     procedure Test_Addition_Failure (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        Assert (Condition => (I1 + I2 = I2),
--                Message => "Assertion test fails - as planned");
--     end Test_Addition_Failure;
--
--   procedure Test_Addition_Exception (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
--      procedure Test_Raising_Exception is
--      begin
--         I1 := 55;
--         I2 := 55;
--         I1 := I1 + I2;
--      end;
--
--
--   begin
--        Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,  --needs unrestricted access so that it can be seen
--                          Message =>"An Exception should be raised");          -- this is due to it being a sub procedure and not in ads
--   end Test_Addition_Exception;
--
--     procedure Test_Addition_Error (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
--     begin
--        I1 := 55;
--        I2 := 55;
--        Assert (Condition => (I1 + I2 = I3),
--                Message => "This message will NOT be reported");
--     end Test_Addition_Error;
--
--
--     --==========================================================
--     --               REGISTRATION/NAMING
--     --==========================================================
--
   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Test_AddPump'Access,
                        Name => "Test_AddPump");
      Register_Routine (Test => T,
                        Routine => Test_LEFT_NOZZLE'Access,
                        Name => "Test_LEFT_NOZZLE");
      Register_Routine (Test => T,
                        Routine => Test_RETURN_NOZZLE'Access,
                        Name => "Test_RETURN_NOZZLE");
      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C1'Access,
                        Name => "Test_START_PUMPING_C1");
      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C2'Access,
                        Name => "Test_START_PUMPING_C2");
      Register_Routine (Test => T,
                        Routine => Test_STOP_PUMPING'Access,
                        Name => "Test_STOP_PUMPING");
       Register_Routine (Test => T,
                        Routine => Test_SET_GET'Access,
                         Name => "Test_SET_GET");
      --        Register_Routine (Test => T,
--                          Routine => Test_Addition'Access,
--                          Name => "Test_Special_Addition");
--
--        Register_Routine (Test => T,
--                          Routine => Test_Subtraction'Access,
--                          Name => "Test_Subtraction");
--
--          Register_Routine (Test => T,
--                            Routine => Test_Multiplication'Access,
--                            Name => "Test_Multiplication");
--
--
--        Register_Routine (Test => T,
--                          Routine => Test_Devision'Access,
--                          Name => "Test_Devision");
--
--        Register_Routine (Test => T,
--                          Routine => Test_Addition_Failure'Access,
--                          Name => "Test_Addition_Failure");
--
--      Register_Routine (Test => T,
--                        Routine => Test_Addition_Exception'Access,
--                        Name => "Test_Addition_Exception");
--
--        Register_Routine (Test => T,
--                          Routine => Test_Addition_Error'Access,
--                          Name => "Test_Addition_Error");
   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end PUMP_UNIT.Test;
