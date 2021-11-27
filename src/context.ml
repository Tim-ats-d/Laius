type t = {
  title : string;
  author : string;
  date : string;
  mutable progress : int;
  slide_nb : int;
  heading : string list;
  show_page_numbers : bool;
}

let incr_progress t =
  t.progress <-
    (if t.progress = t.slide_nb then t.slide_nb else succ t.progress)

let decr_progress t =
  t.progress <- (if t.progress = 1 then 1 else pred t.progress)

let create ~title ~author ~date ~slide_nb ~heading ~show_page_numbers =
  { title; author; date; progress = 1; slide_nb; heading; show_page_numbers }
