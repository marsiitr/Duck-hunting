
import processing.sound.*;
import KinectPV2.KJoint;
import KinectPV2.*;


KinectPV2 kinect;
SoundFile file;

int frame=0,randx,randy,score=0,bool=0,s,f=0,land=0,time,Time, mil = 0,sec=0,page=1,r,once=0,var=5;
PImage img1,img2,img3,aimer,abc,duck,page2,page1,page3,play,hand,again;
PFont font;


float posX,posY;// to rum the soundfile only for once
Mover mover;


void setup() {
  size(1920, 1080, P3D);
  
    kinect = new KinectPV2(this);
    kinect.enableSkeletonColorMap(true);
    kinect.enableColorImg(true);
    kinect.init();

 Time = millis();
 
  font=createFont("C:/Users/Shreeyash/Desktop/Duck_hunt_game/SEASRN__.ttf", 80);
  mover = new Mover();
   imageMode(CENTER);
   
   
   //bird images
  img1=loadImage("img1.png");
  img2=loadImage("img2.png");
  img3=loadImage("img3.png");
  
  //aimer and other  image
   aimer=loadImage("aimer.png");
   hand=loadImage("hand.png");
   again=loadImage("play_again.png");   
   
   //page1
   page1=loadImage("page1.jpg");
   
   //page 3
    page3=loadImage("page3.png");
    
    //page2
    page2= loadImage("background.png");
    
    
   // start_time();
    // Time = millis();
    
    
    
}


void draw()
{
  
   ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonColorMap();

  //individual JOINTS
  for (int i = 0; i < skeletonArray.size(); i++) 
  {
    KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
    if (skeleton.isTracked())
    {
      KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
   

      //draw different color for each hand state
      drawHandRState(joints[KinectPV2.JointType_HandLeft]);
     // drawHandLState(joints[KinectPV2.JointType_HandRight]);
    }
  }
  
  
  
   
  land++;
  if(land%50==0)
  {
    randx=int(random(1920));
    randy=int(random(810));
    
  }
  
   frame++;
  if (frame%20==0)
  frame=0;
  
  
  
 switch(page)
 {
   case 1:   imageMode(CORNER);
            image(page1,0,0,1920,1080);
            image(aimer,posX,posY,70,70);
            if (once==0)
           {   welcome();
           }
            if(posX>400 && posX<1520 && posY>50 && posY<500 && r==0)
            {  click();
              page=2;
              start_time();
              break;
             }
            break;
            
            
      case 2:
     
             if(millis()-Time>=100 && bool==0)
                {
              mil++;
              if(mil%10==0)
              sec++;
              Time = millis();
             }
              imageMode(CORNER);
             image(page2,0,0,1920,1080);
                     image(hand,posX,posY,100,100);
                     fill(0);
           rect(15,25,330,105);
           rect(1540,25,350,105);
         textFont(font);
          textSize(50);
          fill(50,128,17);
          text("Score :", 40, 90); 
           text(score , 260 , 90); 
           text("Time: ",1560,90);
           text(sec,1730,90);
           text("  :",1790,90);
           text(mil%10,1840,90);
                             
           // Update the location
          mover.update();
          // Display the Mover
          if(millis()-time>=1500 && bool==0 && f==1){
           reset();
            
          }
          if(f==0)
          mover.display();
          
            if(sec>=90)
          {
           f=1;
           bool=1;
           page=3;
          
           break;
       
          }
                    
          break;
          
          
          
     case 3:
              
           imageMode(CORNER);
             image(page3,0,0,1920,1080);    
              textFont(font);
          fill(235,103,20);
          text("TIME OVER!!!",150, 270); 
          text("Your Score : ",100,400);
          text(score,750,400);
          image(again,150,500);
          image(aimer,posX,posY,70,70);
          if (posX>150 && posX <685 && posY>500 && posY < 823 && r==0)
          { 
           start_time();
           
            page=2;
            break;}
            
            break;
          
          
          
           
            
            
   
   
   
   
 }
  
}

    
    
    void start_time()
    { Time = millis();
    
    frame=0;score=0;bool=0;f=0;land=0;mil = 0;sec=0;once=0;var=5;
    
    }
    
    
  void drawHandRState(KJoint joint) {
  noStroke();
  posX=joint.getX();
  posY=joint.getY();
  handState(joint.getState());
  pushMatrix();
  translate(joint.getX(), joint.getY(), joint.getZ());
  //image(aimer,0,0,aimer.width/5,aimer.height/5);
 // ellipse(0, 0, 25, 25);
  popMatrix();
}  
    
    
    
    void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
  s=1;
  r=1;
    fill(0, 255, 0);
    break;
  case KinectPV2.HandState_Closed:
   r=0;
  if(s==1 && page==2){
    shot_sound();
      var=var+5;
    mover.check_shot();
    s++;
  }
    fill(255, 0, 0);
    break;
  case KinectPV2.HandState_Lasso:
    fill(0, 0, 255);
    break;
  case KinectPV2.HandState_NotTracked:
    fill(255, 255, 255);
    break;
  }
}
    
   void welcome()
  
     
     {
       file = new SoundFile(this, "C:/Users/Shreeyash/Desktop/Duck hunt/ducky/FINAL_GAME/sound1.mp3");
      file.loop();
     once=1;
    }
       
   void click()
   {
   file = new SoundFile(this, "C:/Users/Shreeyash/Desktop/Duck_hunt_game/click.mp3");
      file.play();
   }
 
   
