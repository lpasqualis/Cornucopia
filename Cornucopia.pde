// A Polar coordinate, radius now starts at 0 to spiral outwards

float r=0;

void setup() {
  size(500, 500, P3D);
}

void draw() {
  background(255);
  translate(width/2, height/2,100);
  rotateX(radians(r/3));
  rotateZ(radians(-r/2));
  rotateY(radians(r));
  r+=1;
  //r%=360;
  fill(0);
  stroke(0);
  float r1=1;
  float r2=5;
  float incr1=0.2;
  float incr2=1.1;
  for (float z=-130;z<130;z+=3) {
    spiral(0,0,z, r1,r2, radians(0), radians(600), 200);
    rotateY(cos(radians((z/40)))/50);
    rotateX(sin(radians((z/40)))/50);
    r1+=incr1;
    r2+=incr2;
  }
}

void spiral(float x0, float y0, float z0, float r1, float r2, float theta1, float theta2, float points_n) {
  pushMatrix();
  translate(x0, y0,z0);
  float theta = theta1;
  float x1,y1,z1;
  float x2,y2,z2;

  float theta_inc  = (theta2-theta1)/points_n;
  float radius_inc = (r2-r1)/points_n;

  x1 = r1 * cos(theta);
  y1 = r1 * sin(theta);
  z1 = 0;

  fill(0);

  for (float r=r1 ; r<r2 ; r+=radius_inc) {
    theta += theta_inc;
    // Polar to Cartesian conversion
    x2 = r * cos(theta);
    y2 = r * sin(theta);
    z2 = 0;
    line(x1,y1,z1,x2,y2,z2);
    x1 = x2;
    y1 = y2;
    z1 = z2;
  }
  popMatrix();
}