Noise noise = new Noise();

int scl = 20;
int rows, cols;

double xoff = 0;
double yoff = 0;
double zoff = 0;

void setup() {
  size(600, 600, P2D);
  
  rows = height / scl;
  cols = width / scl;
}

void draw() {
  background(255);
  
  xoff = 0;
  yoff = 0;
  
  for(int y = 0; y < height; y++) {
    for(int x = 0; x < width; x++) {
      float angle = (float)noise.perlin(xoff, yoff, zoff);
      
      PVector v = PVector.fromAngle(angle * TWO_PI);
      noFill();
      
      pushMatrix();
      
      translate(x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      
      popMatrix();
      
      xoff += 0.1;
    }
    
    xoff = 0;
    yoff += 0.1;
  }
}