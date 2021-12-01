open Context

class styled_label initial_text ~style =
  object (self)
    inherit LTerm_widget.label initial_text as super

    initializer self#set_text initial_text

    method! draw ctx _focused =
      super#draw ctx _focused;
      LTerm_draw.fill_style ctx style
  end

class author ?(style = LTerm_style.none) sshow_ctx =
  object
    inherit styled_label sshow_ctx.author ~style
  end

class date ?(style = LTerm_style.none) sshow_ctx =
  object (self)
    inherit styled_label sshow_ctx.date ~style

    initializer self#set_alignment LTerm_geom.H_align_right
  end

class title ?(style = LTerm_style.none) sshow_ctx =
  object
    inherit styled_label sshow_ctx.title ~style
  end

let format sshow_ctx =
  Printf.sprintf "%i/%i" sshow_ctx.progress sshow_ctx.slide_nb

class progress ?(style = LTerm_style.none) sshow_ctx =
  object (self)
    inherit styled_label (format sshow_ctx) ~style as super

    initializer self#set_alignment LTerm_geom.H_align_right

    method! draw ctx _focused =
      self#set_text (format sshow_ctx);
      super#draw ctx _focused
  end
