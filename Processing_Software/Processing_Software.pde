import processing.serial.*;

Serial arduino;

void setup() {
  String port = Serial.list()[1];
  println("Connecting to port " + port);
  arduino = new Serial(this, port, 115200);
  size(300, 200);
}

void draw() {
  readValuesFromArduino();
}

int[][] valuesFromArduino;

int counter = 0;

void readValuesFromArduino() {
  
  if (arduino.available() > 0) {
    try {
      String buffer = readLine(arduino);
      println(buffer);
      arduino.write(1); // tell arduino we can read the next values
      String[] input = buffer.split(";");
      String[][] input2D = new String[input.length][];
      valuesFromArduino = new int[input.length][];
      for(int i = 0; i < input.length; i++) {
        try {
          String[] inputSplitted = input[i].split(",");
          input2D[i] = new String[inputSplitted.length];
          valuesFromArduino[i] = new int[inputSplitted.length];
          for(int j = 0; j < inputSplitted.length; j++) {
            try {
              input2D[i][j] = inputSplitted[j];
              valuesFromArduino[i][j] = int(parseValue(input2D[i][j]));
              
            }
            catch (Exception e) {}
          }
        }
        catch (Exception e) {}
      }
      counter++;
    }
    catch (Exception e) { /*println("error"); */} //Do nothing if error
  }
  drawTestRects();
}

void drawTestRects() {
  try { 
    background(0);
    rect(valuesFromArduino[0][0], valuesFromArduino[0][1], valuesFromArduino[1][1], valuesFromArduino[1][1]);  
  }
  catch(Exception e) {}
}

float parseValue(String s) {
  float number = (float) Integer.parseInt(s);
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