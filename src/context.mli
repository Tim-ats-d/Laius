type t = private {
  title : string;
  author : string;
  date : string;
  mutable progress : int;
  slide_nb : int;
  headers : string list;
}

val incr_progress : t -> unit

val decr_progress : t -> unit

val create :
  title:string ->
  author:string ->
  date:string ->
  slide_nb:int ->
  headers:string list ->
  t
