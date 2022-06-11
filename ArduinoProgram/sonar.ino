int trigPin1 = 2;
int echoPin1 = 3;

int trigPin2 = 4;
int echoPin2 = 5;

int trigPin3 = 6;
int echoPin3 = 7;

int trigPin4 = 8;
int echoPin4 = 9;


void setup() {
  Serial.begin (9600);
  pinMode(trigPin1, OUTPUT);
  pinMode(echoPin1, INPUT);

  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);

  pinMode(trigPin3, OUTPUT);
  pinMode(echoPin3, INPUT);

  pinMode(trigPin4, OUTPUT);
  pinMode(echoPin4, INPUT);


}

void loop() {
  long duration1, distance1;
  digitalWrite(trigPin1, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin1, LOW);
  duration1 = pulseIn(echoPin1, HIGH);
  distance1 = (duration1 / 2) / 29.1;

  if (distance1 >= 500 || distance1 <= 0) {
    //    Serial.println("Out of range");
  }
  else if (distance1 >= 0 && distance1 <= 25) {
    String s = "0 ";
    s.concat(distance1);
    s.concat(" ");
    Serial.println(s);
  }
  delay(50);
  long duration2, distance2;
  digitalWrite(trigPin2, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin2, LOW);
  duration2 = pulseIn(echoPin2, HIGH);
  distance2 = (duration2 / 2) / 29.1;

  if (distance2 >= 500 || distance2 <= 0) {
    //    Serial.println("Out of range");
  }
  else if (distance2 >= 0 && distance2 <= 25) {
    String s = "1 ";
    s.concat(distance2);
    s.concat(" ");
    Serial.println(s);
  }
  delay(50);



  long duration3, distance3;
  digitalWrite(trigPin3, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin3, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin3, LOW);
  duration3 = pulseIn(echoPin3, HIGH);
  distance3 = (duration3 / 2) / 29.1;

  if (distance3 >= 500 || distance3 <= 0) {
    //      Serial.println("Out of range");
  }
  else if (distance3 >= 0 && distance3 <= 25) {
    String s = "2 ";
    s.concat(distance3);
    s.concat(" ");
    Serial.println(s);

  }
  delay(50);
  //
  long duration4, distance4;
  digitalWrite(trigPin4, LOW);  // Added this line
  delayMicroseconds(2); // Added this line
  digitalWrite(trigPin4, HIGH);
  delayMicroseconds(10); // Added this line
  digitalWrite(trigPin4, LOW);
  duration4 = pulseIn(echoPin4, HIGH);
  distance4 = (duration4 / 2) / 29.1;

  if (distance4 >= 500 || distance4 <= 0) {
    //      Serial.println("Out of range");
  }
  else if (distance4 >= 0 && distance4 <= 25) {
    String s = "3 ";
    s.concat(distance4);
    s.concat(" ");
    Serial.println(s);

  }
  delay(50);
 

}
