with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;
with sPrint;
package body PUMP.Test is

   P: PUMP;

   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      New_Line;
      Put_Line ("Set up case ..");


   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      New_Line;
      Put_Line("Set Up ..");

   end;

   procedure Tear_Down (T : in out TC) is
   begin
      Put_Line("Tear Down ...");

      P.NOZZLE_STATE:= NozzleBase;
      P.PUMP_STATE:=Base;
      P.FUEL_TYPE:= U91;
      P.RESERVOIR_INFO.TOTAL:=1000.00;
      P.PUMPED:= 0.00;



   end;

   procedure Tear_Down_Case (T : in out TC) is
   begin
      Put_Line ("Tear Down Case ..");
      P.NOZZLE_STATE:= NozzleBase;
      P.PUMP_STATE:=Base;
      P.FUEL_TYPE:= U91;
      P.RESERVOIR_INFO.TOTAL:=1000.00;
      P.PUMPED:= 0.00;

   end;


   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

      procedure Test_GET_SET(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      begin
      SET_PUMP_STATE(P,Base);
      SET_PUMP_NOZZLE_STATE(P,NozzleBase);
      SET_RESERVOIR_SIZE(P,100.00);

      Assert (Condition => (GET_UNIT_PRICE(P)) = 0.00,
               Message => "get ");
      Assert (Condition => (GET_TANKS_SIZE(P)) = 100.00,
               Message => "get ");
      Assert (Condition => (GET_RESEVOIR_CATEGORY(P)) = U91,
              Message => "get ");
      REMOVE_PETROL_RESERVOIR(P,10.00);
      SET_PUMPED(P,10.00);
      APPEND_RESERVOIR(P,U91);
      SET_FUEL_PRICE(P,2.00);
      Assert (Condition => (GET_CURRENT_NOZZLE_STATE(P)) = NozzleBase,
              Message => "get ");
      Assert (Condition => (GET_STATE(P)) = Base,
              Message => "get ");
      end Test_GET_SET;

   procedure Test_RESERVOIR(CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      temp: RESERVOIR ;
   begin
      temp.TOTAL := 1000.00;
      temp.RESERVOIR_CATEGORY:=U91;
      Assert (Condition => (GET_TANKS_SIZE(P)) = 1000.00,
              Message => "Assert 2: GET_TANKS_SIZE ");
   end Test_RESERVOIR;

   --     procedure Test_LEFT_NOZZLE (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   --
   --     begin
   --
   --     end Test_LEFT_NOZZLE;
   --
   --      procedure Test_RETURN_NOZZLE (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
   --     begin
   --
   --     end Test_RETURN_NOZZLE;


   --     --==========================================================
   --     --               REGISTRATION/NAMING
   --     --==========================================================
   --
   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Test_GET_SET'Access,
                        Name => "Test_GET_SET");
   Register_Routine (Test => T,
                        Routine => Test_RESERVOIR'Access,
                        Name => "Test_RESERVOIR");
   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end PUMP.Test;
