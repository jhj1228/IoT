void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

double th(int v) {
  double t;
  t = log(((10240000/v) - 10000));
  t = 1 /(0.001129148 + (0.000234125*t) + (0.0000000876741*t*t*t));
  t = t - 273.15;
  return t;
}

void loop() {
  if(Serial.available()>0) {
  String m = Serial.readStringUntil('\n');
  if(m == "1") digitalWrite(13, HIGH);
  if(m == "0") digitalWrite(13, LOW);
  }
  
  int a = analogRead(A0);
  int b = analogRead(A1);
  
  Serial.print("Temp: ");
  Serial.print(th(a));
  Serial.print(" illu: ");
  Serial.println(b);
  
  delay(1000);
}
