import processing.serial.*;
Serial myPort;
String datastr;
int time;
PrintWriter output; 
boolean Save = false;
boolean end = false;
String s = "Not Save";
String str_format = "time(ms), value";


void setup() {
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
  String filename = nf(year(), 4) + nf(month(), 2) + nf(day(), 2) + nf(hour(), 2) + nf(minute(), 2) ; //日時でcsvファイル作成
  output = createWriter( filename + ".csv");
  output.println(str_format);
  size(200, 200); //画面サイズ
  colorMode(RGB, 256);
  fill(0, 0, 0);
  rect(0, 0, 200, 200);
  fill(255, 255, 255); //塗色を設定する
  textSize(16);
  text(s, 65, 80, 80, 80);
}

void draw() {

  if ( myPort.available() > 0) {
    datastr = myPort.readString();
    println(datastr);
    time = millis();
    println(time);
    if (Save == true) { 
      output.print(time);
      output.print(",");
      output.println(datastr);
      s = "Save";
      fill(0, 0, 0);
      rect(0, 0, 200, 200);
      fill(255, 255, 255); //塗色を設定する
      textSize(16);
      text(s, 75, 80, 80, 80);
    }
  }
  if ((Save == false)&&(end == true)) {
    output.flush();  // 出力バッファに残っているデータを全て書き出し
    output.close();  // ファイルを閉じる
    exit();
  }
}
void keyPressed() {
  if (key == 's') {
    if (Save == true) {
      end = true;
    }
    Save = !Save;
  }
}
