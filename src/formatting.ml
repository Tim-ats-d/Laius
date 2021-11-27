let numbering n ~on = Printf.sprintf "%i/%i" n on

let map lst =
  List.map (fun (name, value) -> Printf.sprintf "%s: %s" name value) lst
  |> String.concat "\n"
