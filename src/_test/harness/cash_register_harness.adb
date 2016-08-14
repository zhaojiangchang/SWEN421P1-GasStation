with AUnit.Reporter.Text;
with AUnit.Run;
with CASH_REGISTER_Suite;

procedure CASH_REGISTER_Harness is

   procedure Runner is new AUnit.Run.Test_Runner (CASH_REGISTER_Suite.Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;

begin
   Runner (Reporter);
end CASH_REGISTER_Harness;
