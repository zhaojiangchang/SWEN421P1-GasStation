with PUMP;
with sPrint; use sPrint;
package body PUMP
with SPARK_Mode is

     --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure SET_PUMP_STATE(
     A: in out PUMP_TYPE;
     STATE: in STATE_TPYE)
   is
   begin
      A.PUMP_STATE := STATE;
      print("Set Initial pump state to BASE");

   end SET_PUMP_STATE;

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure SET_RESERVOIR_SIZE(
     A: in out PUMP_TYPE;
     SIZE: in TANK_SIZE)
   is
   begin
      A.RESERVOIR_INFO.TOTAL := SIZE;
      print("Set Initial pump RESERVOIR SIZE: "& SIZE'Image);

   end SET_RESERVOIR_SIZE;
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
     (A: in out PUMP_TYPE; POSITION: in Integer)
   is
      R : PUMP.RESERVOIR(POSITION);
   begin
--        R := PUMP.RESERVOIR;

      R.RESERVOIR_POSITION := POSITION;
      A.RESERVOIR_INFO := R;
      print("Add Reservoir: "& POSITION'Image);
   end APPEND_RESERVOIR;


   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   procedure SET_FUEL_PRICE
     (A: in out PUMP_TYPE; PRICE: in PRICE_TYPE)
   is
   begin
      A.UNIT_PRICE := PRICE;
      print("fuel unit price: "& A.UNIT_PRICE'Image);
      --Put_Line(PRICE'Image);
   end SET_FUEL_PRICE;

--     -----------------------------
--     -- APPEND RESERVOIR TO PUMP --
--     -----------------------------
--     procedure SET_FUEL_NAME
--       (A: in out PUMP_TYPE; Name: in fuel)
--     is
--     begin
--        A.FUEL := Name;
--     end SET_FUEL_NAME;

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
 -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   function GET_CURRENT_RESERVOIR_SIZE
     (A: in PUMP_TYPE) return TANK_SIZE
   is
   begin
     -- print( "tank size: "&A.RESERVOIR_INFO.TOTAL'Image);
       return A.RESERVOIR_INFO.TOTAL;
   end GET_CURRENT_RESERVOIR_SIZE;

  -----------------------------
  -- GET STATE ----------------
  -----------------------------
   function GET_STATE(A: in out PUMP_TYPE) return STATE_TPYE
   is
   begin
      return A.PUMP_STATE;
   end GET_STATE;


end PUMP;
