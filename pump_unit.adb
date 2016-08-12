with sPrint; use sPrint;
with PUMP;
package body PUMP_UNIT
with SPARK_Mode is

   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMP(A: in out PUMP_UNIT_R; B: in FUEL_TYPE) is
      p91 : P.PUMP_TYPE(1);
      p95 : P.PUMP_TYPE(2);
      pDiesel : P.PUMP_TYPE(3);
      stateType : P.STATE_TPYE;
   begin
   stateType := "BASE     ";

      case B is
         when 1 =>
            print("add pump: 91");
            P.SET_FUEL_PRICE(p91,1.80);
            p.SET_PUMP_STATE(p91,stateType);
            P.APPEND_RESERVOIR(p91, 1);
            p.SET_RESERVOIR_SIZE(p91, 10000);
            A.PUMP_91 := p91;
         when 2 =>
            print("add pump: 95");
            P.SET_FUEL_PRICE(p95,2.10);
            p.SET_PUMP_STATE(p95,stateType);
            P.APPEND_RESERVOIR(p95, 2);
            p.SET_RESERVOIR_SIZE(p95, 10000);
            A.PUMP_95 := p95;
         when 3 =>
            print("add pump: Diesel");
            P.SET_FUEL_PRICE(pDiesel,1.10);
            p.SET_PUMP_STATE(pDiesel,stateType);
            P.APPEND_RESERVOIR(pDiesel, 3);
            p.SET_RESERVOIR_SIZE(pDiesel, 10000);
            A.PUMP_Diesel := pDiesel;
         when others => null;
      end case;
      print("");


   end ADD_PUMP;

   function GET_PUMP(A: in out PUMP_UNIT_R; B: in FUEL_TYPE) return P.PUMP_TYPE
   is
   begin
      case B is
         when 1 => return A.PUMP_91;
         when others => return A.PUMP_91;
      end case;
   end GET_PUMP;

   --------------------
   -- GET TANK SIZE --
   --------------------

   function GET_TANKS_SIZE(A: in PUMP_UNIT_R; B: in FUEL_TYPE) return P.TANK_SIZE
   is
   begin
      case B is
         when 1 => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91);
         when others => return P.GET_CURRENT_RESERVOIR_SIZE(A.PUMP_91);
      end case;
   end GET_TANKS_SIZE;
   -----------------------
   -- SET_IS_USING False--
   -----------------------
   procedure SET_IS_USING(A: in out PUMP_UNIT_R)
   is
   begin
      if P.GET_STATE(A.PUMP_91) = "BASE     " and P.GET_STATE(A.PUMP_95) = "BASE     " and P.GET_STATE(A.PUMP_Diesel) =  "BASE     "  then
         A.IS_USING := False;
         print("set pump unit initial is used to false ");
      end if;
   end SET_IS_USING;
   -----------------------
   -- SET_IS_Paid true  --
   -----------------------
   procedure SET_IS_PAID(A: in out PUMP_UNIT_R)
   is
   begin
      if P.GET_STATE(A.PUMP_91) = "BASE     " and P.GET_STATE(A.PUMP_95) = "BASE     " and P.GET_STATE(A.PUMP_Diesel) =  "BASE     "  then
         A.IS_PAID := True;
         print("set pump unit initial is paid to true ");
      end if;
   end SET_IS_PAID;

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
