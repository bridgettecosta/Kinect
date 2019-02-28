
//video background

import processing.video.*;
Movie myMovie;

//Kinect
import SimpleOpenNI.*;
SimpleOpenNI  kinect;      
int [] userMap;

//Image color silloutte
PImage image1;
int imageindex1 = 0;



void setup() {
  size(640,480);

  myMovie = new Movie(this, "Cymaticssm.mov");
  //myMovie.speed(4);
  myMovie.loop();
  myMovie.loadPixels();

  image1 = loadImage("Picture22.jpg");
  image1.loadPixels();

  imageindex1 = int(random(0, image1.pixels.length));

  kinect = new SimpleOpenNI(this);
  if (kinect.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }
  // enable depthMap generation 
  kinect.enableDepth();

  // enable skeleton generation for all joints
  kinect.enableUser();
  //background(244, 188, 255);
}



void draw() {
  tint(255,30);
  image(myMovie, 0, 0,width,height);
  

if (myMovie.time()>=myMovie.duration()) {
   
    //myMovie.jump(0);
    myMovie.play();
    
  }

  // Color Index 1
  color c1 = image1.pixels[imageindex1];
  imageindex1++;
  if (imageindex1 >= image1.pixels.length) {
    imageindex1 = 0;
  }


  kinect.update();
  // draw the skeleton if it's available
  int[] userList = kinect.getUsers();
  if (userList.length>0)
  {
    userMap = kinect.userMap();
    // load sketches pixels
    loadPixels();
   // println(myMovie.pixels.length);
    for (int i=0; i<userMap.length; i++)
    {
      if (userMap[i]!=0)
      {
       pixels[i] = color(c1);
       //float ratio = i/1.3;
       //pixels[i] = myMovie.pixels[int(ratio)];
       //ratio = 0;
      } 
    }
    updatePixels();
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();

}

// SimpleOpenNI events

//void onNewUser(SimpleOpenNI curContext, int userId)
//{
//  println("onNewUser - userId: " + userId);
//  println("\tstart tracking skeleton");

//  curContext.startTrackingSkeleton(userId);
//}

//void onLostUser(SimpleOpenNI curContext, int userId)
//{
//  println("onLostUser - userId: " + userId);
//}

//void onVisibleUser(SimpleOpenNI curContext, int userId)
//{
//  //println("onVisibleUser - userId: " + userId);
//}
