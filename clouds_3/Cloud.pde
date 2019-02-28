class Cloud {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  PImage cloud;
  float topspeed;
  PVector hand;
  //float size;
  float mass;
  float xn, yn;
  float tx, ty;
  PVector locationOld;
  float randYloc = random(0, 100);
  float nCloud;
  
  Cloud(){
    
    hand = new PVector(width/2, height);
    location = new PVector(random(0, width), randYloc);
    locationOld = new PVector(0, randYloc);
    velocity = new PVector(0,0);
    acceleration = new PVector(0, 0);
    topspeed = random(1,5);
    //size = random(1, 1.7);
    mass = 1;
    nCloud  = random(1,5);
    cloud = loadImage("Cloud" + parseInt(nCloud) + ".png");
    
  }
  
   void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
   void kinectDir(PVector l) {
    hand = l.get();
    //println(location.x);   
  }
 
  void update() {
    //println(hand.y);
    
     if(hand.y < 150) {
    PVector acceleration = PVector.sub(hand, location);
    acceleration.setMag(22);
   // println(acceleration.y);
    PVector mUp = new PVector(0, -acceleration.y - 4);
    applyForce(mUp);
    }
    
    else {
    PVector accelerationBack = PVector.sub(locationOld, location);
    PVector mBack = new PVector(0, accelerationBack.y);
    applyForce(mBack);
   // location.y = locationOld.y;
      
      
      
    }
   
    velocity.add(acceleration);
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
    acceleration.mult(0);
    if(location.x > width) {
     location.x = 0 - cloud.width/2;  
    }
    
  }
  
  void display() {
    
   stroke(255);
   strokeWeight(2);
   fill(127);
  /*  
    tx = 0;
    ty = 10000;
    
    xn = map(noise(tx), 0, 1, -.9,.9);
    yn = map(noise(ty), 0, 1, -.9,.9);
   
   // PVector vel = new PVector(xn,yn);
   //// vel.mult(0);
   // tx += 0.1;
   // ty += 0.1;
     
   // PVector vel = new PVector(random(-.6,.6),random(-.6,.6));
    //location.add(vel);
    
    */
  image(cloud, location.x, location.y, cloud.width, cloud.height);
    //ellipse(location.x, location.y, 48,48);
    
  }
  
  /*
  boolean isAlive() {
    
    
    
    return;
  }
  */
  
   void checkEdges() {

    if (location.y > 150) {
      location.y = 150;
      velocity.y *= -.01;
    } 
    else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -.8;
    }

  }
  
 
  
}
