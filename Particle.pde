class Particle {
  PVector pos = new PVector(random.nextFloat() * width, random.nextFloat() * height);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float maxSpeed = 3;
  
  void updateSpeed() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
  }
  
  void drawParticle() {
    stroke(0);
    strokeWeight(5);
    point(pos.x, pos.y);
  }
  
  void follow(PVector[] flowfield) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    PVector force = flowfield[cols * y + x];
    acc.add(force);
  }
  
  void checkEdges() {
    if(pos.x > width) {
      pos.x = 0;
    }
    if(pos.x < 0) {
      pos.x = width;
    }
    if(pos.y > height) {
      pos.y = 0;
    }
    if(pos.y < 0) {
      pos.y = height;
    }
  }
}