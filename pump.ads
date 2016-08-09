
generic

   type TOTAL_PER_RESERVOIR is range <>;


package PUMP is
   type PUMP is private;
   type RESERVOIR is private;
   type PUMP_PTR is access PUMP;
   type RESERVOIR_NUM is range 1..3;
   type PRICE_TYPE is delta 0.01 digits 10;
   type RESERVOIR_PTR is access RESERVOIR;
   type PETROL_TYPE is (U91,U95, Diesel);
   type STATE_TPYE is (Base, Ready, Pumping, Waiting);

   procedure ADD_PETROL_RESERVOIR (A: in out PUMP_PTR; AMOUNT: in TOTAL_PER_RESERVOIR);
   --postcondition: amount + reservoir_pir.total<10000
   --precondition: amount >0 <10000

   procedure REMOVE_PETROL_RESERVOIR (A: in out RESERVOIR_PTR; AMOUNT: in TOTAL_PER_RESERVOIR);

   procedure CHANGE_STATE(A: in out PUMP_PTR; FIRST:STATE_TPYE; SECOND:STATE_TPYE);

   function IS_STATE_CHANGEABLE(A: in PUMP_PTR; FIRST:STATE_TPYE; SECOND:STATE_TPYE) return Boolean;

private

   type RESERVOIR (Option: PETROL_TYPE := U91)is
      record
         TOTAL:TOTAL_PER_RESERVOIR := 10000;
         case Option is
            when U91 =>
               RESERVOIR_U91: RESERVOIR_NUM := 1;
            when U95 =>
               RESERVOIR_U95: RESERVOIR_NUM := 2;
            when Diesel =>
               RESERVOIR_DIESEL: RESERVOIR_NUM := 3;
         end case;
      end record;


   type PUMP (Option: PETROL_TYPE := U91)is
      record

         RESERVOIR: RESERVOIR_PTR := null;
         PUMP_STATE: STATE_TPYE := BASE;
         IS_USING: Boolean := False;
         PAID: Boolean := False;
         case Option is
            when U91 =>
               UNIT_PRICE_U91: PRICE_TYPE := 1.80;
            when U95 =>
               UNIT_PRICE_U95: PRICE_TYPE := 2.00;
            when Diesel =>
               UNIT_PRICE_DIESEL: PRICE_TYPE := 1.00;
         end case;
      end record;



end PUMP;
