with Ada.Text_IO; use Ada.Text_IO;
package body sPrint
is
   procedure print(s: in String) is
   begin
      Put_Line(s);
   end print;
end sPrint;
