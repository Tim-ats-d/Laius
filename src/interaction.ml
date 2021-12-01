let first ctx f =
  Context.first ctx;
  f ();
  true

let last ctx f =
  Context.last ctx;
  f ();
  true

let next ?(n = 1) ctx f =
  Context.forward ctx ~n;
  f ();
  true

let previous ?(n = 1) ctx f =
  Context.backward ctx ~n;
  f ();
  true

let exit wakener draw =
  Lwt.wakeup wakener ();
  draw ();
  true

let key = CamomileLibraryDefault.Camomile.UChar.of_char

let loop wakener ~ctx ~draw = function
  | LTerm_event.Key { code; _ } -> (
      match code with
      | Enter | Right | Next_page -> next ctx draw
      | Char c when c = key ' ' || c = key 'l' -> next ctx draw
      | Backspace | Left | Prev_page -> previous ctx draw
      | Char c when c = key 'h' -> previous ctx draw
      | Down -> next ctx ~n:10 draw
      | Char c when c = key 'j' -> next ctx ~n:10 draw
      | Up -> previous ctx ~n:10 draw
      | Char c when c = key 'k' -> previous ctx ~n:10 draw
      | Char c when c = key '0' -> first ctx draw
      | Char c when c = key 'G' -> last ctx draw
      | Escape -> exit wakener draw
      | Char c when c = key 'q' -> exit wakener draw
      | _ -> false)
  | _ -> false
