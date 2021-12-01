type t = TitleSlide | TocSlide of { heading : string } | Slide of slide

and slide = { title : string; text : Text.t list }

let title = TitleSlide

let toc ~heading = TocSlide { heading }

let slide ~title ~text = Slide { title; text }

let collect_header = function
  | TitleSlide -> None
  | TocSlide _ -> None
  | Slide { title; _ } -> Some title

let render ctx = function
  | TitleSlide -> new Slide_widget.title ctx
  | TocSlide { heading } -> new Slide_widget.toc ctx heading
  | Slide { title; text } -> new Slide_widget.slide title (Text.eval text)
