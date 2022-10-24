/**
 별점 js 파일
 */

 const drawStar = function ( target ) {
    document.querySelector(".star span").style.width = "${target.value * 10}%";
  }