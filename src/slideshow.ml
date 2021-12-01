type t = {
  slides : Slide.t list;
  ctx : Context.t;
  widgets : (Context.t -> Statusbar_widget.styled_label) list;
}

let create ?(author = "") ?(date = "") ~title ~statusbar slides =
  let headers = List.filter_map Slide.collect_header slides in
  let ctx =
    Context.create ~title ~author ~date ~headers ~slide_nb:(List.length slides)
  in
  { slides; ctx; widgets = statusbar }

let present { slides; ctx; widgets } =
  Lwt_main.run @@ Display.launch ctx slides widgets
