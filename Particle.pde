class Particle {
  PVector pos = new PVector(random.nextFloat() * width, random.nextFloat() * height);
  PVector vel = PVector.random2D();
  PVector acc = new PVector(0, 0);
  
  void updateSpeed() {
    checkEdges();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void drawParticle() {
    stroke(0);
    strokeWeight(3);
    point(pos.x, pos.y);
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