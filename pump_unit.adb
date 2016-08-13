with sPrint; use sPrint;
with PUMP;
package body PUMP_UNIT
with SPARK_Mode is
   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMP(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES) is
      p91 : P.PUMP;
      p95 : P.PUMP;
      pDiesel : P.PUMP;

      use all type P.PUMP;
      nozzleStateType: P.NOZZLE_TYPE;
      baseStateType: P.STATE_TYPE;
   begin
      baseStateType:= P.STATE_TYPE'val(0);
      nozzleStateType := P.NOZZLE_TYPE'val(0);

      case P.FUEL_TYPES'Pos(fuelType) is
         when 0 =>
            print("add pump: 91");
            P.SET_FUEL_PRICE(p91,1.80);
            p.SET_PUMP_STATE(p91,baseStateType);
            P.APPEND_RESERVOIR(p91,fuelType);
            p.SET_RESERVOIR_SIZE(p91, 10000.00);
            pumpUnit.PUMP_91 := p91;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(p91, nozzleStateType);
         when 1 =>
            print("add pump: 95");
            P.SET_FUEL_PRICE(p95,2.10);
            p.SET_PUMP_STATE(p95,baseStateType);
            P.APPEND_RESERVOIR(p95, fuelType);
            p.SET_RESERVOIR_SIZE(p95, 10000.00);
            pumpUnit.PUMP_95 := p95;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(p95, nozzleStateType);
         when 2 =>
            print("add pump: Diesel");
            P.SET_FUEL_PRICE(pDiesel,1.10);
            p.SET_PUMP_STATE(pDiesel,baseStateType);
            P.APPEND_RESERVOIR(pDiesel, fuelType);
            p.SET_RESERVOIR_SIZE(pDiesel, 10000.00);
            pumpUnit.PUMP_Diesel := pDiesel;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            P.SET_PUMP_NOZZLE_STATE(pDiesel, nozzleStateType);
         when others => null;
      end case;
      print("");


   end ADD_PUMP;

   function GET_PUMP(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.PUMP
   is
   begin
      case P.FUEL_TYPES'Pos(fuelType) is
         when 0 => return pumpUnit.PUMP_91;
         when 1 => return pumpUnit.PUMP_95;
         when 2 => return pumpUnit.PUMP_Diesel;
         when others => return pumpUnit.PUMP_91;
      end case;
   end GET_PUMP;

   --------------------
   -- GET TANK SIZE --
   --------------------

   function GET_TANKS_SIZE(pumpUnit: in PUMP_UNIT; fuelType: in P.FUEL_TYPES) return P.FLOAT_NUMBER
   is
   begin
      case P.FUEL_TYPES'Pos(fuelType) is
         when 0 => return P.GET_TANKS_SIZE(pumpUnit.PUMP_91);
         when 1 => return P.GET_TANKS_SIZE(pumpUnit.PUMP_95);
         when 2 => return P.GET_TANKS_SIZE(pumpUnit.PUMP_Diesel);
         when others => return P.GET_TANKS_SIZE(pumpUnit.PUMP_91);
      end case;
   end GET_TANKS_SIZE;
   -----------------------
   -- SET_IS_USING False--
   -----------------------
   procedure SET_IS_USING(pumpUnit: in out PUMP_UNIT)
   is
      use all type P.STATE_TYPE;
      baseStateType: P.STATE_TYPE;

   begin
      baseStateType:= P.STATE_TYPE'val(0);
      if P.GET_STATE(pumpUnit.PUMP_91) = baseStateType and P.GET_STATE(pumpUnit.PUMP_95) =baseStateType and P.GET_STATE(pumpUnit.PUMP_Diesel) = baseStateType  then
         pumpUnit.IS_USING := False;
         print("set pump unit initial is used to false ");
      end if;
   end SET_IS_USING;
   -----------------------
   -- SET_IS_Paid true  --
   -----------------------
   procedure SET_IS_PAID(pumpUnit: in out PUMP_UNIT)
   is
      use all type P.STATE_TYPE;
      baseStateType: P.STATE_TYPE;
   begin
      if(pumpUnit.IS_PAID = False) then
         baseStateType:= P.STATE_TYPE'val(0);
         if P.GET_STATE(pumpUnit.PUMP_91) = baseStateType and P.GET_STATE(pumpUnit.PUMP_95) = baseStateType and P.GET_STATE(pumpUnit.PUMP_Diesel) =  baseStateType then
            pumpUnit.IS_PAID := True;
            print("set pump unit initial is paid to true ");
         end if;

      end if;
   end SET_IS_PAID;
   -----------------------
   -- SET_PUMP_ACTIVE  --
   -----------------------
   procedure SET_PUMP_ACTIVE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; stateType: in out P.STATE_TYPE)
   is
   begin
      if P.FUEL_TYPES'Pos(fuelType) =0 then
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         P.SET_PUMP_STATE(pumpUnit.PUMP_91,stateType);
      elsif P.FUEL_TYPES'Pos(fuelType) = 1 then
         pumpUnit.PUMP_ACTIVE_FUEL :=fuelType;
         P.SET_PUMP_STATE(pumpUnit.PUMP_95,stateType);
      elsif P.FUEL_TYPES'Pos(fuelType) = 2 then
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         P.SET_PUMP_STATE(pumpUnit.PUMP_Diesel, stateType);
      else
         print("FUEL_TYPE range 1..3");
      end if;

   end SET_PUMP_ACTIVE_STATE;
   -----------------------
   -- SET_PUMP_NOZZLE_STATE_ACTIVE  --
   -----------------------
   procedure SET_PUMP_NOZZLE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in P.FUEL_TYPES; nozzleType: in out P.NOZZLE_TYPE)
   is
   begin
      if P.FUEL_TYPES'Pos(fuelType) =0 then
         P.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_91, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
      elsif P.FUEL_TYPES'Pos(fuelType) = 1 then
         P.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_95, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
      elsif P.FUEL_TYPES'Pos(fuelType) = 2 then
         P.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_Diesel, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
      else
         print("FUEL_TYPE range 1..3");
      end if;

   end SET_PUMP_NOZZLE_STATE;

   -----------------------
   -- UNIT_IS_USING     --
   -----------------------
   function UNIT_IS_USING(pumpUnit: in PUMP_UNIT) return Boolean
   is
   begin
      return pumpUnit.IS_USING;
   end UNIT_IS_USING;

   -----------------------
   -- UNIT_IS_PAID      --
   -----------------------
   function UNIT_IS_PAID(pumpUnit: in PUMP_UNIT) return Boolean
   is
   begin
      return pumpUnit.IS_PAID;
   end UNIT_IS_PAID;

   -----------------------
   --   LEFT_NOZZLE     --
   -----------------------
   procedure LEFT_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out P.PUMP; fuelType: in P.FUEL_TYPES) is
   begin
      if P.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "BASE" then
         pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
         pumpUnit.PUMP_ACTIVE_FUEL:= fuelType;
         pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(1);
         P.SET_PUMP_STATE(pump_r, P.STATE_TYPE'Val(1));
         P.SET_PUMP_NOZZLE_STATE(pump_r,  P.NOZZLE_TYPE'Val(1));
         print("left node from base state");
      elsif P.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "WAITING" and P.STATE_TYPE'Image(P.GET_STATE(pump_r)) = "WAITING" then
         pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(1);
         P.SET_PUMP_STATE(pump_r, P.STATE_TYPE'Val(1));
         P.SET_PUMP_NOZZLE_STATE(pump_r,  P.NOZZLE_TYPE'Val(1));
         print("left node from waiting state");
      else
         print("your are not allow use more then one nozzle at same time");
      end if;
   end LEFT_NOZZLE;
   -----------------------
   --   RETURN_NOZZLE   --
   -----------------------
   procedure RETURN_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r: in out P.PUMP) is
      due: FLOAT_NUMBER;
   begin
      due:=0.00;
      if P.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "READY" and P.STATE_TYPE'Image(P.GET_STATE(pump_r)) = "READY" then
         if pumpUnit.TO_PAY > due then
            pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(3);
            pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(5);
            P.SET_PUMP_STATE(pump_r, P.STATE_TYPE'Val(3));
            P.SET_PUMP_NOZZLE_STATE(pump_r,  P.NOZZLE_TYPE'Val(5));
            print("return nozzle to waiting state TO_PAY: " & pumpUnit.TO_PAY'Image);
         else
            pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(0);
            pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(0);
            P.SET_PUMP_STATE(pump_r, P.STATE_TYPE'Val(0));
            P.SET_PUMP_NOZZLE_STATE(pump_r,  P.NOZZLE_TYPE'Val(0));
            print("return nozzle to base state TO_PAY = 0");
         end if;
      else
         print("you are not supports not to use this nozzle other nozzle currently in use");
      end if;
   end RETURN_NOZZLE;
   -----------------------
   --   START_PUMPING   --
   -----------------------
   procedure START_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r: in out P.PUMP; AMOUNT: in P.FLOAT_NUMBER; CAR_TANK_SPACE: in out P.FLOAT_NUMBER)
   is
      use all type P.FLOAT_NUMBER;
      tankSize: P.FLOAT_NUMBER;
      pumped: P.FLOAT_NUMBER;
      SENSOR: Boolean;
      temp: P.FLOAT_NUMBER;

   begin
      temp:=0.00;
      pumped:=0.00;
      SENSOR := False;
      if P.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "READY"  and P.STATE_TYPE'Image(P.GET_STATE(pump_r)) = "READY" then
         tankSize :=  P.GET_TANKS_SIZE(pump_r);
         if tankSize <= 0.00 then
            print("tank empty");
         end if;
         if AMOUNT >0.00 and SENSOR = False and tankSize > temp then
            pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(2);
            pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(3);
            P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(3));
            P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(2));
            while CAR_TANK_SPACE>0.00 and tankSize >temp and SENSOR = False and pumped <= AMOUNT loop
               pumped:= pumped +0.01;
               pumpUnit.TO_PAY := pumpUnit.TO_PAY + (0.01 * P.GET_UNIT_PRICE(pump_r));
               CAR_TANK_SPACE:= CAR_TANK_SPACE - 0.01;
               print("pumping: " & pumped'Image & "  car tank space left: " & CAR_TANK_SPACE'Image &"  Amount To Pay: "& pumpUnit.TO_PAY'Image);
               P.REMOVE_PETROL_RESERVOIR(pump_r,0.01);
               tankSize := P.GET_TANKS_SIZE(pump_r);
               if CAR_TANK_SPACE <=0.00 then
                  SENSOR := True;
                  pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
                  P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
                  pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
                  P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
                  print("car tank space = 0.00 sensor = true");
               elsif tankSize <= 0.00 then
                  pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
                  P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
                  pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
                  P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
                  print("tankSize empty");
               elsif pumped>= AMOUNT then
                  print("pumped given amount");
                  pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
                  P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
                  pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
                  P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
               end if;
            end loop;

         end if;
         if AMOUNT =0.00 then
            pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(3);
            pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(2);
            P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(3));
            P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(2));
            while SENSOR = False and tankSize > 0.00 loop

               pumped:= pumped +0.01;
               pumpUnit.TO_PAY := pumpUnit.TO_PAY + (0.01 * P.GET_UNIT_PRICE(pump_r));
               CAR_TANK_SPACE:= CAR_TANK_SPACE - 0.01;
               print("pumping: " & pumped'Image & "    car tank space left: " & CAR_TANK_SPACE'Image &"  Amount To Pay: "& pumpUnit.TO_PAY'Image);
               P.REMOVE_PETROL_RESERVOIR(pump_r,0.01);
               tankSize := P.GET_TANKS_SIZE(pump_r);
               if CAR_TANK_SPACE <=0.00 then
                  SENSOR := True;
                  pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
                  P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
                  pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
                  P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
                  print("car tank space = 0.00 sensor = true");
               elsif tankSize <= 0.00 then
                  pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
                  P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
                  pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
                  P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
                  print("tankSize empty");
               end if;
            end loop;
         end if;
      else
         print("you can not pumping - only ready state -> pumping");
      end if;
   end START_PUMPING;
   -----------------------
   --   STOP_PUMPING   --
   -----------------------
   procedure STOP_PUMPING(pumpUnit: in out PUMP_UNIT; pump_r: in out P.PUMP) is
   begin
      if P.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "PUMPING"  and P.STATE_TYPE'Image(P.GET_STATE(pump_r)) = "PUMPING" then
         pumpUnit.PUMP_ACTIVE_STATE := P.STATE_TYPE'Val(1);
         pumpUnit.PUMP_NOZZLE_STATE:= P.NOZZLE_TYPE'Val(4);
         P.SET_PUMP_STATE(pump_r,P.STATE_TYPE'Val(1));
         P.SET_PUMP_NOZZLE_STATE(pump_r, P.NOZZLE_TYPE'Val(4));
         print("stop pumping");
      end if;

   end STOP_PUMPING;
end PUMP_UNIT;
