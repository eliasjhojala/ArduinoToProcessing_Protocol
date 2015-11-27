import processing.serial.*;

Serial arduino;

void setup() {
  String port = Serial.list()[1];
  println("Connecting to port " + port);
  arduino = new Serial(this, port, 115200);
  size(300, 100);
}

void draw() {
  updatePotentiometers();
}

void updatePotentiometers() {
  
  if (arduino.available() > 0) {
    try {
      background(0);
      String buffer = readLine(arduino);
      arduino.write(1); // tell arduino we can read the next values
      String numbers = buffer.split(",")[0];
      String booleans = buffer.split(",")[1];
      try { rect(parseValue(numbers), 10, 10, 10); rect(parseValue(booleans), 20, 10, 10); }
      catch (Exception e) {}
      delay(10);
    }
    catch (Exception e) {
    }
  }
  
}

float parseValue(String s) {
  float number = (float) Integer.parseInt(s);
  return number;
}

String readLine(Serial device) {
  String buffer = "";
  while (true) {
    char inChar = device.readChar();
    if (inChar == '\n') {
      break;
    }
    if (inChar == '\r') {
      continue;
    }
    buffer += inChar;
  }
  return buffer;
}