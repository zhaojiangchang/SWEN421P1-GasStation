with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with sPrint;
package body PUMP_UNIT.Test is
   use all type PUMP.FUEL_TYPES;
   UNIT_1 : PUMP_UNIT;
   UNIT_1_91: PUMP.PUMP;
--     UNIT_1_95: PUMP;
--     UNIT_1_Diesel: PUMP;


   U91: PUMP.FUEL_TYPES;
--     U95: FUEL_TYPES;
--     Diesel: FUEL_TYPES;
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

   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      New_Line;
      Put_Line ("Set up case ..");
      U91 :=PUMP.FUEL_TYPES'Val(F_U91);
--        U95 :=FUEL_TYPES'Val(F_U95);
--        Diesel :=FUEL_TYPES'Val(F_Diesel);
      SET_UNIT_ID(UNIT_1,"UNIT_1");
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

   end;

   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");
      UNIT_1.ID :="      ";
      UNIT_1.IS_USING:=False;
      UNIT_1.IS_PAID:=True;
      UNIT_1.TO_PAY:= 0.00;
      UNIT_1.PUMPED:=0.00;
      UNIT_1.PUMP_ACTIVE_FUEL:= PUMP.FUEL_TYPES'Val(0);
      UNIT_1.PUMP_ACTIVE_STATE:= PUMP.STATE_TYPE'Val(0);
      UNIT_1.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(0);
   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

   procedure Test_AddPump (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      ADD_PUMP(UNIT_1,UNIT_1_91, U91);

      Assert (Condition => (GET_TANKS_SIZE(UNIT_1.PUMP_91) = 1000.00),
              Message => "Did not add pump to pump unit");
   end Test_AddPump;
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
