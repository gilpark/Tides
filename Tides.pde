
PImage[] src; //source images

PImage mask, boundary, edge;
int px_w, px_h, px_total;
int current;

ArrayList<PxSwaper> psList;
float transition;

void setup() {

  background(0); 

  src = new PImage[20];

  //load 20 images
  for (int i = 0; i < 20; i++) {
    String index = "";
    index = i + ".png";
    src[i] = loadImage(index);
  }

  size(1100, 1100, P3D);

  edge = loadImage("edge.png");
  boundary = loadImage("bound.png");
  mask = loadImage("mask.png");
  px_w = 1100;
  px_h = 1100;
  px_total = 1100 * 1100;

  psList = new ArrayList<PxSwaper>();

  //add pixell swaper objects to arraylist
  for (int i = 0; i < px_total; i=i+8) { //every 8 pixel
    color c = src[2].pixels[i];
    int x = i%px_w;
    int y = i/px_w;

    if (alpha(boundary.get((int)x, (int)y)) == 0) {//masking boundary
      if (red(c)>100 &&green(c)>100&&blue(c)>100) {
        PVector p = new PVector(x, y);
        PVector d;
        d = new PVector(0.65, 1); //particle moving direction
        psList.add(new PxSwaper(p, d, this));
      }
    }
  }
  strokeWeight(1.8);

  //initial background
  for (int i = 0; i < px_total; i=i+9) {
    color c = src[0].pixels[i];

    int x = i%px_w;
    int y = i/px_w;
    //println(x);
    if (alpha(boundary.get((int)x, (int)y)) != 0) {
      if (red(c)>20 &&green(c)>20&&blue(c)>20) {
        stroke(src[0].pixels[i]);
        point(x, y);
      }
    }
  }

  loadPixels();
}

//void findEdge() {
//  opcv = new OpenCV(this, src[0]);
//  opcv.findCannyEdges(20, 75);
//  edge = opcv.getSnapshot();
//}

void draw() {
  
  transition +=.012;
  tint(255,255,255, map(sin(transition), -1, 1, 4, 10));
  image(mask, 0, 0);
  tint(255,255,255);
  //rect(0, 0, width, height);

  for (PxSwaper p : psList) {
    p.update();
    p.display();
    //p.historyUpdate();
  }

  //updatePixels();
  fill(255);
//  text(frameRate, width-100, 20);
  //println(frameRate);
  //println(map(sin(transition), -1, 1, 0, 10));
}

void keyPressed(){
  saveFrame();
}
