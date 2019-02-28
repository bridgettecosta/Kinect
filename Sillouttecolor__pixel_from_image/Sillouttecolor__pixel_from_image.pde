import SimpleOpenNI.*;
SimpleOpenNI  kinect;      
int [] userMap;


PImage image1;
int imageindex1 = 0;


void setup()
{
  size(640, 480);

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
  background(244, 188, 255);
}

void draw()
{
  // update the cam
  background(244, 188, 255);
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
    for (int i=0; i<userMap.length; i++)
    {
      if (userMap[i]!=0)
      {
        pixels[i] = color(c1);
      } else
      {
        pixels[i] = color(244, 188, 255);
      }
    }
    updatePixels();
  }
}
// -----------------------------------------------------------------
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curContext, int userId)
{
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");

  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}
