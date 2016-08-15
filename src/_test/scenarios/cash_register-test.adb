with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with sPrint;
package body CASH_REGISTER.Test is

   use all type PUMP.FLOAT_NUMBER;
   UNIT_1 : PUMP_UNIT.PUMP_UNIT;
   UNIT_1_91: PUMP.PUMP;
   U91: PUMP.FUEL_TYPES;
   F_U91: Integer :=0;
   C: CASH_REGISTER;
   P: PUMP_UNIT_ID;
   AMOUNT: PUMP.FLOAT_NUMBER;
   CAR_TANK_SPACE: PUMP.FLOAT_NUMBER;
   AMOUNT_TO_FILL: PUMP.FLOAT_NUMBER;
   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      New_Line;
      Put_Line ("Set up case ..");
      --set initial car condition
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;

      U91 :=PUMP.FUEL_TYPES'Val(F_U91);
      PUMP_UNIT.SET_UNIT_ID(UNIT_1,"UNIT_1");
      PUMP_UNIT.ADD_PUMP(UNIT_1,UNIT_1_91, U91);
      UNIT_1_91.UNIT_PRICE:=2.00;
      P.ID := UNIT_1.ID;
      P.TO_PAY:= UNIT_1.TO_PAY;
      P.PUMPED:= UNIT_1.PUMPED;
      P.FUEL:= UNIT_1.PUMP_ACTIVE_FUEL;
      C.UNIT_1:= P;
   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");
      CAR_TANK_SPACE := 5.00;
      --set customer input not money
      AMOUNT_TO_FILL := 10.00;

      U91 :=PUMP.FUEL_TYPES'Val(F_U91);
      PUMP_UNIT.SET_UNIT_ID(UNIT_1,"UNIT_1");
      PUMP_UNIT.ADD_PUMP(UNIT_1,UNIT_1_91, U91);
      UNIT_1_91.UNIT_PRICE:=2.00;
      P.ID := UNIT_1.ID;
      P.TO_PAY:= UNIT_1.TO_PAY;
      P.PUMPED:= UNIT_1.PUMPED;
      P.FUEL:= UNIT_1.PUMP_ACTIVE_FUEL;
      C.UNIT_1:= P;
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

   procedure Test_SET_PUMPED_INFO_TO_CASH_REGISTER(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91, 2.00, CAR_TANK_SPACE);
      PUMP_UNIT.RETURN_NOZZLE(UNIT_1,UNIT_1_91);
      SET_PUMPED_INFO_TO_CASH_REGISTER(UNIT_1);
      sPrint.print_float_type("aa: ",UNIT_1.TO_PAY);
      Assert (Condition => (UNIT_1.ID) = C.UNIT_1.ID,
              Message => "suppose  UNIT_1 " );
   end Test_SET_PUMPED_INFO_TO_CASH_REGISTER;

   procedure payFuel(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   begin
      PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
      PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
      PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91, 2.00, CAR_TANK_SPACE);
      PUMP_UNIT.RETURN_NOZZLE(UNIT_1,UNIT_1_91);
      SET_PUMPED_INFO_TO_CASH_REGISTER(UNIT_1);

      payFuel(UNIT_1,UNIT_1_91,UNIT_1.TO_PAY);
   end payFuel;

   procedure Test_pay_without_return_nozzle_exception (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is
      begin
         Put_Line("");
         Put_Line("Test_pay_without_return_nozzle_exception");
         PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
         payFuel(UNIT_1,UNIT_1_91,UNIT_1.TO_PAY);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"Test_pay_without_return_nozzle_exception");
   end Test_pay_without_return_nozzle_exception;

   procedure Test_amount_notequal_exception (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is

      begin
         Put_Line("");
         Put_Line("Test_amount_notequal_exception");
         AMOUNT:=0.01;
         CAR_TANK_SPACE := 5.00;
         --set customer input not money
         AMOUNT_TO_FILL := 10.00;
         PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
         PUMP_UNIT.RETURN_NOZZLE(UNIT_1,UNIT_1_91);
         payFuel(UNIT_1,UNIT_1_91,AMOUNT);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"amount not equal");
   end Test_amount_notequal_exception;

   procedure Test_already_paid_exception (CWTC: in out AUnit.Test_Cases.Test_Case'Class) is
      procedure Test_Raising_Exception is

      begin
         Put_Line("");
         Put_Line("Test_amount_notequal_exception");
         CAR_TANK_SPACE := 5.00;
         --set customer input not money
         AMOUNT_TO_FILL := 10.00;
         PUMP_UNIT.LEFT_NOZZLE(UNIT_1,UNIT_1_91,U91);
         PUMP_UNIT.START_PUMPING(UNIT_1,UNIT_1_91,AMOUNT_TO_FILL, CAR_TANK_SPACE);
         PUMP_UNIT.RETURN_NOZZLE(UNIT_1,UNIT_1_91);
         payFuel(UNIT_1,UNIT_1_91,UNIT_1.TO_PAY);
         payFuel(UNIT_1,UNIT_1_91,UNIT_1.TO_PAY);
      end;
   begin
      Assert_Exception (Proc => Test_Raising_Exception'Unrestricted_Access,
                        Message =>"Test_already_paid_exception");
   end Test_already_paid_exception;

   procedure createRecords(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      createRecord: CASH_REGISTER;
      create_pump_Id_record: PUMP_UNIT_ID;
   begin
      Put_Line("");
      Put_Line("createRecords");
      create_pump_Id_record.ID := "UNIT_1";
      create_pump_Id_record.TO_PAY:= 0.00;
      create_pump_Id_record.PUMPED:= 0.00;
      create_pump_Id_record.FUEL:=U91;
      createRecord.UNIT_1 := create_pump_Id_record;
      Assert (Condition => (createRecord.UNIT_1.ID) = "UNIT_1",
              Message => "suppose  UNIT_1 " );

   end createRecords;

   --     --==========================================================
   --     --               REGISTRATION/NAMING
   --     --==========================================================
   --
   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Test_SET_PUMPED_INFO_TO_CASH_REGISTER'Access,
                        Name => "Test_SET_PUMPED_INFO_TO_CASH_REGISTER");
      Register_Routine (Test => T,
                        Routine => payFuel'Access,
                        Name => "payFuel");
      Register_Routine (Test => T,
                        Routine => createRecords'Access,
                        Name => "createRecords");
      Register_Routine (Test => T,
                        Routine => Test_pay_without_return_nozzle_exception'Access,
                        Name => "Test_pay_without_return_nozzle_exception");
      Register_Routine (Test => T,
                        Routine => Test_amount_notequal_exception'Access,
                        Name => "Test_amount_notequal_exception");
       Register_Routine (Test => T,
                        Routine => Test_already_paid_exception'Access,
                        Name => "Test_already_paid_exception");

   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end CASH_REGISTER.Test;
