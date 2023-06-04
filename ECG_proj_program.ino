void setup()
{
 Serial.begin(9600);
 pinMode(5,INPUT);//L0+
 pinMode(6,INPUT);//L0-
}
void loop() 
{
    if((digitalRead(5)==1)||(digitalRead(6)==1)) 
    {
     Serial.println('!');
    }
     else
    {
     Serial.println(analogRead(A1));
    }
delay(10);
}
