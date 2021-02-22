PrintWriter file; 
float x, y;

void setup() {
  file = createWriter("test.csv");
  x = 0;
  y = 0;
}

void draw() {
  y = 2*x;
  
  file.print(x);
  file.print(",");
  file.println(y);
  
  if(x >= 100) {
    file.flush();
    file.close();
    exit();
  }
  x++;
}
