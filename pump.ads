
generic

package PUMP

with SPARK_Mode is

   --type PUMP is private;
   -- type RESERVOIR is private;
   type PUMP_TYPE  (FUEL: Positive) is private;
   type RESERVOIR  (FUEL: Positive) is private;
   type RESERVOIR_NUM is new Integer;
   type TANK_SIZE is new Integer range 1..10000;
   type FUEL_TYPES is new Integer range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;
   --type RESERVOIR_PTR is access RESERVOIR;
   subtype STATE_TPYE is String (1..9);
   --     subtype fuel is String (1..3);
   procedure ADD_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE)
     with pre => (AMOUNT >0 and AMOUNT <10000);


   procedure REMOVE_PETROL_RESERVOIR (A: in out PUMP_TYPE; AMOUNT: in TANK_SIZE);

   procedure CHANGE_STATE(A: in out PUMP_TYPE; STATE : in STATE_TPYE);

   function GET_CURRENT_RESERVOIR_SIZE(A: in PUMP_TYPE) return TANK_SIZE;
   function GET_STATE(A: in out PUMP_TYPE) return STATE_TPYE;


   procedure APPEND_RESERVOIR(A: in out PUMP_TYPE; POSITION: in Integer);
   procedure SET_FUEL_PRICE(A: in out PUMP_TYPE; PRICE: in PRICE_TYPE);
   procedure SET_PUMP_STATE(A: in out PUMP_TYPE; STATE: in STATE_TPYE);
   procedure SET_RESERVOIR_SIZE(A: in out PUMP_TYPE; SIZE: in TANK_SIZE);

private

   type RESERVOIR(FUEL: Positive) is
      record
         TOTAL: TANK_SIZE;
         RESERVOIR_POSITION: Integer;
         case FUEL is
            when 1 => R1: Positive := 1;
            when 2 => R2: Positive := 2;
            when 3 => R3: Positive := 3;
            when others => null;
         end case;
      end record;


   type PUMP_TYPE (FUEL: Positive) is
      record
         RESERVOIR_INFO: RESERVOIR(FUEL);
         PUMP_STATE: STATE_TPYE;
         UNIT_PRICE: PRICE_TYPE;
         case FUEL is
            when 1 => FUEL_TYPE1: Positive := 1;
            when 2 => FUEL_TYPE2: Positive := 1;
            when 3 => FUEL_TYPE3: Positive := 1;
            when others => null;
         end case;
      end record;



end PUMP;
