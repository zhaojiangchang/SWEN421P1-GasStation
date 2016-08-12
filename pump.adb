with PUMP;
with Ada.Text_IO; use Ada.Text_IO;
package body PUMP
with SPARK_Mode is

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure ADD_PETROL_RESERVOIR
     (A: in out PUMP_TYPE;
      AMOUNT: in TANK_SIZE)
   is
   begin
      A.RESERVOIR_INFO.TOTAL := A.RESERVOIR_INFO.TOTAL + AMOUNT;

   end ADD_PETROL_RESERVOIR;

   -----------------------------
   -- REMOVE_PETROL_RESERVOIR --
   -----------------------------

   procedure REMOVE_PETROL_RESERVOIR
     (A: in out PUMP_TYPE;
      AMOUNT: in TANK_SIZE)
   is
   begin
      A.RESERVOIR_INFO.TOTAL := A.RESERVOIR_INFO.TOTAL - AMOUNT;
   end REMOVE_PETROL_RESERVOIR;

    -----------------------------
   -- APPEND RESERVOIR TO PUMP --
   -----------------------------
   procedure APPEND_RESERVOIR
     (A: in out PUMP_TYPE; POSITION: in RESERVOIR_NUM)
   is
      R : RESERVOIR;
   begin
--        R := new RESERVOIR;
      R.RESERVOIR_POSITION := POSITION;
      A.RESERVOIR_INFO := R;

   end APPEND_RESERVOIR;

  -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   function GET_CURRENT_RESERVOIR_SIZE
     (A: in PUMP_TYPE) return TANK_SIZE
   is
   begin
       return A.RESERVOIR_INFO.TOTAL;
   end GET_CURRENT_RESERVOIR_SIZE;
   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   procedure SET_FUEL_PRICE
     (A: in out PUMP_TYPE; PRICE: in PRICE_TYPE)
   is
   begin
      A.UNIT_PRICE := PRICE;
      --Put_Line(PRICE'Image);
   end SET_FUEL_PRICE;

   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
   -----------------------------
   procedure SET_FUEL_NAME
     (A: in out PUMP_TYPE; Name: in fuel)
   is
   begin
      A.FUEL := Name;
   end SET_FUEL_NAME;

   ------------------
   -- CHANGE_STATE --
   ------------------

   procedure CHANGE_STATE
     (A: in out PUMP_TYPE;
      STATE : in STATE_TPYE)
   is
   begin
     A.PUMP_STATE := STATE;

   end CHANGE_STATE;

   -------------------------
   -- IS_STATE_CHANGEABLE --
   -------------------------

--     function IS_STATE_CHANGEABLE
--       (A: in PUMP_TYPE;
--        FIRST:STATE_TPYE;
--        SECOND:STATE_TPYE)
--        return Boolean
--     is
--     begin
--        --  Generated stub: replace with real body!
--
--        return False;
--     end IS_STATE_CHANGEABLE;



end PUMP;
