open Context

class display sshow_ctx slides =
  object (self)
    inherit LTerm_widget.frame as super

    method get_current =
      Slide.render sshow_ctx @@ List.nth slides (sshow_ctx.progress - 1)

    method! draw ctx _focused =
      super#draw ctx _focused;
      self#set self#get_current
  end

let launch ctx slides widgets =
  let waiter, wakener = Lwt.wait () in

  let display = new display ctx slides in
  let statusbar = new LTerm_widget.hbox in
  List.iter (fun widget -> statusbar#add (widget ctx)) widgets;

  let vbox = new LTerm_widget.vbox in
  vbox#add display;
  vbox#add ~expand:false statusbar;

  vbox#on_event
    (Interaction.loop wakener ~ctx ~draw:(fun () -> statusbar#queue_draw));

  Lwt.(
    Lazy.force LTerm.stdout >>= fun term -> LTerm_widget.run term vbox waiter)
