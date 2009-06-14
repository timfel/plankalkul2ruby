$(function () {
      showCheckerBoard(8,8);
      showStones();
      getColor();
      getMoves();
})

var tiles = [[],[],[],[],[],[],[],[]];
var stones = [[],[],[],[],[],[],[],[]];
var clicked = null;
var color = 0;
var count = 0;

function tile(x,y) {
   this.x = x;
   this.y = y;
   if ((Math.abs(x - y) % 2) == 1)
      this.color = "#fa4";
   else
      this.color = "#c94";
   o = $("<div class='tile'></div>")
      .css("background", this.color)
      .css("left", this.x*50+100)
      .css("top", this.y*50+100);
   $(o).click(function() {
	 click(this,x,y) });
   $(".board").append(o);
   return o;
}

function stone(name,x,y) {
   o = $("<div>"+name+"</div>");
   o.css("position", "absolute");
   $(".board").append(o);
   stones[x][y] = o;
   setStone(x,y,x,y);
}

function move(x1,y1,x2,y2) {
   $.getJSON("/move/"+color+"/"+x1+"/"+y1+"/to/"+x2+"/"+y2, 
	 function(data) {
	    if (data) {
	       setStone(x1,y1,x2,y2);
	       count = count + 1;
	    };
	 });
}

function click(o,x,y) {
   $.getJSON("/select/"+color+"/"+x+"/"+y, function(data) {
         if (clicked == null) {
	    if (data) {
	       clicked = [x,y];
               $(o).addClass('overlay');
	    }
         } else {
            move(clicked[0],clicked[1],x,y);
            clicked = null;
            $(".overlay").removeClass('overlay');
         }});
}

function setStone(x,y,x1,y1) {
   pos = tiles[x1][y1].position();
   o = stones[x][y]
   o.animate({
	    left: pos.left+"px",
	    top: pos.top+"px" }, 500);
   stones[x][y] = null;
   stones[x1][y1] = o;
}

function showCheckerBoard(x, y) {
   for (i = 0; i < x; i++) {
      for (j = 0; j < y; j++) {
	 tiles[i][j] = new tile(i,j);
      }
   }
}

function showStones() {
   for (i = 0; i < 8; i++) {
      stone("B_b", i, 1);
      stone("B_w", i, 6);
   }
   stone("T_w", 0, 7);
   stone("T_w", 7, 7);
   stone("T_b", 0, 0);
   stone("T_b", 7, 0);
   stone("L_w", 2, 7);
   stone("L_w", 5, 7);
   stone("L_b", 2, 0);
   stone("L_b", 5, 0);
   stone("S_w", 1, 7);
   stone("S_w", 6, 7);
   stone("S_b", 1, 0);
   stone("S_b", 6, 0);
   stone("D_w", 3, 7);
   stone("K_w", 4, 7);
   stone("D_b", 3, 0);
   stone("K_b", 4, 0);
}

function getMoves() {
   timeout = 1000;
   $.getJSON("/replay/"+count, function (data) {
	 if (!(data == false)) { 
	    setStone(data[0],data[1],data[2],data[3]);
	    timeout = 1;
	    count = count + 1;
	 }});
   setTimeout("getMoves()", timeout);
}

function getColor() {
   $.getJSON("/color", function (data) {
      color = data;
   });
}
