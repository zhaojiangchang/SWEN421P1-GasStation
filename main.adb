with Ada.Text_IO; use Ada.Text_IO;
with PUMP_UNIT; use PUMP_UNIT;
procedure Main is
   unit : PUMP_UNIT.PUMP_UNIT_R;
   --pump91: PUMP_UNIT.PUMP91.PUMP_PTR;
  -- punit: PUMP_UNIT.PUMP_UNIT_PTR;
begin
   --  Insert code here.
   ADD_PUMPS(unit);

--     PUMP_UNIT.;
   --PUMP_UNIT.PUMP91.CHANGE_STATE(PUMP_UNIT., STATE_TPYE'(Ready));
   --PUMP91.GET_CURRENT_RESERVOIR_SIZE(PUMP91.PUMP_PTR);
   --PUMP_UNIT.PUMP91.SET_FUEL_PRICE(PUMP91.PUMP_PTR,2.00);
   null;
end Main;
