void setup() {
  // put your setup code here, to run once:
  Serial.begin(250000);
}
boolean readyToSend = true;
int val1, val2;

int valuesToSend[1][12];

void loop() {
 
  // put your main code here, to run repeatedly:

  valuesToSend[0][0] = int(random(100));
  valuesToSend[0][1] = 100-valuesToSend[0][0];
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
  for(int i = 0; i < sizeof(valuesToSend)/sizeof(valuesToSend[0]); i++) {
    for(int j = 0; j < sizeof(valuesToSend[0])/2; j++) {
      toReturn = toReturn + String(valuesToSend[i][j]);
      if(j < sizeof(valuesToSend[0])/2-1) toReturn = toReturn+",";
    }
    toReturn = toReturn + ";";
  }
  return toReturn;
}


