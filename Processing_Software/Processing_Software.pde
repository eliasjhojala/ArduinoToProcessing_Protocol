import processing.serial.*;

Serial arduino;

void setup() {
  String port = Serial.list()[1];
  println("Connecting to port " + port);
  arduino = new Serial(this, port, 250000);
  size(300, 200);
}

void draw() {
  readValuesFromArduino();
  drawTestRects();
}

int[][] valuesFromArduino = new int[2][14];
void readValuesFromArduino() {
  
  if (arduino.available() > 0) {
    try {
      String buffer = readLine(arduino);
      println(buffer);
      String[] input = buffer.split(";");
      valuesFromArduino[parseValue(input[0])][parseValue(input[1])] = parseValue(input[2]);
    }
    catch (Exception e) { println("error"); } //Do nothing if error
  }
}

void drawTestRects() {
  try { 
    background(0);
    for(int i = 0; i < 10; i++) {
      rect(i*10+10, 100-valuesFromArduino[0][i], 9, valuesFromArduino[0][i]);
    }
  }
  catch(Exception e) {}
}

int parseValue(String s) {
  int number = int((float) Integer.parseInt(s));
  return number;
}

String readLine(Serial device) {
  String buffer = "";
  while (true) {
    char inChar = device.readChar();
    if (inChar == '\n') { break; }
    if (inChar == '\r') { continue; }
    buffer += inChar;
  }
  return buffer;
}