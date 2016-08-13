with sPrint; use sPrint;
with Ada.Text_io; use Ada.Text_IO;
with PUMP;
package body PUMP_UNIT
with SPARK_Mode is
   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMP(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES) is
      p91 : P.PUMP_TYPE;
      p95 : P.PUMP_TYPE;
      pDiesel : P.PUMP_TYPE;

      use all type P.PUMP_TYPE;
      nozzleStateType: P.NOZZLE_TYPE;
      baseStateType: P.STATE_TPYE;
   begin
      baseStateType:= P.STATE_TPYE'val(0);
      nozzleStateType := P.NOZZLE_TYPE'val(0);

      case P.FUEL_TYPES'Pos(B) is
         when 0 =>
            print("add pump: 91");
            P.SET_FUEL_PRICE(p91,1.80);
            p.SET_PUMP_STATE(p91,baseStateType);
            P.APPEND_RESERVOIR(p91,B);
            p.SET_RESERVOIR_SIZE(p91, 10000.00);
            A.PUMP_91 := p91;
            A.IS_USING := False;
            A.IS_PAID := True;
            A.NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(p91, nozzleStateType);
         when 1 =>
            print("add pump: 95");
            P.SET_FUEL_PRICE(p95,2.10);
            p.SET_PUMP_STATE(p95,baseStateType);
            P.APPEND_RESERVOIR(p95, B);
            p.SET_RESERVOIR_SIZE(p95, 10000.00);
            A.PUMP_95 := p95;
            A.IS_USING := False;
            A.IS_PAID := True;
            A.NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(p95, nozzleStateType);
         when 2 =>
            print("add pump: Diesel");
            P.SET_FUEL_PRICE(pDiesel,1.10);
            p.SET_PUMP_STATE(pDiesel,baseStateType);
            P.APPEND_RESERVOIR(pDiesel, B);
            p.SET_RESERVOIR_SIZE(pDiesel, 10000.00);
            A.PUMP_Diesel := pDiesel;
            A.IS_USING := False;
            A.IS_PAID := True;
            A.NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(pDiesel, nozzleStateType);
         when others => null;
      end case;
      print("");


   end ADD_PUMP;

   function GET_PUMP(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES) return P.PUMP_TYPE
   is
   begin
      case P.FUEL_TYPES'Pos(B) is
         when 0 => return A.PUMP_91;
         when 1 => return A.PUMP_95;
         when 2 => return A.PUMP_Diesel;
         when others => return A.PUMP_91;
      end case;
   end GET_PUMP;

   --------------------
   -- GET TANK SIZE --
   --------------------

   function GET_TANKS_SIZE(A: in PUMP_UNIT_R; B: in P.FUEL_TYPES) return P.TANK_SIZE
   is
   begin
      case P.FUEL_TYPES'Pos(B) is
         when 0 => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91);
         when 1 => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_95);
         when 2 => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_Diesel);
         when others => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91);
      end case;
   end GET_TANKS_SIZE;
   -----------------------
   -- SET_IS_USING False--
   -----------------------
   procedure SET_IS_USING(A: in out PUMP_UNIT_R)
   is
      use all type P.STATE_TPYE;
      baseStateType: P.STATE_TPYE;

   begin
      baseStateType:= P.STATE_TPYE'val(0);
      if P.GET_STATE(A.PUMP_91) = baseStateType and P.GET_STATE(A.PUMP_95) =baseStateType and P.GET_STATE(A.PUMP_Diesel) = baseStateType  then
         A.IS_USING := False;
         print("set pump unit initial is used to false ");
      end if;
   end SET_IS_USING;
   -----------------------
   -- SET_IS_Paid true  --
   -----------------------
   procedure SET_IS_PAID(A: in out PUMP_UNIT_R)
   is
      use all type P.STATE_TPYE;
      baseStateType: P.STATE_TPYE;
   begin
      if(A.IS_PAID = False) then
         baseStateType:= P.STATE_TPYE'val(0);
         if P.GET_STATE(A.PUMP_91) = baseStateType and P.GET_STATE(A.PUMP_95) = baseStateType and P.GET_STATE(A.PUMP_Diesel) =  baseStateType then
            A.IS_PAID := True;
            print("set pump unit initial is paid to true ");
         end if;

      end if;
   end SET_IS_PAID;
   -----------------------
   -- SET_PUMP_ACTIVE  --
   -----------------------
   procedure SET_PUMP_ACTIVE(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES; C: in out P.STATE_TPYE)
   is
   begin
      if P.FUEL_TYPES'Pos(B) =0 then
         A.PUMP_ACTIVE := B;
         P.SET_PUMP_STATE(A.PUMP_91, C);
      elsif P.FUEL_TYPES'Pos(B) = 1 then
         A.PUMP_ACTIVE :=B;
         P.SET_PUMP_STATE(A.PUMP_95, C);
      elsif P.FUEL_TYPES'Pos(B) = 2 then
         A.PUMP_ACTIVE := B;
         P.SET_PUMP_STATE(A.PUMP_Diesel, C);
      else
         print("FUEL_TYPE range 1..3");
      end if;

   end SET_PUMP_ACTIVE;
   -----------------------
   -- SET_PUMP_NOZZLE_STATE_ACTIVE  --
   -----------------------
   procedure SET_PUMP_NOZZLE_STATE(A: in out PUMP_UNIT_R; B: in P.FUEL_TYPES; C: in out P.NOZZLE_TYPE)
   is
   begin
      if P.FUEL_TYPES'Pos(B) =0 then
         P.SET_PUMP_NOZZLE_STATE(A.PUMP_91, C);
         A.NOZZLE_STATE := C;
      elsif P.FUEL_TYPES'Pos(B) = 1 then
         P.SET_PUMP_NOZZLE_STATE(A.PUMP_95, C);
         A.NOZZLE_STATE := C;
      elsif P.FUEL_TYPES'Pos(B) = 2 then
         P.SET_PUMP_NOZZLE_STATE(A.PUMP_Diesel, C);
         A.NOZZLE_STATE := C;
      else
         print("FUEL_TYPE range 1..3");
      end if;

   end SET_PUMP_NOZZLE_STATE;

   -----------------------
   -- UNIT_IS_USING     --
   -----------------------
   function UNIT_IS_USING(A: in PUMP_UNIT_R) return Boolean
   is
   begin
      return A.IS_USING;
   end UNIT_IS_USING;

   -----------------------
   -- UNIT_IS_PAID      --
   -----------------------
   function UNIT_IS_PAID(A: in PUMP_UNIT_R) return Boolean
   is
   begin
      return A.IS_PAID;
   end UNIT_IS_PAID;
end PUMP_UNIT;
