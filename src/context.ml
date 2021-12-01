type t = {
  title : string;
  author : string;
  date : string;
  mutable progress : int;
  slide_nb : int;
  headers : string list;
}

let first t = t.progress <- 1

let last t = t.progress <- t.slide_nb

let forward ?(n = 1) t =
  for _ = 0 to n - 1 do
    t.progress <-
      (if t.progress = t.slide_nb then t.slide_nb else succ t.progress)
  done

let backward ?(n = 1) t =
  for _ = 0 to n - 1 do
    t.progress <- (if t.progress = 1 then 1 else pred t.progress)
  done

let create ~title ~author ~date ~slide_nb ~headers =
  { title; author; date; progress = 1; slide_nb; headers }
