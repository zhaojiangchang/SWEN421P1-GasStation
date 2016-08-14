with AUnit.Reporter.Text;
with AUnit.Run;
with PUMP_UNIT_Suite;

procedure PUMP_UNIT_Harness is

   procedure Runner is new AUnit.Run.Test_Runner (PUMP_UNIT_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   Runner (Reporter);
end PUMP_UNIT_Harness;
