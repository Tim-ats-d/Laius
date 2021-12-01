open Context

let empty = new LTerm_widget.spacing ()

class title sshow_ctx =
  object (self)
    inherit LTerm_widget.vbox

    initializer
    self#add empty;
    self#add
      (new Statusbar_widget.styled_label
         sshow_ctx.title
         ~style:LTerm_style.{ none with bold = Some true });
    self#add (new LTerm_widget.label sshow_ctx.author);
    self#add (new LTerm_widget.label sshow_ctx.date);
    self#add empty
  end

let wrap ctx =
  let size = LTerm_draw.size ctx in
  if size.rows > 2 && size.cols > 2 then
    LTerm_draw.sub ctx
      { row1 = 1; col1 = 1; row2 = size.rows - 1; col2 = size.cols - 1 }
  else ctx

class header text =
  object
    inherit LTerm_widget.vbox

    method! draw ctx _ =
      let ctx = wrap ctx in
      LTerm_draw.draw_styled ctx 0 0
      @@ LTerm_text.(eval [ B_bold true; S text; E_bold ])
  end

class text text =
  object
    inherit LTerm_widget.vbox

    method! draw ctx _ =
      let ctx = wrap ctx in
      List.iteri
        (fun i header ->
          LTerm_draw.draw_string ctx i 0 (Zed_string.of_utf8 header))
        text
  end

class lines lines =
  object
    inherit LTerm_widget.vbox

    method! draw ctx _ =
      let ctx = wrap ctx in
      List.iteri
        (fun i header ->
          LTerm_draw.draw_string ctx i 0 (Zed_string.of_utf8 header))
        lines
  end

class slide title text =
  object (self)
    inherit LTerm_widget.vbox

    initializer
    self#add (new header title);
    self#add (new text text)
  end

class toc sshow_ctx heading =
  object (self)
    inherit LTerm_widget.vbox

    initializer
    self#add (new header heading);
    self#add (new lines sshow_ctx.headers)
  end
