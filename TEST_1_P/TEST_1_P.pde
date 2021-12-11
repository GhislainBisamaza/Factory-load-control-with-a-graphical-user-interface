/***********************************
 First upload the Arduino code to the Arduino and then run this code.
 Make sure that the Port number and baudrate are the same.
***********************************/
import meter.*;
import processing.serial.*;
import controlP5.*;

Serial myPort;

String val= "";

Meter m;

ControlP5 cp5; //create ControlP5 object
PFont font;
PImage back;

void setup() {
  size(1200, 500);
  back= loadImage("image.jpg");
  
  printArray(Serial.list());
  myPort = new Serial(this, "COM15", 9600);
  myPort.bufferUntil('\n');

  fill(120, 50, 0);
  m = new Meter(this, 25, 100);
  // Adjust font color of meter value  
  m.setTitleFontSize(20);
  m.setTitleFontName("Arial bold");
  m.setTitle("Temperature (C)");
  m.setDisplayDigitalMeterValue(true);
  
  // Meter Scale
  String[] scaleLabelsT = {"0", "10", "20", "30", "40", "50", "60", "70", "80"};
  m.setScaleLabels(scaleLabelsT);
  m.setScaleFontSize(18);
  m.setScaleFontName("Times New Roman bold");
  m.setScaleFontColor(color(200, 30, 70));
  
  m.setArcColor(color(141, 113, 178));
  m.setArcThickness(10);
  m.setMaxScaleValue(80);
  
  m.setNeedleThickness(3);
  
  m.setMinInputSignal(0);
  m.setMaxInputSignal(80);
  
  cp5 = new ControlP5(this);
  font = createFont("calibri light bold", 20);    // custom fonts for buttons and title
  
  cp5.addButton("MACHINE1_ON")     //"red" is the name of button
    .setPosition(600, 100)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font)
  ;   
  
  cp5.addButton("MACHINE2_ON")     //"yellow" is the name of button
    .setPosition(600, 200)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font)
  ;
  
   cp5.addButton("MACHINE3_ON")     //"blue" is the name of button
    .setPosition(600, 300)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font)
  ;
  
  cp5.addButton("MACHINE1_OFF")     //"alloff" is the name of button
    .setPosition(800, 100)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font)
  ;
   cp5.addButton("MACHINE2_OFF")     //"red" is the name of button
    .setPosition(800, 200)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font);
    
   cp5.addButton("MACHINE3_OFF")     //"red" is the name of button
    .setPosition(800, 300)  //x and y coordinates of upper left corner of button
    .setSize(160, 70)      //(width, height)
    .setFont(font);

 
}
void serialEvent(Serial myPort)// whenever serial event happens it runs
{
  val = myPort.readStringUntil('\n'); //gathering data from port in a variable val
 

}

public void draw() {
  background(255);
  image(back,0,0);
  
  textSize(30);
  fill(250);
  text("COLD ROOM TEMPERATURE", 40, 90);
  text("MACHINE CONTROL", 600, 90);
  line(530,70,530,500);
  
 
println("Temperature: " + val /*+ "Humidity: " + hum + " %"*/);
    
    m.updateMeter(int(val));
    return;
}
void MACHINE1_ON(){
  myPort.write('r');
}

void MACHINE2_ON(){
  myPort.write('y');
}

void MACHINE3_ON(){
  myPort.write('b');
}

void MACHINE1_OFF(){
  myPort.write('f');
}
void MACHINE2_OFF(){
  myPort.write('a');
}
void MACHINE3_OFF(){
  myPort.write('c');
}
  
