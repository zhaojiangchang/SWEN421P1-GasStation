with sPrint; use sPrint;
with PUMP;
with Ada.Exceptions;
package body PUMP_UNIT
with SPARK_Mode is
   --------------
   -- ADD_PUMP --
   --------------

   procedure ADD_PUMP(pumpUnit: in out PUMP_UNIT; pump_r : in out PUMP.PUMP; fuelType: in PUMP.FUEL_TYPES) is
      --        p91 : PUMP;
      --        p95 : PUMP;
      --        pDiesel : PUMP;

      nozzleStateType: PUMP.NOZZLE_TYPE;
      baseStateType: PUMP.STATE_TYPE;
   begin
      baseStateType:= PUMP.STATE_TYPE'val(0);
      nozzleStateType := PUMP.NOZZLE_TYPE'val(0);

      case fuelType is
         when PUMP.U91 =>
            print("add pump: 91");
            PUMP.SET_FUEL_PRICE(pump_r,1.80);
            PUMP.SET_PUMP_STATE(pump_r,baseStateType);
            PUMP.APPEND_RESERVOIR(pump_r,fuelType);
            PUMP.SET_RESERVOIR_SIZE(pump_r, 1000.00);
            pumpUnit.PUMP_91 := pump_r;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMPED:=0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r, nozzleStateType);
         when PUMP.U95 =>
            print("add pump: 95");
            PUMP.SET_FUEL_PRICE(pump_r,2.10);
            PUMP.SET_PUMP_STATE(pump_r,baseStateType);
            PUMP.APPEND_RESERVOIR(pump_r, fuelType);
            PUMP.SET_RESERVOIR_SIZE(pump_r, 1000.00);
            pumpUnit.PUMP_95 := pump_r;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMPED:=0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r, nozzleStateType);
         when PUMP.Diesel =>
            print("add pump: Diesel");
            PUMP.SET_FUEL_PRICE(pump_r,1.10);
            PUMP.SET_PUMP_STATE(pump_r,baseStateType);
            PUMP.APPEND_RESERVOIR(pump_r, fuelType);
            PUMP.SET_RESERVOIR_SIZE(pump_r, 1000.00);
            pumpUnit.PUMP_Diesel := pump_r;
            pumpUnit.IS_USING := False;
            pumpUnit.IS_PAID := True;
            pumpUnit.TO_PAY:= 0.00;
            pumpUnit.PUMPED:=0.00;
            pumpUnit.PUMP_ACTIVE_STATE :=baseStateType;
            pumpUnit.PUMP_NOZZLE_STATE := nozzleStateType;
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r, nozzleStateType);

      end case;
      print("");
   end ADD_PUMP;
   --------------------
   -- SET_PUMPED --
   --------------------
   procedure SET_PUMPED(pumpUnit: in out PUMP_UNIT;  AMOUNT: in PUMP.FLOAT_NUMBER)
   is
   begin
      pumpUnit.PUMPED := AMOUNT;
   end SET_PUMPED;

   --------------------
   -- SET_PUMPED --
   --------------------
   procedure SET_TO_PAY(pumpUnit: in out PUMP_UNIT;  AMOUNT: in PUMP.FLOAT_NUMBER)
   is
   begin
      pumpUnit.TO_PAY := AMOUNT;
   end SET_TO_PAY;

   --------------------
   -- GET_PUMP --
   --------------------
   function GET_PUMP(pumpUnit: in PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES) return PUMP.PUMP
   is
   begin
      case fuelType is
         when PUMP.U91 => return pumpUnit.PUMP_91;
         when PUMP.U95 => return pumpUnit.PUMP_95;
         when PUMP.Diesel => return pumpUnit.PUMP_Diesel;
      end case;
   end GET_PUMP;

   --------------------
   -- GET TANK SIZE --
   --------------------

   function GET_TANKS_SIZE(pumpUnit: in PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES) return PUMP.FLOAT_NUMBER
   is
   begin
      case fuelType is
         when PUMP.U91 => return PUMP.GET_TANKS_SIZE(pumpUnit.PUMP_91);
         when PUMP.U95 => return PUMP.GET_TANKS_SIZE(pumpUnit.PUMP_95);
         when PUMP.Diesel => return PUMP.GET_TANKS_SIZE(pumpUnit.PUMP_Diesel);
      end case;
   end GET_TANKS_SIZE;

   --------------------
   -- GET ID ----------
   --------------------
   function GET_ID(pumpUnit: in PUMP_UNIT) return UNIT_ID_TYPE
   is
   begin
      return pumpUnit.ID;
   end GET_ID;

   --------------------
   -- GET TO PAY ------
   --------------------
   function GET_TO_PAY(pumpUnit: in PUMP_UNIT) return PUMP.FLOAT_NUMBER
   is
   begin
      return pumpUnit.TO_PAY;
   end GET_TO_PAY;

   --------------------
   -- GET PUMPED ------
   --------------------
   function GET_PUMPED(pumpUnit: in PUMP_UNIT) return PUMP.FLOAT_NUMBER
   is
   begin
      return pumpUnit.PUMPED;
   end GET_PUMPED;

   --------------------
   -- GET FUEL   ------
   --------------------
   function GET_FUEL(pumpUnit: in PUMP_UNIT) return PUMP.FUEL_TYPES
   is
   begin
      return pumpUnit.PUMP_ACTIVE_FUEL;
   end GET_FUEL;-----------------------
   -- SET_IS_USING False--
   -----------------------
   procedure SET_IS_USING(pumpUnit: in out PUMP_UNIT)
   is
      use all type PUMP.STATE_TYPE;
      baseStateType: PUMP.STATE_TYPE;

   begin
      baseStateType:= PUMP.STATE_TYPE'val(0);
      if PUMP.GET_STATE(pumpUnit.PUMP_91) = baseStateType and PUMP.GET_STATE(pumpUnit.PUMP_95) =baseStateType and PUMP.GET_STATE(pumpUnit.PUMP_Diesel) = baseStateType  then
         pumpUnit.IS_USING := False;
         print("set pump unit initial is used to false ");
      end if;
   end SET_IS_USING;
   -----------------------
   -- SET_IS_Paid true  --
   -----------------------
   procedure SET_IS_PAID(pumpUnit: in out PUMP_UNIT)
   is
      use all type PUMP.STATE_TYPE;
      baseStateType: PUMP.STATE_TYPE;
   begin
      if(pumpUnit.IS_PAID = False) then
         baseStateType:= PUMP.STATE_TYPE'val(0);
         if PUMP.GET_STATE(pumpUnit.PUMP_91) = baseStateType and PUMP.GET_STATE(pumpUnit.PUMP_95) = baseStateType and PUMP.GET_STATE(pumpUnit.PUMP_Diesel) =  baseStateType then
            pumpUnit.IS_PAID := True;
            print("set pump unit initial is paid to true ");
         end if;
      else
         pumpUnit.IS_PAID := False;
      end if;
   end SET_IS_PAID;
   -----------------------
   -- SET_UNIT_ID  --
   -----------------------
   procedure SET_UNIT_ID(pumpUnit: in out PUMP_UNIT; ID: in UNIT_ID_TYPE)
   is
   begin
      pumpUnit.ID := ID;
   end SET_UNIT_ID;
   -----------------------
   -- SET_PUMP_ACTIVE  --
   -----------------------
   procedure SET_PUMP_ACTIVE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES; stateType: in PUMP.STATE_TYPE)
   is
   begin
      if PUMP.FUEL_TYPES'Pos(fuelType) =0 then
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         PUMP.SET_PUMP_STATE(pumpUnit.PUMP_91,stateType);
      elsif PUMP.FUEL_TYPES'Pos(fuelType) = 1 then
         pumpUnit.PUMP_ACTIVE_FUEL :=fuelType;
         PUMP.SET_PUMP_STATE(pumpUnit.PUMP_95,stateType);
      elsif PUMP.FUEL_TYPES'Pos(fuelType) = 2 then
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         PUMP.SET_PUMP_STATE(pumpUnit.PUMP_Diesel, stateType);
      end if;

   end SET_PUMP_ACTIVE_STATE;
   -----------------------
   -- SET_PUMP_NOZZLE_STATE_ACTIVE  --
   -----------------------
   procedure SET_PUMP_NOZZLE_STATE(pumpUnit: in out PUMP_UNIT; fuelType: in PUMP.FUEL_TYPES; nozzleType: in PUMP.NOZZLE_TYPE)
   is
   begin
      if PUMP.FUEL_TYPES'Pos(fuelType) =0 then
         PUMP.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_91, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
      elsif PUMP.FUEL_TYPES'Pos(fuelType) = 1 then
         PUMP.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_95, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
      elsif PUMP.FUEL_TYPES'Pos(fuelType) = 2 then
         PUMP.SET_PUMP_NOZZLE_STATE(pumpUnit.PUMP_Diesel, nozzleType);
         pumpUnit.PUMP_NOZZLE_STATE := nozzleType;
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
   -- GET_PUMP_UNIT_STATE      --
   -----------------------
   function GET_PUMP_UNIT_STATE(pumpUnit: in PUMP_UNIT) return PUMP.STATE_TYPE
   is
   begin
      return pumpUnit.PUMP_ACTIVE_STATE;
   end GET_PUMP_UNIT_STATE;

   -----------------------
   -- GET_PUMP_NOZZLE_STATE      --
   -----------------------
   function GET_PUMP_NOZZLE_STATE(pumpUnit: in PUMP_UNIT) return PUMP.NOZZLE_TYPE
   is
   begin
      return pumpUnit.PUMP_NOZZLE_STATE;
   end GET_PUMP_NOZZLE_STATE;

   -----------------------
   --   LEFT_NOZZLE     --
   -----------------------
   procedure LEFT_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r : in out PUMP.PUMP; fuelType: in PUMP.FUEL_TYPES) is
      liftNozzleException : Exception;
   begin
      pumpUnit.IS_USING:= True;
      if PUMP.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "BASE" then
         pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(1);
         pumpUnit.PUMP_ACTIVE_FUEL:= fuelType;
         pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(1);
         PUMP.SET_PUMP_STATE(pump_r, PUMP.STATE_TYPE'Val(1));
         PUMP.SET_PUMP_NOZZLE_STATE(pump_r,  PUMP.NOZZLE_TYPE'Val(1));
         print("left node from base state");
      elsif PUMP.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "WAITING" and PUMP.STATE_TYPE'Image(PUMP.GET_STATE(pump_r)) = "WAITING" then
         pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(1);
         pumpUnit.PUMP_ACTIVE_FUEL := fuelType;
         pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(1);
         PUMP.SET_PUMP_STATE(pump_r, PUMP.STATE_TYPE'Val(1));
         PUMP.SET_PUMP_NOZZLE_STATE(pump_r,  PUMP.NOZZLE_TYPE'Val(1));
         print("left node from waiting state");
      else
         print("your are not allow use more then one nozzle at same time");
         Raise liftNozzleException;
      end if;
   end LEFT_NOZZLE;
   -----------------------
   --   RETURN_NOZZLE   --
   -----------------------
   procedure RETURN_NOZZLE (pumpUnit: in out PUMP_UNIT; pump_r: in out PUMP.PUMP) is
      due: PUMP.FLOAT_NUMBER;
      use all type PUMP.FLOAT_NUMBER;
      returnNozzleException : Exception;
   begin
      due:=0.00;
      if PUMP.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "READY" and PUMP.STATE_TYPE'Image(PUMP.GET_STATE(pump_r)) = "READY" then
         if pumpUnit.TO_PAY > due then
            pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(3);
            pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(2);
            PUMP.SET_PUMP_STATE(pump_r, PUMP.STATE_TYPE'Val(3));
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r,  PUMP.NOZZLE_TYPE'Val(2));
            print_float_type("return nozzle to waiting state TO_PAY: ", pumpUnit.TO_PAY);
         else
            pumpUnit.IS_USING:= False;
            pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(0);
            pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(0);
            PUMP.SET_PUMP_STATE(pump_r, PUMP.STATE_TYPE'Val(0));
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r,  PUMP.NOZZLE_TYPE'Val(0));
            print("return nozzle to base state TO_PAY = 0");
         end if;
      else
         print("you are not supports not to use this nozzle other nozzle currently in use");

         Raise returnNozzleException;
      end if;
   end RETURN_NOZZLE;
   -----------------------
   --   START_PUMPING   --
   -----------------------
   procedure START_PUMPING (pumpUnit: in out PUMP_UNIT; pump_r: in out PUMP.PUMP; AMOUNT: in PUMP.FLOAT_NUMBER; CAR_TANK_SPACE: in out PUMP.FLOAT_NUMBER)
   is
      use all type PUMP.FLOAT_NUMBER;
      tankSize: PUMP.FLOAT_NUMBER;
      pumped: PUMP.FLOAT_NUMBER;
      SENSOR: Boolean;
      temp: PUMP.FLOAT_NUMBER;
      startPumpingException : Exception;

   begin
      temp:=0.00;
      pumped:=0.00;
      SENSOR := False;
      if pumpUnit.PUMP_ACTIVE_STATE = PUMP.ready  and pump_r.PUMP_STATE = PUMP.Ready then
         tankSize :=  PUMP.GET_TANKS_SIZE(pump_r);
         print_float_type("tank size: ", tankSize);
         if tankSize <= 0.00 then
            print("tank empty");
            Raise startPumpingException;
         end if;
         if CAR_TANK_SPACE <= 0.00 then
            print("car tank full can not pumping");
            Raise startPumpingException;
         end if;
         if AMOUNT >0.00 and SENSOR = False and tankSize > temp then
            pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(2);
            pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(3);
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r, PUMP.NOZZLE_TYPE'Val(3));
            PUMP.SET_PUMP_STATE(pump_r,PUMP.STATE_TYPE'Val(2));
            --              while CAR_TANK_SPACE>0.00 and tankSize >temp and SENSOR = False and pumped <= AMOUNT loop
            loop
               if CAR_TANK_SPACE>0.00 and tankSize >temp and SENSOR = False and pumped <= AMOUNT then

                  pumped:= pumped +0.01;
                  pumpUnit.PUMPED :=pumpUnit.PUMPED + 0.01 ;
                  pumpUnit.TO_PAY := pumpUnit.TO_PAY + (0.01 * PUMP.GET_UNIT_PRICE(pump_r));
                  if CAR_TANK_SPACE -0.01 >0.00 then
                     CAR_TANK_SPACE:= CAR_TANK_SPACE - 0.01;
                  else
                     SENSOR := True;
                     STOP_PUMPING(pumpUnit, pump_r);
                     exit when SENSOR = True;

                  end if;
                  --                 print_float_type("pumping: " , pumped);
                  --                 print_float_type("car tank space left: ",CAR_TANK_SPACE);
                  --                 print_float_type("Amount To Pay: ", pumpUnit.TO_PAY);
                  PUMP.REMOVE_PETROL_RESERVOIR(pump_r,0.01);
                  tankSize := PUMP.GET_TANKS_SIZE(pump_r);
                  if tankSize <= 1.00E-02 then
                     STOP_PUMPING(pumpUnit, pump_r);
                     print("tank empty stop pumping");
                     exit when tankSize <= 1.00E-02;
                  elsif pumped>= AMOUNT then
                     print("pumped given amount");
                     STOP_PUMPING(pumpUnit, pump_r);
                     exit when pumped>= AMOUNT;
                  end if;
               end if;
            end loop;

            end if;
            if AMOUNT =0.00 and SENSOR = False and tankSize > temp then
            pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(3);
            pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(2);
            PUMP.SET_PUMP_NOZZLE_STATE(pump_r, PUMP.NOZZLE_TYPE'Val(3));
            PUMP.SET_PUMP_STATE(pump_r,PUMP.STATE_TYPE'Val(2));

            loop
               if SENSOR = False and tankSize > 0.00 then
                  pumpUnit.PUMPED :=pumpUnit.PUMPED + 0.01 ;
                  pumpUnit.TO_PAY := pumpUnit.TO_PAY + (0.01 * PUMP.GET_UNIT_PRICE(pump_r));
                  PUMP.REMOVE_PETROL_RESERVOIR(pump_r,0.01);
                  if CAR_TANK_SPACE -0.01 >0.00 then
                     print_float_type("1:    ",tankSize);
                     CAR_TANK_SPACE:= CAR_TANK_SPACE - 0.01;
                  else
                     SENSOR := True;
                     STOP_PUMPING(pumpUnit, pump_r);
                     exit when CAR_TANK_SPACE -0.01 <=0.00;
                  end if;
                  --                 print_float_type("pumping: " , pumped);
                  --                 print_float_type("car tank space left: ",CAR_TANK_SPACE);
                  --                 print_float_type("Amount To Pay: ", pumpUnit.TO_PAY);               PUMP.REMOVE_PETROL_RESERVOIR(pump_r,0.01);
                  tankSize := PUMP.GET_TANKS_SIZE(pump_r);
                  print_float_type("2:    ",tankSize);
                  if tankSize <= 1.00E-02 then
                     STOP_PUMPING(pumpUnit, pump_r);
                     print("tank empty stop pumping");
                     exit when tankSize <= 1.00E-02;
                  end if;
               end if;
            end loop;
         end if;
      else
         print("you can not pumping - only read+y state -> pumping");

         Raise startPumpingException;

      end if;
   end START_PUMPING;
   -----------------------
   --   STOP_PUMPING   --
   -----------------------
   procedure STOP_PUMPING(pumpUnit: in out PUMP_UNIT; pump_r: in out PUMP.PUMP) is
      stopPumpingException : Exception;
   begin
      if PUMP.STATE_TYPE'Image(pumpUnit.PUMP_ACTIVE_STATE) = "PUMPING"  and PUMP.STATE_TYPE'Image(PUMP.GET_STATE(pump_r)) = "PUMPING" then
         pumpUnit.PUMP_ACTIVE_STATE := PUMP.STATE_TYPE'Val(1);
         pumpUnit.PUMP_NOZZLE_STATE:= PUMP.NOZZLE_TYPE'Val(4);
         PUMP.SET_PUMP_STATE(pump_r,PUMP.STATE_TYPE'Val(1));
         PUMP.SET_PUMP_NOZZLE_STATE(pump_r, PUMP.NOZZLE_TYPE'Val(4));
         print("stop pumping");
      else
         Raise stopPumpingException;

      end if;

   end STOP_PUMPING;

end PUMP_UNIT;
