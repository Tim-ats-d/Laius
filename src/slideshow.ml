type t = { slides : (int * Slide.t) list; ctx : Context.t }

let numbering = List.mapi (fun i s -> (i + 1, s))

let create ?(author = "") ?(date = "") ?(show_page_numbers = true) ~title slides
    =
  let heading = List.filter_map Slide.collect_header slides
  and slides = numbering slides in
  {
    slides;
    ctx =
      Context.create ~title ~author ~date ~heading ~show_page_numbers
        ~slide_nb:(List.length slides);
  }

let present { slides; ctx } =
  List.map (fun (n, slide) -> Slide.render ctx n slide) slides
  |> String.concat "\n\n"
