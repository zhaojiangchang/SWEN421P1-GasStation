package PUMP

with SPARK_Mode is

   type RESERVOIR_NUM is new Integer;
   type FLOAT_NUMBER is digits 3 range 0.0 .. 1.0E35;
   type FUEL_TYPES is (U91, U95, Diesel);
--     type PUMP is private;
--     type RESERVOIVOIR is private;
   type STATE_TYPE is (Base, Ready, Pumping, Waiting);
   type NOZZLE_TYPE is (NozzleBase, Lift, Replace,Start, Stop, Pay);

   type RESERVOIR is
      record
         TOTAL: FLOAT_NUMBER;
         RESERVOIR_CATEGORY: FUEL_TYPES ;
      end record;


   type PUMP is
      record
         RESERVOIR_INFO: RESERVOIR:=(
                                     TOTAL=>10.00,
                                     RESERVOIR_CATEGORY=>FUEL_TYPES'Val(0));
         PUMP_STATE: STATE_TYPE:=STATE_TYPE'Val(0);
         PUMPED: FLOAT_NUMBER:=0.00;
         NOZZLE_STATE: NOZZLE_TYPE:=NOZZLE_TYPE'Val(0);
         UNIT_PRICE: FLOAT_NUMBER:=0.00;
         FUEL_TYPE: FUEL_TYPES:= FUEL_TYPES'Val(0);
      end record;

   --procedures
   procedure SET_FUEL_PRICE(pump_r: in out PUMP; PRICE: in FLOAT_NUMBER);
   procedure SET_PUMP_STATE(pump_r: in out PUMP; stateType: in STATE_TYPE);
   procedure SET_PUMPED(pump_r: in out PUMP; AMOUNT: in FLOAT_NUMBER);
   procedure SET_PUMP_NOZZLE_STATE(pump_r: in out PUMP; nozzleType: in NOZZLE_TYPE);

   procedure APPEND_RESERVOIR(pump_r: in out PUMP; fuelType: in FUEL_TYPES);

   procedure SET_RESERVOIR_SIZE(pump_r: in out PUMP; SIZE: in FLOAT_NUMBER);

   procedure REMOVE_PETROL_RESERVOIR (pump_r: in out PUMP; AMOUNT: in FLOAT_NUMBER)
     with
       pre=>(AMOUNT <= GET_TANKS_SIZE(pump_r)),
     post=>(GET_TANKS_SIZE(pump_r)>=0.00);

   --functions
   function GET_STATE(pump_r: in PUMP) return STATE_TYPE;
   function GET_CURRENT_NOZZLE_STATE(pump_r: in PUMP) return NOZZLE_TYPE;
   function GET_UNIT_PRICE(pump_r: in PUMP) return FLOAT_NUMBER;
   function GET_TANKS_SIZE(pump_r: in PUMP) return FLOAT_NUMBER;
   function GET_RESEVOIR_CATEGORY(pump_r: in PUMP) return FUEL_TYPES;

--  private




end PUMP;
