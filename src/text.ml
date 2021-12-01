type t = DotPoint of bullet * t list | Text of string

and bullet = string

let text t = Text t

let dot_point ?(bullet = "-") tlist = DotPoint (bullet, tlist)

let make_indent n = List.init n (fun _ -> "  ") |> String.concat ""

let eval =
  let get_bullet = Option.value ~default:"" in
  let rec loop acc n bullet = function
    | [] -> List.rev acc
    | x :: xs -> (
        match x with
        | Text t when n = 0 -> loop (t :: acc) 0 bullet xs
        | Text t ->
            let text =
              Printf.sprintf "%s%s %s" (make_indent n) (get_bullet bullet) t
            in
            loop (text :: acc) n bullet xs
        | DotPoint (b, tlist) ->
            let tlist' = loop [] (succ n) (Some b) tlist in
            loop (List.rev tlist' @ acc) n bullet xs)
  in
  loop [] 0 None
