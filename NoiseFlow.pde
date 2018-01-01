import java.util.*;

Random random = new Random();
Noise noise = new Noise();
Particle[] particles = new Particle[100];

int scl = 2;
int rows, cols;

double xoff = 0;
double yoff = 0;
double zoff = random.nextFloat();

float noiseValue;
float maxNoiseHeight;
float minNoiseHeight;

void setup() {
  size(600, 600, P2D);
  
  rows = height / scl;
  cols = width / scl;
  
  for(int i = 0; i < particles.length; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  background(255);
  
  for(int i = 0; i < particles.length; i++) {
    particles[i].updateSpeed();
    particles[i].drawParticle();
  }
  
  float[][] heightMap = getNoiseMap();
  
  xoff = 0;
  yoff = 0;
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      float angle = heightMap[x][y];
      
      PVector v = PVector.fromAngle(angle * TWO_PI);
      noFill();
      
      pushMatrix();
      
      stroke(0, 51);
      strokeWeight(2);
      
      translate(x * scl, y * scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      
      popMatrix();
    }
  }
}

float[][] getNoiseMap() {
  float[][] noiseMap = new float[cols][rows];
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      noiseValue = (float)(noise.perlin(xoff, yoff, zoff));
      
      if(noiseValue > maxNoiseHeight) {
        maxNoiseHeight = noiseValue;
      } 
      else if (noiseValue < minNoiseHeight) {
        minNoiseHeight = noiseValue;
      }
      
      noiseMap[x][y] = noiseValue;
      
      xoff += 0.01;
    }
    
    xoff = 0;
    yoff += 0.01;
  }
  
  for(int y = 0; y < rows; y++) {
    for(int x = 0; x < cols; x++) {
      noiseMap[x][y] = map(noiseMap[x][y], minNoiseHeight, maxNoiseHeight, 0, 1);
    }
  }
  
  xoff = 0;
  yoff = 0;
  zoff += 0.002;
  
  return noiseMap;
}