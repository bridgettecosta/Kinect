
import SimpleOpenNI.*;
SimpleOpenNI  kinect;      
int [] userMap;

PImage bg;

PImage user;

Cloud cloud;

Cloud[] clouds = new Cloud[30];
boolean userOut = true;
//boolean
boolean cloudKinect = true;

int scene=1; 
//ArrayList<Cloud> clouds = new ArrayList<Cloud>();

//PVector noff = new PVector(10000,0,0);


//TO DO ----HOTPOINTS

//make color array values 

//backgrounds


void setup() {
  size(640, 480);

//make backgrounds for scenes
  bg = loadImage("pinkbackground.png");
  image(bg, 0, 0);


  for (int i = 0; i < clouds.length; i++) {
    clouds[i] = new Cloud();
  }
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

  user=createImage(kinect.depthWidth(), kinect.depthHeight(), ARGB);
}


void draw() {

  background(bg);
  
  if (scene==1) {
    drawscene1();
  } else if (scene == 2) {
    drawscene2();
  } else if (scene == 3) {
    drawscene3();
  }
  
  startKinect();
  
}

void drawscene1() {
  
  cloudKinect = true;
  drawClouds();
  //println("scene 1");
  //change background 
  //enter color array for user this scene
}


void drawscene2() {
  cloudKinect = false;
  //println("scene 2");
}

void drawscene3() {
  cloudKinect = false;
  //println("scene 3");
}


void startKinect() {

  kinect.update();

  // draw the skeleton if it's available
    int[] userList = kinect.getUsers();
   // print(userList.length);
  if (userList.length>0)
  {

    int userId = userList[0];

    if ( kinect.isTrackingSkeleton(userId)) {    
      drawSkeleton(userId);
    }

    userMap = kinect.userMap();
    // load sketches pixels
    
    //Enter color array for scenes 
    user.loadPixels();
    for (int i=0; i<userMap.length; i++)
    {
      if (userMap[i]!=0)
      {
        user.pixels[i] = color(143, 180, 252);
      } else
      {
        user.pixels[i] = color(0, 0);
      }
    }
    //background(bg);
    user.updatePixels();

    image(user, 0, 0);
  }
}
void drawSkeleton(int userId) {
  stroke(255);
  strokeWeight(5);
  /*
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_LEFT_HIP);
   */
  noStroke();

  fill(255, 0, 0);
  /*
  drawJoint(userId, SimpleOpenNI.SKEL_HEAD);
   drawJoint(userId, SimpleOpenNI.SKEL_NECK);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
   drawJoint(userId, SimpleOpenNI.SKEL_NECK);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
   drawJoint(userId, SimpleOpenNI.SKEL_TORSO);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);  
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_KNEE);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HIP);  
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_FOOT);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HIP);  
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
   drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);
   drawJoint(userId, SimpleOpenNI.SKEL_LEFT_HAND);
   */
  
  //Drawing interactivity
  //Change scenes 


  //Kinect left hand to vectors

  if (cloudKinect) {
    PVector leftHand = new PVector();
  // PVector rightHand = new PVector();
  // kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
 
 
  
 float confidence = kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);  
  
  if (confidence > 0.5) {
  //userOut = true;
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(leftHand, convertedJoint);
  //println(convertedJoint.y);
    ellipse(convertedJoint.x, convertedJoint.y, 20, 20);
    for (int i = 0; i < clouds.length; i++) {
      clouds[i].kinectDir(convertedJoint);
    }
  } else {
    /*
    if(userOut) {
     println("set timer");
      userOut = false;
     
    }
     */
    //print(userList[0]);
    //kinect.stopTrackingSkeleton(userList[0]);
  }
  }
}


void drawClouds() {

  for (int i = 0; i < clouds.length; i++) {
    PVector wind = new PVector(5, 0);

    //PVector wind = new PVector(map(noise(noff.y), 0, 1, 0.01, .1),0);

    clouds[i].applyForce(wind);
    clouds[i].update();
    //clouds[i].kinectDir();
    //clouds[i].checkEdges();
    clouds[i].display();
  }
  //noff.add(.001,0, 0);
}

void drawJoint(int userId, int jointID) {
  PVector joint = new PVector();
  float confidence = kinect.getJointPositionSkeleton(userId, jointID, joint);
  if (confidence < 0.5) {
    return;
  }
  PVector convertedJoint = new PVector();
  kinect.convertRealWorldToProjective(joint, convertedJoint);
  //a.kinectDir(convertedJoint); 
  ellipse(convertedJoint.x, convertedJoint.y, 5, 5);
}

void nextScene () {
  scene++;
  //println(scene);
  if (scene > 3) {
    scene= 1;
  }
}




void keyPressed() {


  if (key == 'a' || key == 'A') {
    scene = 1;
  }
  if (key == 's' || key == 'S') {
    scene = 2;
  }
  if (key == 'd' || key == 'D') {
    scene = 3;
  }
}

//Calibration not required

void onNewUser(SimpleOpenNI kinect, int userID) {
  println("Start tracking");
  kinect.startTrackingSkeleton(userID);
  
  
}

void onLostUser(SimpleOpenNI curContext, int userId) {
  println("onLostUser - userId: " + userId);
}
