type t = DotPoint of bullet * t list | Text of string

and bullet = string

val text : string -> t

val dot_point : ?bullet:string -> t list -> t

val eval : t list -> string list
