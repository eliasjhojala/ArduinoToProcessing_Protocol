void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}
boolean readyToSend = true;
int val1, val2;

int valuesToSend[2];

void loop() {
 
  // put your main code here, to run repeatedly:

  valuesToSend[0] = int(random(100));
  valuesToSend[1] = 100-valuesToSend[0];
  sendValuesToProcessing();
 
}

void sendValuesToProcessing() {
  if(readyToSend) {
    String toSend = bufferToSendToProcessing();
    Serial.println(toSend);
  }
  if(Serial.available() > 0) { readyToSend = true; Serial.read(); } else { readyToSend = false; }
}


String bufferToSendToProcessing() {
  String toReturn;
  for(int i = 0; i < sizeof(valuesToSend); i++) {
    toReturn = toReturn + String(valuesToSend[i]) + ",";
  }
  return toReturn;
}

