with Ada.Text_IO; use Ada.Text_IO;
with PUMP;

package PUMP_UNIT
with SPARK_Mode is
   type PUMP_UNIT_R is private;
  -- type PUMP_UNIT_PTR is access PUMP_UNIT;
   subtype FUEL_TYPE is String(1..7);
   subtype NAME_TYPE is String (1..3);
   type RESE_LOC is range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;

   package PUMP_INS is new PUMP;


   procedure ADD_PUMPS(A: in out PUMP_UNIT_R);
  -- function PUMP_UNIT_PAID (A: in PUMP_UNIT_R)return Boolean;

private

   type PUMP_UNIT_R is
      record
         IS_USING: Boolean;
         IS_PAID: Boolean;
         PUMP_91: PUMP_INS.PUMP_TYPE;
         PUMP_95: PUMP_INS.PUMP_TYPE;
         PUMP_Diesel: PUMP_INS.PUMP_TYPE;
      end record;

end PUMP_UNIT;
