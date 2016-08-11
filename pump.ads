
generic

package PUMP is
   type PUMP is private;
   type RESERVOIR is private;
   type PUMP_PTR is access PUMP;
   type RESERVOIR_NUM is range 1..3;
    type TANK_SIZE is new Integer range 1..10000;
   type FUEL_TYPES is new Integer range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;
   type RESERVOIR_PTR is access RESERVOIR;
   type STATE_TPYE is (Base, Ready, Pumping, Waiting);
   subtype fuel is String (1..3);
   procedure ADD_PETROL_RESERVOIR (A: in out PUMP_PTR; AMOUNT: in TANK_SIZE);
   --postcondition: amount + reservoir_pir.total<10000
   --precondition: amount >0 <10000

   procedure REMOVE_PETROL_RESERVOIR (A: in out PUMP_PTR; AMOUNT: in TANK_SIZE);

   procedure CHANGE_STATE(A: in out PUMP_PTR; STATE :STATE_TPYE);

   function IS_STATE_CHANGEABLE(A: in PUMP_PTR; FIRST:STATE_TPYE; SECOND:STATE_TPYE) return Boolean;
   function GET_CURRENT_RESERVOIR_SIZE(A: in PUMP_PTR) return TANK_SIZE;
   procedure APPEND_RESERVOIR(A: in out PUMP_PTR; POSITION: in RESERVOIR_NUM);

   procedure SET_FUEL_PRICE(A: in out PUMP_PTR; PRICE: in PRICE_TYPE);
   procedure SET_FUEL_NAME(A: in out PUMP_PTR; Name: in fuel);

private

   type RESERVOIR is
      record
         TOTAL: TANK_SIZE := 9999;
         RESERVOIR_POSITION: RESERVOIR_NUM := 1;
      end record;


   type PUMP is
      record
         RESERVOIR: RESERVOIR_PTR := null;
         PUMP_STATE: STATE_TPYE := BASE;
         IS_USING: Boolean := False;
         PAID: Boolean := True;
         UNIT_PRICE: PRICE_TYPE := 0.00;
         FUEL: String(1..3) := "U91";
      end record;



end PUMP;
