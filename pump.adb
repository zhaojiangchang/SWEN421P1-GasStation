with PUMP;
package body PUMP is

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure ADD_PETROL_RESERVOIR
     (A: in out PUMP_PTR;
      AMOUNT: in TANK_SIZE)
   is
   begin
      A.RESERVOIR.TOTAL := A.RESERVOIR.TOTAL + AMOUNT;

   end ADD_PETROL_RESERVOIR;

   -----------------------------
   -- REMOVE_PETROL_RESERVOIR --
   -----------------------------

   procedure REMOVE_PETROL_RESERVOIR
     (A: in out PUMP_PTR;
      AMOUNT: in TANK_SIZE)
   is
   begin
      A.RESERVOIR.TOTAL := A.RESERVOIR.TOTAL - AMOUNT;
   end REMOVE_PETROL_RESERVOIR;

    -----------------------------
   -- APPEND RESERVOIR TO PUMP --
   -----------------------------
   procedure APPEND_RESERVOIR
     (A: in out PUMP_PTR; POSITION: in RESERVOIR_NUM)
   is
      R : RESERVOIR_PTR;
   begin
      R := new RESERVOIR;
      R.RESERVOIR_POSITION := POSITION;
      A.RESERVOIR := R;

   end APPEND_RESERVOIR;

  -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   function GET_CURRENT_RESERVOIR_SIZE
     (A: in PUMP_PTR) return TANK_SIZE
   is
   begin
       return A.RESERVOIR.TOTAL;
   end GET_CURRENT_RESERVOIR_SIZE;
   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   procedure SET_FUEL_PRICE
     (A: in out PUMP_PTR; PRICE: in PRICE_TYPE)
   is
   begin
       A.UNIT_PRICE := PRICE;
   end SET_FUEL_PRICE;

   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
   -----------------------------
   procedure SET_FUEL_NAME
     (A: in out PUMP_PTR; Name: in fuel)
   is
   begin
      A.FUEL := Name;
   end SET_FUEL_NAME;

   ------------------
   -- CHANGE_STATE --
   ------------------

   procedure CHANGE_STATE
     (A: in out PUMP_PTR;
      STATE :STATE_TPYE)
   is
   begin
     A.PUMP_STATE := STATE;

   end CHANGE_STATE;

   -------------------------
   -- IS_STATE_CHANGEABLE --
   -------------------------

   function IS_STATE_CHANGEABLE
     (A: in PUMP_PTR;
      FIRST:STATE_TPYE;
      SECOND:STATE_TPYE)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!

      return False;
   end IS_STATE_CHANGEABLE;



end PUMP;
