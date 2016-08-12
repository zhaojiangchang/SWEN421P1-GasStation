
generic

package PUMP
with SPARK_Mode is

   --type PUMP is private;
   -- type RESERVOIR is private;
   type PUMP_PTR is new PUMP;
   type PUMP_TYPE is private;
   type RESERVOIR is private;
   type RESERVOIR_NUM is range 1..3;
    type TANK_SIZE is new Integer range 1..10000;
   type FUEL_TYPES is new Integer range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;
   --type RESERVOIR_PTR is access RESERVOIR;
   type STATE_TPYE is (Base, Ready, Pumping, Waiting);
   subtype fuel is String (1..3);
   procedure ADD_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE)
     with pre => (AMOUNT >0 and AMOUNT <10000);


   procedure REMOVE_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE);

   procedure CHANGE_STATE(A: in out PUMP_TYPE; STATE : in STATE_TPYE);

   function GET_CURRENT_RESERVOIR_SIZE(A: in PUMP_TYPE) return TANK_SIZE;
   procedure APPEND_RESERVOIR(A: in out PUMP_TYPE; POSITION: in RESERVOIR_NUM);

   procedure SET_FUEL_PRICE(A: in out PUMP_TYPE; PRICE: in PRICE_TYPE);


   procedure SET_FUEL_NAME(A: in out PUMP_TYPE; Name: in fuel);


private

   type RESERVOIR is
      record
         TOTAL: TANK_SIZE;
         RESERVOIR_POSITION: RESERVOIR_NUM;
      end record;


   type PUMP_TYPE is
      record
         RESERVOIR_INFO: RESERVOIR;
         PUMP_STATE: STATE_TPYE;
         IS_USING: Boolean;
         PAID: Boolean;
         UNIT_PRICE: PRICE_TYPE;
         FUEL: String(1..3);
      end record;



end PUMP;
