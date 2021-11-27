open Laius

let bslide = Slide.slide ~border:"\\"

let () =
  let slideshow =
    SlideShow.create ~title:"A first presentation" ~author:"Tim"
      ~date:"22/10/2004"
      Slide.
        [
          title;
          toc ~title:"Table of contents";
          bslide ~title:"Heading" ~text:"this is a text";
          bslide ~title:"Second heading" ~text:"this is a text";
        ]
  in
  SlideShow.present slideshow
