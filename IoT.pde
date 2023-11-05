import processing.serial.*;
import processing.net.*;
Serial p;
Server s;
Client c;

void setup() {
  p = new Serial(this, "COM3", 9600);
  s = new Server(this, 12345);
}

String msg="";
void draw() {
  c = s.available();
  if (c != null) {
    String m = c.readString();
    if (m.indexOf("GET /") == 0) {
      c.write("HTTP/1.1 200 OK\r\n\r\n");
      c.write(msg);
    }
    c.stop();
    
    if (m.indexOf("PUT /")==0) {
      int n = m.indexOf("\r\n\r\n") + 4;
      m = m.substring(n);
      m += '\n';
      p.write(m);
      print(m);
    }
  }
  
  if (p.available()>0) {
    String m = p.readStringUntil('\n');
    if (m!=null)  msg = m;
    print(msg);
  }
}
