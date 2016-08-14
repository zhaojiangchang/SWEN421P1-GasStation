with Ada.Text_IO; use Ada.Text_IO;
with PUMP;
package body sPrint is
   procedure print(s: in String) is
   begin
      if s = "" then
         New_Line;
      else
         Put_Line(s);
      end if;
   end print;

   procedure print_float_type(s1: in String; s2: in PUMP.FLOAT_NUMBER) is
   begin
      Put_Line(s1 & s2'Image);
   end print_float_type;

   procedure print_state_type(s1: in String; s2: in PUMP.STATE_TYPE) is
   begin
      Put_Line(s1 &"  "& s2'Image);
   end print_state_type;

   procedure print_nozzle_type(s1: in String; s2: in PUMP.NOZZLE_TYPE) is
   begin
      Put_Line(s1 &"   "& s2'Image);
   end print_nozzle_type;

   procedure print_fuel_type(s1: in String; s2: in PUMP.FUEL_TYPES) is
   begin
      Put_Line(s1 & s2'Image);
   end print_fuel_type;
end sPrint;
