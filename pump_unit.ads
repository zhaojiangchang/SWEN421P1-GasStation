with Ada.Text_IO; use Ada.Text_IO;
with PUMP;

package PUMP_UNIT is
   type PUMP_UNIT is private;
   subtype FUEL_TYPE is String(1..7);
   type PUMP_UNIT_PTR is access PUMP_UNIT;
   subtype NAME_TYPE is String (1..3);
   type RESE_LOC is range 1..3;

   package PUMP91 is new PUMP;
   package PUMP95 is new PUMP;
   package PUMPDiesel is new PUMP;


   procedure ADD_PUMPS;

  -- function PUMP_UNIT_PAID (A: PUMP_UNIT_PTR)return Boolean;

private

   type PUMP_UNIT is
      record
         IS_USING: Boolean := False;
         IS_PAID: Boolean :=True;
      end record;

end PUMP_UNIT;
