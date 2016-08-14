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
      print_state_type("Chage State: " , stateType);

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
      print_nozzle_type("Chage Nozzle State: ", nozzleType);

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
      print_float_type("RESERVOIR SIZE: ", SIZE);

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
   -- GET_RESEVOIR_CATEGORY --------
   --------------------------
   function GET_RESEVOIR_CATEGORY(pump_r: in PUMP) return FUEL_TYPES
   is
   begin
      return pump_r.RESERVOIR_INFO.RESERVOIR_CATEGORY;
   end GET_RESEVOIR_CATEGORY;
   -----------------------------
   -- REMOVE_PETROL_RESERVOIR --
   -----------------------------

   procedure REMOVE_PETROL_RESERVOIR
     (pump_r: in out PUMP;
      AMOUNT: in FLOAT_NUMBER)
   is
   begin
      if pump_r.RESERVOIR_INFO.TOTAL > AMOUNT then
         pump_r.RESERVOIR_INFO.TOTAL := pump_r.RESERVOIR_INFO.TOTAL - AMOUNT;
      end if;
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
--        R := RESERVOIR;

      R.RESERVOIR_CATEGORY := fuelType;
      R.TOTAL:= 1000.00;
      pump_r.RESERVOIR_INFO := R;
      print_fuel_type("Add Reservoir: ", fuelType);
   end APPEND_RESERVOIR;


   -----------------------------
   -- APPEND RESERVOIR TO PUMP --
  -----------------------------

   procedure SET_FUEL_PRICE
     (pump_r: in out PUMP; PRICE: in FLOAT_NUMBER)
   is
   begin
      pump_r.UNIT_PRICE := PRICE;
      print_float_type("fuel unit price: ", pump_r.UNIT_PRICE);
      --Put_Line(PRICE'Image);
   end SET_FUEL_PRICE;

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
