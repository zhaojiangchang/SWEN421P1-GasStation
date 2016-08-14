with PUMP;
generic

package PUMP_UNIT
with SPARK_Mode is
   type PUMP_UNIT is private;
   type FLOAT_NUMBER is delta 0.01 digits 10;
   subtype UNIT_ID_TYPE is String(1..6);
   package P is new PUMP;
   use all type P.NOZZLE_TYPE;
   use all type P.FLOAT_NUMBER;


   --function
   function GET_PUMP(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.PUMP;
   function GET_TANKS_SIZE(pumpUnit: in PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.FLOAT_NUMBER;
   function GET_ID(pumpUnit: in PUMP_UNIT) return UNIT_ID_TYPE;
   function GET_TO_PAY(pumpUnit: in PUMP_UNIT) return P.FLOAT_NUMBER;
   function GET_PUMPED(pumpUnit: in PUMP_UNIT) return P.FLOAT_NUMBER;
   function GET_FUEL(pumpUnit: in PUMP_UNIT) return P.FUEL_TYPES;
   function UNIT_IS_USING(pumpUnit: in PUMP_UNIT) return Boolean;
   function UNIT_IS_PAID(pumpUnit: in PUMP_UNIT) return Boolean;
   function GET_PUMP_UNIT_STATE(pumpUnit: in PUMP_UNIT)return P.STATE_TYPE;
   function GET_PUMP_NOZZLE_STATE(pumpUnit: in PUMP_UNIT) return P.NOZZLE_TYPE;

   --procedure

   procedure SET_IS_USING(pumpUnit: in out PUMP_UNIT);
   procedure SET_IS_PAID(pumpUnit: in out PUMP_UNIT);
   procedure SET_TO_PAY(pumpUnit: in out PUMP_UNIT; AMOUNT: in P.FLOAT_NUMBER);
   procedure SET_UNIT_ID(pumpUnit: in out PUMP_UNIT; ID: in UNIT_ID_TYPE);
   procedure SET_PUMPED(pumpUnit: in out PUMP_UNIT;  AMOUNT: in P.FLOAT_NUMBER);
   procedure SET_PUMP_ACTIVE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; stateType: in out P.STATE_TYPE);
   procedure SET_PUMP_NOZZLE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; nozzleType: in out P.NOZZLE_TYPE);

   procedure ADD_PUMP(pumpUnit: in out PUMP_UNIT;pump_r : in out P.PUMP; fuelType: in P.FUEL_TYPES)
     with
       pre => (P.FUEL_TYPES'Pos(fuelType) >=0),
         post =>(P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 0 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r)) = 0
                 and P.GET_TANKS_SIZE(pump_r) = 1000.00);

   procedure LEFT_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP; fuelType: in P.FUEL_TYPES)
     with
       Pre => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 0 or P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 3),
     Post => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 1);

   procedure RETURN_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP)
     with
       Pre => ((P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 1
               or P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 3)
               and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r))=5),

     Post => (( P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 3 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r))=2)
              or(P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 0 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r))=0));


   procedure START_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r: in out P.PUMP; AMOUNT: in P.FLOAT_NUMBER; CAR_TANK_SPACE: in out P.FLOAT_NUMBER)
     with
       Pre => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 1 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r))=1),
     Post => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 1 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r))=4);

   procedure STOP_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP)
     with
       Pre => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 2 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r)) =3),
     Post => (P.STATE_TYPE'Pos(P.GET_STATE(pump_r)) = 1 and P.NOZZLE_TYPE'Pos(P.GET_CURRENT_NOZZLE_STATE(pump_r)) =4);


private
   type PUMP_UNIT is
      record
         ID: UNIT_ID_TYPE;
         IS_USING: Boolean;
         IS_PAID: Boolean;
         TO_PAY: P.FLOAT_NUMBER;
         PUMPED: P.FLOAT_NUMBER;
         PUMP_ACTIVE_FUEL: P.FUEL_TYPES;
         PUMP_ACTIVE_STATE: P.STATE_TYPE;
         PUMP_NOZZLE_STATE: P.NOZZLE_TYPE;
         PUMP_91: P.PUMP;
         PUMP_95: P.PUMP;
         PUMP_Diesel: P.PUMP;
      end record;

end PUMP_UNIT;
