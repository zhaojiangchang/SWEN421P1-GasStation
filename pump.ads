
generic

package PUMP

with SPARK_Mode is

   type RESERVOIR_NUM is new Integer;
   type TANK_SIZE is delta 0.01 digits 10;
   type PRICE_TYPE is delta 0.01 digits 10;
   type PUMPED_TYPE  is delta 0.01 digits 10;
   type FUEL_TYPES is (U91, U95, Diesel);
   type PUMP_TYPE is private;
   type RESERVOIR is private;
   type STATE_TPYE is (Base, Ready, Pumping, Waiting);
   type NOZZLE_TYPE is (NozzleBase, Lift, Replace,Start, Stop, Pay);

   --procedures
   procedure ADD_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE)
     with pre => (AMOUNT >0.00 and AMOUNT <100000.00);
   procedure REMOVE_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE);
   procedure CHANGE_STATE(A: in out PUMP_TYPE; STATE : in STATE_TPYE);
   procedure APPEND_RESERVOIR(A: in out PUMP_TYPE; F_CATEGORY: in FUEL_TYPES);
   procedure SET_FUEL_PRICE(A: in out PUMP_TYPE; PRICE: in PRICE_TYPE);
   procedure SET_PUMP_STATE(A: in out PUMP_TYPE; STATE: in STATE_TPYE);
   procedure SET_PUMP_NOZZLE_STATE(A: in out PUMP_TYPE; NOZZLE_STATE: in NOZZLE_TYPE);
   --       with
   --         pre =>(PUMP.);
   --       post =>();
   procedure SET_RESERVOIR_SIZE(A: in out PUMP_TYPE; SIZE: in TANK_SIZE)
     with
       pre =>(SIZE > 0.00 and SIZE <10_000.00);


   --functions
   function GET_CURRENT_RESERVOIR_SIZE(A: in PUMP_TYPE) return TANK_SIZE;
   function GET_STATE(A: in PUMP_TYPE) return STATE_TPYE;
   function GET_CURRENT_NOZZLE_STATE(A: in PUMP_TYPE) return NOZZLE_TYPE;


private

   type RESERVOIR is
      record
         TOTAL: TANK_SIZE;
         RESERVOIR_CATEGORY: FUEL_TYPES ;
      end record;


   type PUMP_TYPE is
      record
         RESERVOIR_INFO: RESERVOIR;
         PUMP_STATE: STATE_TPYE;
         PUMPED: PUMPED_TYPE;
         NOZZLE_STATE: NOZZLE_TYPE;
         UNIT_PRICE: PRICE_TYPE;
         FUEL_TYPE: FUEL_TYPES;
      end record;



end PUMP;
