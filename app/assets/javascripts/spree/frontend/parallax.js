window.addEventListener("scroll", function() {
  let offset = window.pageYOffset;
  var parallax = document.getElementsByClassName("banner");
  parallax[0].style.backgroundPositionY = offset * 0.1 - 100+ "px";

  var parallax2 = document.getElementsByClassName("mission");
  parallax2[0].style.backgroundPositionY = offset * 0.1 - 100+ "px";
  
  })


  // Animations initialization
  new WOW().init();
