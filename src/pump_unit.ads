with PUMP;

package PUMP_UNIT
with SPARK_Mode is
   --     type PUMP_UNIT is private;

   type FLOAT_NUMBER is delta 0.01 digits 10;
   subtype UNIT_ID_TYPE is String(1..6);
   --     package P is new PUMP;
   use all type PUMP.NOZZLE_TYPE;
   use all type PUMP.FLOAT_NUMBER;
   use all type PUMP.STATE_TYPE;

   type PUMP_UNIT is
      record
         ID: UNIT_ID_TYPE:="      ";
         IS_USING: Boolean:=False;
         IS_PAID: Boolean:=True;
         TO_PAY: PUMP.FLOAT_NUMBER:=0.00;
         PUMPED: PUMP.FLOAT_NUMBER:=0.00;
         PUMP_ACTIVE_FUEL: PUMP.FUEL_TYPES:=PUMP.U91;
         PUMP_ACTIVE_STATE: PUMP.STATE_TYPE:=PUMP.Base;
         PUMP_NOZZLE_STATE: PUMP.NOZZLE_TYPE:=PUMP.NozzleBase;
         PUMP_91: PUMP.PUMP;
         PUMP_95: PUMP.PUMP;
         PUMP_Diesel: PUMP.PUMP;
      end record;

   --function
   function GET_PUMP(pumpUnit: in PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES) return PUMP.PUMP;
   function GET_TANKS_SIZE(pumpUnit: in PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES) return PUMP.FLOAT_NUMBER;
   function GET_ID(pumpUnit: in PUMP_UNIT) return UNIT_ID_TYPE;
   function GET_TO_PAY(pumpUnit: in PUMP_UNIT) return PUMP.FLOAT_NUMBER;
   function GET_PUMPED(pumpUnit: in PUMP_UNIT) return PUMP.FLOAT_NUMBER;
   function GET_FUEL(pumpUnit: in PUMP_UNIT) return PUMP.FUEL_TYPES;
   function UNIT_IS_USING(pumpUnit: in PUMP_UNIT) return Boolean;
   function UNIT_IS_PAID(pumpUnit: in PUMP_UNIT) return Boolean;
   function GET_PUMP_UNIT_STATE(pumpUnit: in PUMP_UNIT)return PUMP.STATE_TYPE;
   function GET_PUMP_NOZZLE_STATE(pumpUnit: in PUMP_UNIT) return PUMP.NOZZLE_TYPE;

   --procedure

   procedure SET_IS_USING(pumpUnit: in out PUMP_UNIT);
   procedure SET_IS_PAID(pumpUnit: in out PUMP_UNIT);
   procedure SET_TO_PAY(pumpUnit: in out PUMP_UNIT; AMOUNT: in PUMP.FLOAT_NUMBER);
   procedure SET_UNIT_ID(pumpUnit: in out PUMP_UNIT; ID: in UNIT_ID_TYPE);
   procedure SET_PUMPED(pumpUnit: in out PUMP_UNIT;  AMOUNT: in PUMP.FLOAT_NUMBER);
   procedure SET_PUMP_ACTIVE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES; stateType: in PUMP.STATE_TYPE);
   procedure SET_PUMP_NOZZLE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES; nozzleType: in PUMP.NOZZLE_TYPE);

   procedure ADD_PUMP(pumpUnit: in out PUMP_UNIT;pump_r : in out PUMP.PUMP; fuelType: in PUMP.FUEL_TYPES);

   procedure LEFT_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out PUMP.PUMP; fuelType: in PUMP.FUEL_TYPES)
     with
       Pre => (PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 0 or PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 3),
     Post => (pumpUnit.PUMP_ACTIVE_STATE = PUMP.Ready);

   procedure RETURN_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out PUMP.PUMP)
     with
       Pre => ((PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 1
               or PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 3)
               and PUMP.NOZZLE_TYPE'Pos(PUMP.GET_CURRENT_NOZZLE_STATE(pump_r))=5),

     Post => (pumpUnit.PUMP_ACTIVE_STATE = PUMP.Waiting or pumpUnit.PUMP_ACTIVE_STATE = PUMP.Base);


   procedure START_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r: in out PUMP.PUMP; AMOUNT: in PUMP.FLOAT_NUMBER; CAR_TANK_SPACE: in out PUMP.FLOAT_NUMBER)
     with
       Pre => (PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 1 and PUMP.NOZZLE_TYPE'Pos(PUMP.GET_CURRENT_NOZZLE_STATE(pump_r))=1),
     Post => (pumpUnit.PUMP_ACTIVE_STATE = PUMP.Ready);

   procedure STOP_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r : in out PUMP.PUMP)
     with
       Pre => (PUMP.STATE_TYPE'Pos(PUMP.GET_STATE(pump_r)) = 2 and PUMP.NOZZLE_TYPE'Pos(PUMP.GET_CURRENT_NOZZLE_STATE(pump_r)) =3),
     Post => (pumpUnit.PUMP_NOZZLE_STATE = PUMP.Stop and pumpUnit.PUMP_ACTIVE_STATE = PUMP.Ready);


private

end PUMP_UNIT;
