#include <DueTimer.h>
#include <SineWaveDue.h>

float Sa  = 1200; // base note frequency (Sa)

int bar =  2000; // bar length in ms
int _16 = bar / 16;

int melody[] = { 0, 1, 3, 5, 7, 8, 10, 12 };

float note(float semitone) {
  return Sa * pow(2, semitone / 12);
}


void setup() {
  analogReadResolution(10);
  analogWriteResolution(10);
//  pinMode(9, OUTPUT);
  Serial.begin(9600);
}

void loop()  {
  
  for (int i = 0; i < 8; i++) {
    sw.playTone(note(melody[i]), _16);
    delay(_16);
    sw.playTone(Sa, _16);
    delay(_16);
    
    
    
//    Serial.println(note(i));
//    Serial.println(1/12);
//    sw.playTone2(Sa, note(i), 1000);
//    delay(1000);
  }



  //    sw.playTone(2000);
  //    delay(1000);
  //    sw.stopTone();
  //    sw.playTone2(1000, 1200);
  //    delay(1000);
  //    sw.stopTone();
  //    sw.playTone(5000, 1000);
  //    for( int i; i<10; i++){
  //      digitalWrite(9, HIGH);
  //      sw.playToneDecay(400, .1*i);
  //      delay(1000);
  //      digitalWrite(9, LOW);
  //      delay(100);
  //    }

}
