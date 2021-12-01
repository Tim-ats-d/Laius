type t = TitleSlide | TocSlide of { heading : string } | Slide of slide

and slide = { title : string; text : Text.t list }

val title : t

val toc : heading:string -> t

val slide : title:string -> text:Text.t list -> t

val collect_header : t -> string option

val render : Context.t -> t -> LTerm_widget.box
