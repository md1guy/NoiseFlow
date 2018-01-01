import java.util.*;

Random random = new Random();
Noise noise = new Noise();
Particle[] particles = new Particle[100000];

PVector[] flowfield;

int scl = 16;
int rows, cols;

double xoff = 0;
double yoff = 0;
double zoff = random.nextFloat() * 1000000;

float noiseValue;
float maxNoiseHeight;
float minNoiseHeight;

void setup() {
  size(1600, 900, P2D);
  background(255);
  
  rows = height / scl + 1;
  cols = width / scl + 1;
  
  flowfield = new PVector[rows * cols];
  
  for(int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  float[][] heightMap = getNoiseMap();
  xoff = 0;
  yoff = 0;
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      float angle = heightMap[x][y];
      
      PVector v = PVector.fromAngle(angle * TWO_PI * heightMap[x][y]);
      v.setMag(1);
      flowfield[cols * y + x] = v;
      /*
      pushMatrix();
      
      stroke(0, 51);
      strokeWeight(2);
      
      translate(x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      
      popMatrix();
      */
    }
  }
  
  for(int i = 0; i < particles.length; i++) {
    particles[i].checkEdges();
    particles[i].follow(flowfield);
    particles[i].updateSpeed();
    particles[i].drawParticle();
  }
}

float[][] getNoiseMap() {
  float[][] noiseMap = new float[cols][rows];
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      //noiseValue = (noise((float)xoff, (float)yoff, (float)zoff));
      noiseValue = (float)(noise.perlin(xoff, yoff, zoff));
      
      if(noiseValue > maxNoiseHeight) {
        maxNoiseHeight = noiseValue;
      } 
      else if (noiseValue < minNoiseHeight) {
        minNoiseHeight = noiseValue;
      }
      
      noiseMap[x][y] = noiseValue;
      
      yoff += 0.1;
    }
    
    yoff = 0;
    xoff += 0.1;
  }
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      noiseMap[x][y] = map(noiseMap[x][y], minNoiseHeight, maxNoiseHeight, 0, 1);
    }
  }
  
  xoff = 0;
  yoff = 0;
  zoff += 0.001;
  
  return noiseMap;
}