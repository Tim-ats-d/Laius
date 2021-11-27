type t = { slides : Slide.t list; ctx : Context.t }

let create ?(author = "") ?(date = "") ?(show_page_numbers = true) ~title slides
    =
  let heading = List.filter_map Slide.collect_header slides in
  {
    slides;
    ctx =
      Context.create ~title ~author ~date ~heading ~show_page_numbers
        ~slide_nb:(List.length slides);
  }

let present { slides; ctx } = Lwt_main.run @@ Action.launch ctx slides ()
