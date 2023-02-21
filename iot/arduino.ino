int redLed=10,buzzer=6,smoke=A3;
void setup() {
  pinMode(redLed,OUTPUT);
  pinMode(buzzer,OUTPUT);
  pinMode(smoke,INPUT);
  Serial.begin(9600);
}

void loop() {
int analogSensor = analogRead(smoke);
Serial.println(analogSensor);
if(analogSensor > 660)
{
  digitalWrite(redLed,HIGH);
  Serial.print("ACTIVE");
  digitalWrite(buzzer,HIGH);
  delay(5000);
  digitalWrite(redLed,LOW);
  digitalWrite(buzzer,LOW);
}
else
{
  digitalWrite(redLed,LOW);
  digitalWrite(buzzer,LOW);
}
}