with PUMP;

generic

package PUMP_UNIT
with SPARK_Mode is
   type PUMP_UNIT is private;
   type FLOAT_NUMBER is delta 0.01 digits 10;
   package P is new PUMP;


   --function
   function GET_PUMP(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.PUMP;
   function GET_TANKS_SIZE(pumpUnit: in PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.FLOAT_NUMBER;
   function UNIT_IS_USING(pumpUnit: in PUMP_UNIT) return Boolean;
   function UNIT_IS_PAID(pumpUnit: in PUMP_UNIT) return Boolean;
   --procedure
   procedure ADD_PUMP(pumpUnit: in out PUMP_UNIT;fuelType: in P.FUEL_TYPES)  ;
--       with
--         pre =>(B >0 and B < 4),
--       post =>(P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00
--               or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_95)>0.00
--              or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00 );
   procedure SET_IS_USING(pumpUnit: in out PUMP_UNIT);
   procedure SET_IS_PAID(pumpUnit: in out PUMP_UNIT);
   procedure SET_PUMP_ACTIVE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; stateType: in out P.STATE_TYPE);
   procedure SET_PUMP_NOZZLE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; nozzleType: in out P.NOZZLE_TYPE);
   procedure LEFT_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP; fuelType: in P.FUEL_TYPES);
--       with
--         Pre => (pump_unit.PumpState = Base or pump_unit.PumpState = Wating),
--       Post => (pump_unit.PumpState = Ready);
   procedure RETURN_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP);
--       with
--         Pre => (pump_unit.PumpState = Ready or (if pump_unit.Due >= 0.00 then pump_unit.PumpState = Wating)),
--         Post => (pump_unit.PumpState = Base);

   procedure START_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r: in out P.PUMP; AMOUNT: in P.FLOAT_NUMBER; CAR_TANK_SPACE: in out P.FLOAT_NUMBER);
--       with
--         Pre => (pump_unit.PumpState = Ready),
--       Post => (pump_unit.PumpState = Pumping);

   procedure STOP_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP);
--       with
--         Pre => (pump_unit.PumpState = Pumping),
--       Post => (pump_unit.PumpState = Ready);

  -- function PUMP_UNIT_PAID (pumpUnit: in PUMP_UNIT_R)return Boolean;

private
   type PUMP_UNIT is
      record
         IS_USING: Boolean;
         IS_PAID: Boolean;
         TO_PAY: FLOAT_NUMBER;
         PUMP_ACTIVE_FUEL: P.FUEL_TYPES;
         PUMP_ACTIVE_STATE: p.STATE_TYPE;
         PUMP_NOZZLE_STATE: P.NOZZLE_TYPE;
         PUMP_91: P.PUMP;
         PUMP_95: P.PUMP;
         PUMP_Diesel: P.PUMP;
      end record;

end PUMP_UNIT;
