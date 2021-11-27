type t = {
  title : string;
  author : string;
  date : string;
  slide_nb : int;
  heading : string list;
  show_page_numbers : bool;
}

let create ~title ~author ~date ~slide_nb ~heading ~show_page_numbers =
  { title; author; date; slide_nb; heading; show_page_numbers }
