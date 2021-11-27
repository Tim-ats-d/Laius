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

let launch ctx slides widgets () =
  let waiter, wakener = Lwt.wait () in

  let main = new LTerm_widget.label "Presentation"
  and statusbar = new LTerm_widget.hbox in
  List.iter (fun widget -> statusbar#add (widget ctx)) widgets;

  let vbox = new LTerm_widget.vbox in
  vbox#add main;
  vbox#add ~expand:false statusbar;

  vbox#on_event
    (loop wakener ~ctx ~slides ~draw:(fun () ->
         List.iter (fun s -> s#queue_draw) statusbar#children));

  Lwt.(
    Lazy.force LTerm.stdout >>= fun term -> LTerm_widget.run term vbox waiter)
