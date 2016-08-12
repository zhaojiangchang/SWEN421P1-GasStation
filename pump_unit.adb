with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with sPrint; use sPrint;
package body PUMP_UNIT
with SPARK_Mode is

   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMPS(A: in out PUMP_UNIT_R) is
      p91 : PUMP_INS.PUMP_TYPE;
      p95 : PUMP_INS.PUMP_TYPE;
      pDiesel : PUMP_INS.PUMP_TYPE;



   begin
      p91 := new PUMP_INS.PUMP;
      PUMP_INS.SET_FUEL_PRICE(p91,1.80);
      PUMP_INS.SET_FUEL_NAME(p91,"U91");
      PUMP_INS.APPEND_RESERVOIR(p91, 1);
      A.PUMP_91 := p91;

      PUMP_INS.SET_FUEL_PRICE(p95,2.00);
      PUMP_INS.SET_FUEL_NAME(p95,"U95");
      PUMP_INS.APPEND_RESERVOIR(p95,2);
      A.PUMP_95 := p95;

      PUMP_INS.SET_FUEL_PRICE(pDiesel,1.00);
      PUMP_INS.SET_FUEL_NAME(pDiesel,"Dsl");
      PUMP_INS.APPEND_RESERVOIR(pDiesel,3);
      A.PUMP_Diesel := pDiesel;
      print("add three pumps to a pump unit");
     -- Put_Line("add three pumps to a pump unit");

   end ADD_PUMPS;

   --------------------
   -- PUMP_UNIT_PAID --
   --------------------

--     function PUMP_UNIT_PAID (A: in PUMP_UNIT_R) return Boolean is
--     begin
--
--        return False;
--     end PUMP_UNIT_PAID;

end PUMP_UNIT;
