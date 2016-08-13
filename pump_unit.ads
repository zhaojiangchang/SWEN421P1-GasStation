with PUMP;

generic

package PUMP_UNIT
with SPARK_Mode is
   type PUMP_UNIT_R is private;

   package P is new PUMP;


   --function
   function GET_PUMP(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES) return P.PUMP_TYPE;
   function GET_TANKS_SIZE(A: in PUMP_UNIT_R; B: in P.FUEL_TYPES) return P.TANK_SIZE;
   function UNIT_IS_USING(A: in PUMP_UNIT_R) return Boolean;
   function UNIT_IS_PAID(A: in PUMP_UNIT_R) return Boolean;
   --procedure
   procedure ADD_PUMP(A: in out PUMP_UNIT_R;B: in P.FUEL_TYPES)  ;
--       with
--         pre =>(B >0 and B < 4),
--       post =>(P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00
--               or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_95)>0.00
--              or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00 );
   procedure SET_IS_USING(A: in out PUMP_UNIT_R);
   procedure SET_IS_PAID(A: in out PUMP_UNIT_R);
   procedure SET_PUMP_ACTIVE(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES; C: in out P.STATE_TPYE);
   procedure SET_PUMP_NOZZLE_STATE(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES; C: in out P.NOZZLE_TYPE);

  -- function PUMP_UNIT_PAID (A: in PUMP_UNIT_R)return Boolean;

private
   type PUMP_UNIT_R is
      record
         IS_USING: Boolean;
         IS_PAID: Boolean;
         PUMP_ACTIVE: P.FUEL_TYPES;
         NOZZLE_STATE: P.NOZZLE_TYPE;
         PUMP_91: P.PUMP_TYPE;
         PUMP_95: P.PUMP_TYPE;
         PUMP_Diesel: P.PUMP_TYPE;
      end record;

end PUMP_UNIT;
