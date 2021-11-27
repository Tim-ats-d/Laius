open Laius

let style_of_rgb r g b = LTerm_style.{ none with background = Some (rgb r g b) }

let dark_blue = style_of_rgb 71 71 186

let blue = style_of_rgb 133 133 209

let soft_blue =
  LTerm_style.
    {
      none with
      background = Some (rgb 173 173 224);
      foreground = Some (rgb 0 0 0);
    }

let statusbar =
  StatusBar.
    [
      new author ~style:dark_blue;
      new title ~style:blue;
      new date ~style:soft_blue;
      new progress ~style:soft_blue;
    ]

let slides =
  Slide.
    [
      title;
      toc ~title:"Table of contents";
      slide ~title:"Heading" ~text:"this is a text";
      slide ~title:"Second heading" ~text:"this is a text";
    ]

let slideshow =
  SlideShow.create slides ~title:"A first presentation" ~author:"Tim"
    ~date:"22/10/2004" ~statusbar

let () = SlideShow.present slideshow
