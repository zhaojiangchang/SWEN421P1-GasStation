package body PUMP is

   --------------------------
   -- ADD_PETROL_RESERVOIR --
   --------------------------

   procedure ADD_PETROL_RESERVOIR
     (A: in out PUMP_PTR;
      AMOUNT: in TOTAL_PER_RESERVOIR)
   is
   begin


   end ADD_PETROL_RESERVOIR;

   -----------------------------
   -- REMOVE_PETROL_RESERVOIR --
   -----------------------------

   procedure REMOVE_PETROL_RESERVOIR
     (A: in out RESERVOIR_PTR;
      AMOUNT: in TOTAL_PER_RESERVOIR)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "REMOVE_PETROL_RESERVOIR unimplemented");
      raise Program_Error with "Unimplemented procedure REMOVE_PETROL_RESERVOIR";
   end REMOVE_PETROL_RESERVOIR;

   ------------------
   -- CHANGE_STATE --
   ------------------

   procedure CHANGE_STATE
     (A: in out PUMP_PTR;
      FIRST:STATE_TPYE;
      SECOND:STATE_TPYE)
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "CHANGE_STATE unimplemented");
      raise Program_Error with "Unimplemented procedure CHANGE_STATE";
   end CHANGE_STATE;

   -------------------------
   -- IS_STATE_CHANGEABLE --
   -------------------------

   function IS_STATE_CHANGEABLE
     (A: in PUMP_PTR;
      FIRST:STATE_TPYE;
      SECOND:STATE_TPYE)
      return Boolean
   is
   begin
      --  Generated stub: replace with real body!
      pragma Compile_Time_Warning (Standard.True, "IS_STATE_CHANGEABLE unimplemented");
      raise Program_Error with "Unimplemented function IS_STATE_CHANGEABLE";
      return IS_STATE_CHANGEABLE (A => A, FIRST => FIRST, SECOND => SECOND);
   end IS_STATE_CHANGEABLE;

end PUMP;
