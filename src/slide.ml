open Utils

type t = TitleSlide | TocSlide | Slide of slide

and slide = { title : string; text : string; border : string }

let title = TitleSlide

let toc = TocSlide

let slide ?(border = "") ~title ~text = Slide { title; text; border }

let collect_header = function
  | TitleSlide -> None
  | TocSlide -> None
  | Slide { title; _ } -> Some title

let rec render ctx n = function
  | TitleSlide -> render_title ctx n
  | TocSlide -> render_toc ctx n
  | Slide s -> render_slide ctx n s

and render_title { Context.title; author; date; slide_nb; _ } n =
  Formatting.map
    [
      ("title", title);
      ("author", String.value author ~default:"none");
      ("date", String.value date ~default:"none");
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]

and render_toc { Context.heading; slide_nb; _ } n =
  Formatting.map
    [
      ("toc", String.concat "\n" heading);
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]

and render_slide { Context.slide_nb; _ } n { title; text; border } =
  Formatting.map
    [
      ("heading", title);
      ("text", text);
      ("border", String.value border ~default:"none");
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]
