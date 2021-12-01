let loop wakener ~ctx ~draw = function
  | LTerm_event.Key { code; _ } -> (
      match code with
      | Left | Down | Backspace ->
          Context.decr_progress ctx;
          draw ();
          true
      | Right | Up | Enter ->
          Context.incr_progress ctx;
          draw ();
          true
      | Escape ->
          Lwt.wakeup wakener ();
          draw ();
          true
      | _ -> false)
  | _ -> false
