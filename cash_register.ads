with sPrint;
with PUMP_UNIT;
with PUMP;

package CASH_REGISTER
with SPARK_Mode is
   type FLOAT_NUMBER is new Float;
   type PUMP_UNIT_ID is
      record
         ID: String(1..6);
         TO_PAY : FLOAT_NUMBER;
         PUMPED :FLOAT_NUMBER;
         FUEL: String(1..5);
      end record;
   type CASH_REGISTER is
      record
         TOTAL_INCOME: Boolean;
         TOTAL_PUMP_TO_PAY: FLOAT_NUMBER;
         UNIT_1: PUMP_UNIT_ID;
      end record;
end CASH_REGISTER;
