module String = struct
  include String

  let value str ~default = if str = "" then default else str
end
