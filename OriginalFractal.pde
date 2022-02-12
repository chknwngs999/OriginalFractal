boolean drawn;

ArrayList<Integer> basex;
ArrayList<Integer> basey;
ArrayList<Integer> angles; //for now is just the first set of lines, later may include other sets (2d arraylist?)
int[] depth_r;
int[] depth_g;
int[] depth_b;
int count = 1;

int x, y, baselen;

void setup() {
  size(1000, 1000);
  rectMode(CENTER);
  strokeWeight(2);
  background(128, 128, 128);
  //noLoop();
  frameRate(20);

  drawn = false;
  x = y = 500;
  baselen = 500;
  int temp = baselen;

  while (baselen > 50) {
    baselen /= 2;
    count++;
  }
  baselen = temp;
}
void draw() {
  background(0);
  if (!drawn) {
    basex = new ArrayList<Integer>();
    basey = new ArrayList<Integer>();
    angles = new ArrayList<Integer>();
    depth_r = new int[count];
    depth_g = new int[count];
    depth_b = new int[count];

    drawn = true;
    int r = (int)(Math.random()*256);
    int g = (int)(Math.random()*256);
    int b = (int)(Math.random()*256);
    color firstcolor = color(r, g, b);

    depth_r[0] = r;
    depth_g[0] = g;
    depth_b[0] = b;

    for (int i = 0; i < 7; i++) {
      fill(firstcolor);

      myFractal(x, y, baselen, firstcolor, 0);
    }
  } else {
    int r = depth_r[0];
    int g = depth_g[0];
    int b = depth_b[0];

    for (int i = 0; i < 7; i++) {
      //int x = basex.get(i);
      //int y = basey.get(i);
      int angle = angles.get(i);
      fill(color(r, g, b));
      stroke(color(r, g, b));
      reFractal(x, y, baselen, angle, 0, i);
    }
  }
}

void mousePressed() {
  drawn = false;
  redraw();
}

public void myFractal(int x, int y, int len, int filling, int depth) {
  int degrees = (int)(Math.random()*360);
  double angle = radians(degrees);

  int incdepth = depth + 1;

  int xF = (int)(x+Math.cos(angle)*len);
  int yF = (int)(y+Math.sin(angle)*len);

  stroke(filling);
  fill(filling);  
  line(x, y, xF, yF);

  if (depth == 0) {
    angles.add(degrees);
    basex.add(xF);
    basey.add(yF);
  }

  if (len > 50) {
    int r = (int)(Math.random()*256);
    int g = (int)(Math.random()*256);
    int b = (int)(Math.random()*256);

    depth_r[incdepth] = r;
    depth_g[incdepth] = g;
    depth_b[incdepth] = b;

    color ncolor = color(r, g, b);
    for (int i = 0; i < 7; i++) {
      fill(ncolor);
      stroke(ncolor);
      myFractal(xF, yF, len/2, ncolor, incdepth);
    }
  }
}

public void reFractal(int x, int y, int len, int degrees, int depth, int index) {
  int incdepth = depth + 1;
  degrees += (int)(Math.random()*8)+3;
  double angle = radians(degrees);
  int xF = (int)(x+Math.cos(angle)*len);
  int yF = (int)(y+Math.sin(angle)*len);

  line(xF, yF, x, y);

  if (depth == 0) {
    angles.set(index, degrees);
  }

  if (len > 50) {
    int r = depth_r[incdepth];
    int g = depth_g[incdepth];
    int b = depth_b[incdepth];

    color nextcolor = color(r, g, b);
    for (int i = 0; i < 7; i++) {
      fill(nextcolor);
      stroke(nextcolor);
      myFractal(xF, yF, len/2, nextcolor, incdepth);
    }
  }
}
