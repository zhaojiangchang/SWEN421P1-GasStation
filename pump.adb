with PUMP;
with sPrint; use sPrint;
package body PUMP
with SPARK_Mode is

   --------------------------
   -- SET_PUMP_STATE --
   --------------------------

   procedure SET_PUMP_STATE(
     pump_r: in out PUMP;
     stateType: in STATE_TYPE)
   is
   begin
      pump_r.PUMP_STATE := stateType;
      print("Chage State: " & stateType'Image);

   end SET_PUMP_STATE;

   --------------------------
   -- SET_PUMP_STATE --
   --------------------------

   procedure SET_PUMP_NOZZLE_STATE(
     pump_r: in out PUMP;
     nozzleType: in NOZZLE_TYPE)
   is
   begin
      pump_r.NOZZLE_STATE := nozzleType;
      print("Chage Nozzle State: "& nozzleType'Image);

   end SET_PUMP_NOZZLE_STATE;

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure SET_RESERVOIR_SIZE(
     pump_r: in out PUMP;
     SIZE: in FLOAT_NUMBER)
   is
   begin
      pump_r.RESERVOIR_INFO.TOTAL := SIZE;
      print("RESERVOIR SIZE: "& SIZE'Image);

   end SET_RESERVOIR_SIZE;
   --------------------------
   -- GET_UNIT_PRICE --------
   --------------------------
   function GET_UNIT_PRICE(pump_r: in PUMP) return FLOAT_NUMBER
   is
   begin
      return pump_r.UNIT_PRICE;
   end GET_UNIT_PRICE;

    --------------------------
   -- GET_TANKS_SIZE --------
   --------------------------
   function GET_TANKS_SIZE(pump_r: in PUMP) return FLOAT_NUMBER
   is
   begin
      return pump_r.RESERVOIR_INFO.TOTAL;
   end GET_TANKS_SIZE;

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------
   procedure ADD_PETROL_RESERVOIR
     (pump_r: in out PUMP;
      AMOUNT: in FLOAT_NUMBER)
   is
   begin
      pump_r.RESERVOIR_INFO.TOTAL := pump_r.RESERVOIR_INFO.TOTAL + AMOUNT;

   end ADD_PETROL_RESERVOIR;

   -----------------------------
   -- REMOVE_PETROL_RESERVOIR --
   -----------------------------

   procedure REMOVE_PETROL_RESERVOIR
     (pump_r: in out PUMP;
      AMOUNT: in FLOAT_NUMBER)
   is
   begin
      pump_r.RESERVOIR_INFO.TOTAL := pump_r.RESERVOIR_INFO.TOTAL - AMOUNT;
   end REMOVE_PETROL_RESERVOIR;

   -----------------------------
   -- SET_PUMPED ---------------
   -----------------------------

   procedure SET_PUMPED
     (pump_r: in out PUMP;
      AMOUNT: in FLOAT_NUMBER)
   is
   begin
      pump_r.PUMPED := AMOUNT;
   end SET_PUMPED;
   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
   -----------------------------
   procedure APPEND_RESERVOIR
     (pump_r: in out PUMP; fuelType: in FUEL_TYPES)
   is
      R : RESERVOIR;
   begin
--        R := PUMP.RESERVOIR;

      R.RESERVOIR_CATEGORY := fuelType;
      pump_r.RESERVOIR_INFO := R;
      print("Add Reservoir: "& fuelType'Image);
   end APPEND_RESERVOIR;


   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   procedure SET_FUEL_PRICE
     (pump_r: in out PUMP; PRICE: in FLOAT_NUMBER)
   is
   begin
      pump_r.UNIT_PRICE := PRICE;
      print("fuel unit price: "& pump_r.UNIT_PRICE'Image);
      --Put_Line(PRICE'Image);
   end SET_FUEL_PRICE;

--     -----------------------------
--     -- APPEND RESERVOIR TO PUMP --
--     -----------------------------
--     procedure SET_FUEL_NAME
--       (pump_r: in out PUMP_TYPE; Name: in fuel)
--     is
--     begin
--        pump_r.FUEL := Name;
--     end SET_FUEL_NAME;

   ------------------
   -- CHANGE_STATE --
   ------------------

   procedure CHANGE_STATE
     (pump_r: in out PUMP;
      stateType : in STATE_TYPE)
   is
   begin
     pump_r.PUMP_STATE := stateType;

   end CHANGE_STATE;

   -------------------------
   -- IS_STATE_CHANGEABLE --
   -------------------------

--     function IS_STATE_CHANGEABLE
--       (pump_r: in PUMP_TYPE;
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
  --GET_CURRENT_NOZZLE_STATE --
  -----------------------------

   function GET_CURRENT_NOZZLE_STATE
     (pump_r: in PUMP) return NOZZLE_TYPE
   is
   begin
     -- print( "tank size: "&pump_r.RESERVOIR_INFO.TOTAL'Image);
       return pump_r.NOZZLE_STATE;
   end GET_CURRENT_NOZZLE_STATE;


  -----------------------------
  -- GET STATE ----------------
  -----------------------------
   function GET_STATE(pump_r: in PUMP) return STATE_TYPE
   is
   begin
      return pump_r.PUMP_STATE;
   end GET_STATE;


end PUMP;
