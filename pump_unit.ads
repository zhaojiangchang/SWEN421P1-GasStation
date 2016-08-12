with PUMP;

generic

package PUMP_UNIT
with SPARK_Mode is
   --subtype FUEL_TYPE is String(1..7);
   type PUMP_UNIT_R is private;
  -- type PUMP_UNIT_PTR is access PUMP_UNIT;
   subtype NAME_TYPE is String (1..3);
   type RESE_LOC is range 1..3;
   type FUEL_TYPE is range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;

   package P is new PUMP;
   --function
   function GET_PUMP(A: in out PUMP_UNIT_R; B: in FUEL_TYPE) return P.PUMP_TYPE;
   function GET_TANKS_SIZE(A: in PUMP_UNIT_R; B: in FUEL_TYPE) return P.TANK_SIZE;
   function UNIT_IS_USING(A: in PUMP_UNIT_R) return Boolean;
   function UNIT_IS_PAID(A: in PUMP_UNIT_R) return Boolean;
   --procedure
   procedure ADD_PUMP(A: in out PUMP_UNIT_R;B: in FUEL_TYPE);
   procedure SET_IS_USING(A: in out PUMP_UNIT_R);
   procedure SET_IS_PAID(A: in out PUMP_UNIT_R);

  -- function PUMP_UNIT_PAID (A: in PUMP_UNIT_R)return Boolean;

private
   type PUMP_UNIT_R is
      record
         IS_USING: Boolean;
         IS_PAID: Boolean;

         PUMP_91: P.PUMP_TYPE(1);
         PUMP_95: P.PUMP_TYPE(2);
         PUMP_Diesel: P.PUMP_TYPE(3);
      end record;

end PUMP_UNIT;
