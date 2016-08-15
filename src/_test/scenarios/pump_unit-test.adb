with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with sPrint; use sPrint;
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
   TANK_SPACE: PUMP.FLOAT_NUMBER;

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
      TANK_SPACE:=5.00;

   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");
      U91 :=PUMP.FUEL_TYPES'Val(F_U91);
      U95 :=PUMP.FUEL_TYPES'Val(F_U95);
      Diesel :=PUMP.FUEL_TYPES'Val(F_Diesel);
      SET_UNIT_ID(UNIT_1,"UNIT_1");
      --set initial car condition
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;
      TANK_SPACE:=5.00;
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


   procedure Test_AddPump (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test add pump");
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
      Put_Line("");
      Put_Line("test left nozzle");
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      Assert (Condition => (UNIT_1.PUMP_NOZZLE_STATE) = PUMP.Lift,
              Message => "did not left U91 nozzle");
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "91 pump sate suppose ready");
      SET_RESERVOIR_SIZE(UNIT_1_91, 1.00);
      CAR_TANK_SPACE := 0.20;
      AMOUNT_TO_FILL := 0.40;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      RETURN_NOZZLE(UNIT_1, UNIT_1_91);
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "91 pump sate suppose ready state");
      --        START_PUMPING(UNIT_1,UNIT_1_91,1.00, CAR_TANK_SPACE);
      --        LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      --        Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Base,
      --                 Message => "Assertion test fails - as planned");

   end Test_LEFT_NOZZLE;

   procedure Test_LiftNozzleException (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin

         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"An Exception should be raised can not lift nozzle twice");
   end Test_LiftNozzleException;

   procedure Test_RETURN_NOZZLE (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("test return nozzle");
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      RETURN_NOZZLE(UNIT_1, UNIT_1_91);
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Base,
              Message => "91 pump sate suppose base state");
      --        RETURN_NOZZLE(UNIT_1,UNIT_1_95);
      --         Assert (Condition => (UNIT_1_95.PUMP_STATE) = PUMP.Ready,
      --                 Message => "Assertion test fails - as planned");

   end Test_RETURN_NOZZLE;


   procedure Test_ReturnNozzleException (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         RETURN_NOZZLE(UNIT_1, UNIT_1_91);
         RETURN_NOZZLE(UNIT_1, UNIT_1_95);

      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"you are not supports not to use this nozzle other nozzle currently in use");
   end Test_ReturnNozzleException;

   procedure Test_START_PUMPING_C1_SENSOR (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test_START_PUMPING_C1_SENSOR");
      SET_RESERVOIR_SIZE(UNIT_1_91, 1.00);
      CAR_TANK_SPACE := 0.50;
      AMOUNT_TO_FILL := 0.20;
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "sensor true add 1.00");
   end Test_START_PUMPING_C1_SENSOR;

   procedure Test_START_PUMPING_C1_Car_tank_full (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test_START_PUMPING_C1_Car_tank_full");
      SET_RESERVOIR_SIZE(UNIT_1_91, 1.00);
      CAR_TANK_SPACE := 0.20;
      AMOUNT_TO_FILL := 0.40;
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "car tank full");
   end Test_START_PUMPING_C1_Car_tank_full;
   procedure Test_START_PUMPING_C1_tank_empty (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test_START_PUMPING_C1_tank_empty");
      SET_RESERVOIR_SIZE(UNIT_1_91, 0.30);
      CAR_TANK_SPACE := 3.00;
      AMOUNT_TO_FILL := 2.00;
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      Assert (Condition => (GET_TANKS_SIZE(UNIT_1_91))<=1.00E-02,
              Message => "tank empty");

   end Test_START_PUMPING_C1_tank_empty;
   procedure Test_StartPumpingException_tanksize_empty (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         Put_Line("");
         Put_Line("Test_StartPumpingException_tanksize_empty");
         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         TANK_SPACE:= -0.01;
         PUMP.SET_RESERVOIR_SIZE(UNIT_1_91, TANK_SPACE);
         START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"tank empty");
   end Test_StartPumpingException_tanksize_empty;

   procedure Test_StartPumpingException_car_tank_full (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         Put_Line("");
         Put_Line("Test_StartPumpingException_car_tank_full");
         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         PUMP.SET_RESERVOIR_SIZE(UNIT_1_91, 10.00);
         CAR_TANK_SPACE:=0.00;
         START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"car tank full");
   end Test_StartPumpingException_car_tank_full;

   procedure Test_StartPumpingException_pump_not_ready (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"pump not ready");
   end Test_StartPumpingException_pump_not_ready;

   procedure Test_START_PUMPING_C2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test_START_PUMPING_C2");
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 1.00;
      CAR_TANK_SPACE := 0.50;
      AMOUNT_TO_FILL := 0.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);

      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "support car tank full");

   end Test_START_PUMPING_C2;

   procedure Test_START_PUMPING_C2_tank_empty (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      Put_Line("");
      Put_Line("Test_START_PUMPING_C2");
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.RESERVOIR_INFO.TOTAL:= 0.10;
      CAR_TANK_SPACE := 0.50;
      AMOUNT_TO_FILL := 0.00;
      START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);

      Assert (Condition => (UNIT_1_91.PUMP_STATE) = PUMP.Ready,
              Message => "support tank full");

   end Test_START_PUMPING_C2_tank_empty;

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
   procedure Test_StopPumpingException (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         STOP_PUMPING(UNIT_1,UNIT_1_91);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"only can stop pumping after pumping");
   end Test_StopPumpingException;
   procedure Test_SET_GET (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      temp: Boolean;
      temp_State: PUMP.STATE_TYPE;
      temp_Pump: PUMP.PUMP;
   begin

      SET_PUMPED(UNIT_1, 100.00);
      Assert (Condition => (  UNIT_1.PUMPED) = 100.00,
              Message => "get ");

      SET_TO_PAY(UNIT_1,3.00);
      Assert (Condition => (  UNIT_1.TO_PAY) = 3.00,
              Message => "get ");

      UNIT_1_91.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_95.RESERVOIR_INFO.TOTAL:=1000.00;
      UNIT_1_Diesel.RESERVOIR_INFO.TOTAL:=1000.00;

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

      UNIT_1.IS_PAID := False;
      SET_IS_PAID(UNIT_1);
      Assert (Condition => (  UNIT_1.IS_PAID) = True,
              Message => "get ");
      UNIT_1.IS_PAID := True;
      SET_IS_PAID(UNIT_1);
      Assert (Condition => (  UNIT_1.IS_PAID) = False,
              Message => "get ");


      SET_IS_USING(UNIT_1);
       Assert (Condition => (  UNIT_1.IS_USING) = False,
              Message => "get ");
      LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      UNIT_1_91.PUMP_STATE:= PUMP.Ready;
      SET_IS_USING(UNIT_1);




      SET_PUMP_ACTIVE_STATE(UNIT_1,U91,PUMP.Base);
      SET_PUMP_ACTIVE_STATE(UNIT_1,U95,PUMP.Base);
      SET_PUMP_ACTIVE_STATE(UNIT_1,Diesel,PUMP.Base);

      SET_PUMP_NOZZLE_STATE(UNIT_1,U91,PUMP.NozzleBase);
      SET_PUMP_NOZZLE_STATE(UNIT_1,U95,PUMP.NozzleBase);
      SET_PUMP_NOZZLE_STATE(UNIT_1,Diesel,PUMP.NozzleBase);

      temp := UNIT_IS_USING(UNIT_1);
      temp := UNIT_IS_PAID(UNIT_1);
      temp_State := GET_PUMP_UNIT_STATE(UNIT_1);

      temp_Pump:=GET_PUMP(UNIT_1,U91);
      temp_Pump:=GET_PUMP(UNIT_1,U95);
      temp_Pump:=GET_PUMP(UNIT_1,Diesel);
   end Test_SET_GET;

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
                        Routine => Test_START_PUMPING_C1_SENSOR'Access,
                        Name => "Test_START_PUMPING_C1_SENSOR");
      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C1_Car_tank_full'Access,
                        Name => "Test_START_PUMPING_C1_Car_tank_full");
      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C1_tank_empty'Access,
                        Name => "Test_START_PUMPING_C1_tank_empty");

      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C2'Access,
                        Name => "Test_START_PUMPING_C2");
      Register_Routine (Test => T,
                        Routine => Test_STOP_PUMPING'Access,
                        Name => "Test_STOP_PUMPING");
      Register_Routine (Test => T,
                        Routine => Test_SET_GET'Access,
                        Name => "Test_SET_GET");
      Register_Routine (Test => T,
                        Routine => Test_LiftNozzleException'Access,
                        Name => "Test_LiftNozzleException");
      Register_Routine (Test => T,
                        Routine => Test_ReturnNozzleException'Access,
                        Name => "Test_ReturnNozzleException");
      Register_Routine (Test => T,
                        Routine => Test_StartPumpingException_car_tank_full'Access,
                        Name => "Test_StartPumpingException_car_tank_full");

      Register_Routine (Test => T,
                        Routine => Test_StartPumpingException_tanksize_empty'Access,
                        Name => "Test_StartPumpingException_tanksize_empty");
      Register_Routine (Test => T,
                        Routine => Test_StopPumpingException'Access,
                        Name => "Test_StopPumpingException");
      Register_Routine (Test => T,
                        Routine => Test_StartPumpingException_pump_not_ready'Access,
                        Name => "Test_StartPumpingException_pump_not_ready");
      Register_Routine (Test => T,
                        Routine => Test_START_PUMPING_C2_tank_empty'Access,
                        Name => "Test_START_PUMPING_C2_tank_empty");



   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end PUMP_UNIT.Test;
