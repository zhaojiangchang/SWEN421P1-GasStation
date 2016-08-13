with PUMP;

generic

package PUMP_UNIT
with SPARK_Mode is
   type PUMP_UNIT is private;

   package P is new PUMP;


   --function
   function GET_PUMP(A: in out PUMP_UNIT; B: in P.FUEL_TYPES) return P.PUMP;
   function GET_TANKS_SIZE(A: in PUMP_UNIT; B: in P.FUEL_TYPES) return P.TANK_SIZE;
   function UNIT_IS_USING(A: in PUMP_UNIT) return Boolean;
   function UNIT_IS_PAID(A: in PUMP_UNIT) return Boolean;
   --procedure
   procedure ADD_PUMP(A: in out PUMP_UNIT;B: in P.FUEL_TYPES)  ;
--       with
--         pre =>(B >0 and B < 4),
--       post =>(P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00
--               or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_95)>0.00
--              or P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91)>0.00 );
   procedure SET_IS_USING(A: in out PUMP_UNIT);
   procedure SET_IS_PAID(A: in out PUMP_UNIT);
   procedure SET_PUMP_ACTIVE(A: in out PUMP_UNIT; B: in P.FUEL_TYPES; C: in out P.STATE_TPYE);
   procedure SET_PUMP_NOZZLE_STATE(A: in out PUMP_UNIT; B: in P.FUEL_TYPES; C: in out P.NOZZLE_TYPE);
--     procedure LEFT_NOZZLE (A: in out PUMP_UNIT; fuelType : in Fuel_Type);
--  --       with
--  --         Pre => (pump_unit.PumpState = Base or pump_unit.PumpState = Wating),
--  --       Post => (pump_unit.PumpState = Ready);
--
--     procedure returnNozzle (pump_unit: in out PumpUnit);
--  --       with
--  --         Pre => (pump_unit.PumpState = Ready or (if pump_unit.Due >= 0.00 then pump_unit.PumpState = Wating)),
--  --         Post => (pump_unit.PumpState = Base);
--
--     procedure startPumping (pump_unit: in out PumpUnit; AmountToPump : in Value);
--  --       with
--  --         Pre => (pump_unit.PumpState = Ready),
--  --       Post => (pump_unit.PumpState = Pumping);
--
--     procedure stopPumping (pump_unit: in out pumpUnit);
--  --       with
--  --         Pre => (pump_unit.PumpState = Pumping),
--  --       Post => (pump_unit.PumpState = Ready);
--
--    -- function PUMP_UNIT_PAID (A: in PUMP_UNIT_R)return Boolean;

private
   type PUMP_UNIT is
      record
         IS_USING: Boolean;
         IS_PAID: Boolean;
         PUMP_ACTIVE: P.FUEL_TYPES;
         NOZZLE_STATE: P.NOZZLE_TYPE;
         PUMP_91: P.PUMP;
         PUMP_95: P.PUMP;
         PUMP_Diesel: P.PUMP;
      end record;

end PUMP_UNIT;
