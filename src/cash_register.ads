with PUMP_UNIT;
with PUMP;
package CASH_REGISTER

with SPARK_Mode is
   --     type PUMP_UNIT is private;

   type FLOAT_NUMBER is delta 0.01 digits 10;
   subtype UNIT_ID_TYPE is String(1..6);
   --     package P is new PUMP;
   ---------------------------------------
   -- PUMP_UNIT_ID  ----------------------
   ---------------------------------------
   type PUMP_UNIT_ID is
      record
         ID:PUMP_UNIT.UNIT_ID_TYPE;
         TO_PAY : PUMP.FLOAT_NUMBER;
         PUMPED :PUMP.FLOAT_NUMBER;
         FUEL: PUMP.FUEL_TYPES;
      end record;
   ---------------------------------------
   -- CASH_REGISTER  ---------------------
   ---------------------------------------
   type CASH_REGISTER is

      record
         UNIT_1: PUMP_UNIT_ID;
      end record;
   cashRegister: CASH_REGISTER;

   --procedure
   procedure payFuel (pumpUnit: in out PUMP_UNIT.PUMP_UNIT; pump_r: in out PUMP.PUMP; AMOUNT: in  PUMP.FLOAT_NUMBER);
   procedure SET_PUMPED_INFO_TO_CASH_REGISTER (pumpUnit: in PUMP_UNIT.PUMP_UNIT);

end CASH_REGISTER;
