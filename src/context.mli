type t = private {
  title : string;
  author : string;
  date : string;
  mutable progress : int;
  slide_nb : int;
  headers : string list;
}

val first : t -> unit

val last : t -> unit

val forward : ?n:int -> t -> unit

val backward : ?n:int -> t -> unit

val create :
  title:string ->
  author:string ->
  date:string ->
  slide_nb:int ->
  headers:string list ->
  t
