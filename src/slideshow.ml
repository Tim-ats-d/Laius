type t = {
  slides : Slide.t list;
  ctx : Context.t;
  widgets : (Context.t -> Statusbar.styled_label) list;
}

let create ?(author = "") ?(date = "") ?(show_page_numbers = true) ~title
    ~statusbar slides =
  let heading = List.filter_map Slide.collect_header slides in
  let ctx =
    Context.create ~title ~author ~date ~heading ~show_page_numbers
      ~slide_nb:(List.length slides)
  in
  { slides; ctx; widgets = statusbar }

let present { slides; ctx; widgets } =
  Lwt_main.run @@ Action.launch ctx slides widgets ()
