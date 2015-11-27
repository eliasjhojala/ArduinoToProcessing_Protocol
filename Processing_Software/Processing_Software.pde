import processing.serial.*;

Serial arduino;

void setup() {
  String port = Serial.list()[1];
  println("Connecting to port " + port);
  arduino = new Serial(this, port, 115200);
  size(300, 200);
}

void draw() {
  updatePotentiometers();
}

int[][] valuesFromArduino;

void updatePotentiometers() {
  
  if (arduino.available() > 0) {
    try {
      background(0);
      String buffer = readLine(arduino);
      arduino.write(1); // tell arduino we can read the next values
      String numbers = buffer.split(",")[0];
      String booleans = buffer.split(",")[1];
      String[] input = buffer.split(";");
      String[][] input2D = new String[input.length][];
      valuesFromArduino = new int[input.length][];
      for(int i = 0; i < input.length; i++) {
        String[] inputSplitted = input[i].split(",");
        input2D[i] = new String[inputSplitted.length];
        valuesFromArduino[i] = new int[inputSplitted.length];
        for(int j = 0; j < inputSplitted.length; j++) {
          input2D[i][j] = inputSplitted[j];
          valuesFromArduino[i][j] = int(parseValue(input2D[i][j]));
        }
      }
      try { rect(valuesFromArduino[0][0], valuesFromArduino[0][1], valuesFromArduino[1][1], valuesFromArduino[1][1]); }
   // rect(parseValue(input2D[1][1]), 40, 10, 10);}
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