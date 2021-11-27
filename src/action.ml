class status_bar (slideshow : Context.t) =
  object (self)
    inherit LTerm_widget.label "statusbar"

    method format = Printf.sprintf "%i/%i" slideshow.progress slideshow.slide_nb

    method! can_focus = false

    method! draw ctx _ =
      LTerm_draw.draw_string ctx 0 0 @@ Zed_string.of_utf8 self#format
  end

let loop wakener ~ctx ~slides ~draw =
  let _ = slides in
  (* TODO *)
  function
  | LTerm_event.Key { code; _ } -> (
      match code with
      | Left ->
          Context.decr_progress ctx;
          draw ();
          true
      | Right ->
          Context.incr_progress ctx;
          draw ();
          true
      | Escape ->
          Lwt.wakeup wakener ();
          draw ();
          true
      | _ -> false)
  | _ -> false

let launch ctx slides () =
  let waiter, wakener = Lwt.wait () in

  let main = new LTerm_widget.label "Main interface"
  and statusbar = new status_bar ctx in

  let vbox = new LTerm_widget.vbox in
  vbox#add main;
  vbox#add ~expand:false statusbar;

  vbox#on_event
    (loop wakener ~ctx ~slides ~draw:(fun () -> statusbar#queue_draw));

  Lwt.(
    Lazy.force LTerm.stdout >>= fun term -> LTerm_widget.run term vbox waiter)
