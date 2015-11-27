void setup() {
  // put your setup code here, to run once:
  Serial.begin(250000);
}
boolean readyToSend = true;
int val1, val2;

int valuesToSend[10][20];
int valuesToSendOld[10][20];

void loop() {
  valuesToSend[0][1] = int(random(100));
  sendValuesToProcessing();
 
}

void sendValuesToProcessing() {
    String toReturn;
    for(int i = 0; i < sizeof(valuesToSend)/sizeof(valuesToSend[0]); i++) {
      for(int j = 0; j < sizeof(valuesToSend[0])/2; j++) {
        if(valuesToSend[i][j] != valuesToSendOld[i][j]) {
          toReturn = String(i) + ";" + String(j) + ";" + String(valuesToSend[i][j]) + ";";
          Serial.println(toReturn);
          valuesToSendOld[i][j] = valuesToSend[i][j];
        }
      }
    }
    delay(5);
}


