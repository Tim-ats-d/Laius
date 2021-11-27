open Utils

type t = TitleSlide | TocSlide of { title : string } | Slide of slide

and slide = { title : string; text : string }

let title = TitleSlide

let toc ~title = TocSlide { title }

let slide ~title ~text = Slide { title; text }

let collect_header = function
  | TitleSlide -> None
  | TocSlide _ -> None
  | Slide { title; _ } -> Some title

let rec render ctx n = function
  | TitleSlide -> render_title ctx n
  | TocSlide { title; _ } -> render_toc ctx n ~title
  | Slide s -> render_slide ctx n s

and render_title { Context.title; author; date; slide_nb; _ } n =
  Formatting.map
    [
      ("title", title);
      ("author", String.value author ~default:"none");
      ("date", String.value date ~default:"none");
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]

and render_toc { Context.heading; slide_nb; _ } n ~title =
  Formatting.map
    [
      ("title", title);
      ("toc", String.concat "\n" heading);
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]

and render_slide { Context.slide_nb; _ } n { title; text } =
  Formatting.map
    [
      ("heading", title);
      ("text", text);
      ("numb", Formatting.numbering n ~on:slide_nb);
    ]
