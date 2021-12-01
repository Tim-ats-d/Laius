val loop :
  unit Lwt.u -> ctx:Context.t -> draw:(unit -> unit) -> LTerm_event.t -> bool
