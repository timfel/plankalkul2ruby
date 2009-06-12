
$(function () {
      showCheckerBoard(8,8);
      showStones();
})

var tiles = [[],[],[],[],[],[],[],[]];
var stones = [[],[],[],[],[],[],[],[]];
var clicked = null;

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
   set_stone(x,y,x,y);
}

function move(x1,y1,x2,y2) {
   $.getJSON("/move/"+x1+"/"+y1+"/to/"+x2+"/"+y2, 
	 function(data) {
	    if (data) {
	       set_stone(x1,y1,x2,y2);
	    };
	 });
}

function click(o,x,y) {
   $.getJSON("/select/"+x+"/"+y, function(data) {
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

function set_stone(x,y,x1,y1) {
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
}
