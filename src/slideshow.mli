type t = {
  slides : Slide.t list;
  ctx : Context.t;
  widgets : (Context.t -> Statusbar_widget.styled_label) list;
}

val create :
  ?author:string ->
  ?date:string ->
  title:string ->
  statusbar:(Context.t -> Statusbar_widget.styled_label) list ->
  Slide.t list ->
  t

val present : t -> unit
