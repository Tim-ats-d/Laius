open Laius

module Color = struct
  let style_of_rgb r g b =
    LTerm_style.{ none with background = Some (rgb r g b) }

  let dark_blue = style_of_rgb 71 71 186

  let blue = style_of_rgb 133 133 209

  let soft_blue =
    LTerm_style.
      {
        none with
        background = Some (rgb 173 173 224);
        foreground = Some (rgb 0 0 0);
      }
end

let content =
  Text.
    [
      text "Introduction";
      dot_point
        [
          text "1.";
          text "2.";
          dot_point ~bullet:"*" [ text "2.1"; text "2.2" ];
          text "3.";
        ];
      text "Outro";
    ]

let statusbar =
  StatusBarWidget.
    [
      new author ~style:Color.dark_blue;
      new title ~style:Color.blue;
      new date ~style:Color.soft_blue;
      new progress ~style:Color.soft_blue;
    ]

let slides =
  Slide.
    [
      title;
      toc ~heading:"Table of contents";
      slide ~title:"Part one" ~text:content;
      slide ~title:"Part two" ~text:[ Text.text "The second part" ];
      slide ~title:"Part three" ~text:[ Text.text "The third part" ];
    ]

let slideshow =
  SlideShow.create slides ~title:"A first presentation" ~author:"Tim"
    ~date:"22/10/2004" ~statusbar

let () = SlideShow.present slideshow
