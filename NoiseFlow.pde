int scl = 20;
int rows, cols;

void setup() {
  size(600, 600, P2D);
  
  rows = height / scl;
  cols = width / scl;
}

void draw() {
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      PVector v = PVector.fromAngle(TWO_PI);
      noFill();
      
      pushMatrix();
      
      translate(x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      
      popMatrix();
    }
  }
}