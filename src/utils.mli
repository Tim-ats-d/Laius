module String : sig
  include module type of String

  val value : t -> default:t -> t
end
