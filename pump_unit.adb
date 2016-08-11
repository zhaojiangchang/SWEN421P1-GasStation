with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body PUMP_UNIT is

   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMPS is
      p91 : PUMP91.PUMP_PTR;
      p95 : PUMP95.PUMP_PTR;
      pDiesel : PUMPDiesel.PUMP_PTR;


   begin

      p91 := new PUMP91.PUMP;
      PUMP91.SET_FUEL_PRICE(p91,1.80);
      PUMP91.SET_FUEL_NAME(p91,"U91");
      PUMP91.APPEND_RESERVOIR(p91, 1);

      p95 := new PUMP95.PUMP;
      PUMP95.SET_FUEL_PRICE(p95,2.00);
      PUMP95.SET_FUEL_NAME(p95,"U95");
      PUMP95.APPEND_RESERVOIR(p95,2);

      pDiesel := new PUMPDiesel.PUMP;
      PUMPDiesel.SET_FUEL_PRICE(pDiesel,1.00);
      PUMPDiesel.SET_FUEL_NAME(pDiesel,"Dsl");
      PUMPDiesel.APPEND_RESERVOIR(pDiesel,3);


      Put_Line("add three pumps to a pump unit");

   end ADD_PUMPS;

   --------------------
   -- PUMP_UNIT_PAID --
   --------------------

   function PUMP_UNIT_PAID (A: PUMP_UNIT_PTR) return Boolean is
   begin

      return False;
   end PUMP_UNIT_PAID;

end PUMP_UNIT;