void shot_sound()
{
 file = new SoundFile(this, "C:/Users/Shreeyash/Desktop/Duck_hunt_game/shot_sound.mp3");
 file.play();
}

    
    
    void failed()
    {
       file = new SoundFile(this, "C:/Users/Shreeyash/Desktop/Duck_hunt_game/failed.mp3");
        file.play();
    }
    
    
class Mover {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Mover's maximum speed
  float topspeed;

  Mover() {
    // Start in the center
    location = new PVector(width/2,height/2);
    velocity = new PVector(0,0);
    topspeed =35;
  }

   void check_shot()
   {
    if( posX<location.x+94 && posX>location.x-94  && posY<location.y+123 && posY>location.y-123)
    {
     sound_killed(); }
    else
   {
    failed();
   }
   
    
    
    }
     
   
  void update() {
    
    // Compute a vector that points from location to mouse
    PVector rand = new PVector(randx,randy);
    PVector acceleration = PVector.sub(rand,location);
    // Set magnitude of acceleration
    acceleration.setMag(2);
    
    // Velocity c3hanges according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    velocity.limit(topspeed);
    // Location changes by velocity
    location.add(velocity);
  }

  void display()
  {
    stroke(255);
 /*   strokeWeight(2);
    fill(8,54,58);
    ellipse(location.x,location.y,90,90);*/
//  image(myMovie,location.x,location.y,myMovie.height/1.5,myMovie.width/1.588);
  
  if(frame<=5)
   image(img1,location.x,location.y,img1.height/1.5,img1.width/1.588);
   else if(frame<=10)
    image(img2,location.x,location.y,img2.height/1.5,img2.width/1.588);
    else if(frame<=15)
     image(img3,location.x,location.y,img3.height/1.5,img3.width/1.588);
     else if(frame<=20)
      image(img2,location.x,location.y,img2.height/1.5,img2.width/1.588);
  

}}

    
    
    void sound_killed()
{   f=1;
// SPEED=SPEED+2;
    file = new SoundFile(this, "C:/Users/Shreeyash/Desktop/Duck hunt/ducky/perfect.mp3");
    file.play(); 
    score++;
  
    time = millis();
   
   // reset();
}
    
    
void reset()
{
  s=1;
  f=0;
  time = 0;
  //image(abc,960,540);

  
}