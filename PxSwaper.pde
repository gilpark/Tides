import java.util.*;

class PxSwaper {
  PVector pos, direction;
  color c;
  PApplet app;
  PImage source;
  int crt;

  //int hst_crt;
  //int[] history;

  PxSwaper(PVector _pos, PVector _direction, color _c ) {
    pos = _pos;
    direction = _direction;
    c = _c;
  }
  PxSwaper(PVector _pos, PVector _direction, PApplet _app ) {
    pos = _pos;
    direction = _direction;
    app = _app;

    //history = new int[10];   
    //initialposition
    //history[0] = (px_w*(int)pos.y)+(int)pos.x;
  }
  void display() {

    app.set((int)pos.x, (int)pos.y, c);
    //app.pixels[(int)pos.y * px_w + (int)pos.x] = c; //works with load/update pixels functions
  }

  void update() {


    pos.add(direction);

    if (alpha(boundary.get((int)pos.x, (int)pos.y)) != 0||pos.y <=0 || pos.y >= width-1) {
      direction.mult(-1);
      crt++;
    }

    color old_c = app.pixels[(px_w*(int)pos.y)+(int)pos.x];
    color new_c = src[crt].pixels[(px_w*(int)pos.y)+(int)pos.x];

    //normalize color
    int a = (old_c >> 24) & 0xFF;
    int r = (old_c >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g = (old_c >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b = old_c & 0xFF;          // Faster way of getting blue(argb)

    int a2 = (new_c >> 24) & 0xFF;
    int r2 = (new_c >> 16) & 0xFF;  // Faster way of getting red(argb)
    int g2 = (new_c >> 8) & 0xFF;   // Faster way of getting green(argb)
    int b2 = new_c & 0xFF;          // Faster way of getting blue(argb)

    c = color((r+r2)*.5, (g+g2)*.5, (b+b2)*.5, (a+a2)*.5);
    crt %=19;

  }

  void historyUpdate() {

    // app.pixels[history[hst_crt]] = color(255, 0, 0);
  }
}

