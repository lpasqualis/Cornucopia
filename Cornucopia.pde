// A Polar coordinate, radius now starts at 0 to spiral outwards

float r=0;
PVector[][] cp;

void setup() {
  size(500, 500, P3D);
  cp = cornucopiaPoints(-130,130,
                        1,5,
                        10,80,
                        radians(0), radians(800),
                        5,
                        80);
}

void draw() {
  //print("Start frame...");
  lights();
  //directionalLight(126, 126, 126, 100, 100, 100);
  //ambientLight(102, 102, 102);
  smooth(4);
  //spotLight(51, 102, 126, 80, 20, 40, -1, 0, 0, PI/2, 2);
  spotLight(51, 102, 126, 
            50, 50, 400, 
            0, 0, -1, 
            PI/16, 4000); 
  
  background(255);
  translate(width/2, height/2,100);
  rotateX(radians(r/3));
  rotateZ(radians(-r/2));
  rotateY(radians(r));
  r+=1;
  fill(0);
  //stroke(0);
  noStroke();
  
  int rows   = cp.length;
  int points = cp[0].length;
  
  fill(191, 166, 119);
  PShape s=createShape();
  s.beginShape(QUADS);

  for(int i=1 ; i<rows ; i++) { //<>//
    PVector[] row0=cp[i-1];
    PVector[] row1=cp[i];
    if(row1==null) break;
    for (int n=1 ; n<points ; n++) {
      s.vertex(row0[n-1].x, row0[n-1].y, row0[n-1].z);
      s.vertex(row0[n].x,   row0[n].y,   row0[n].z);
      s.vertex(row1[n].x,   row1[n].y,   row1[n].z);
      s.vertex(row1[n-1].x, row1[n-1].y, row1[n-1].z);
    }
  }
  s.endShape(CLOSE);
  shape(s);
}


PVector[][] cornucopiaPoints(float z1, float z2,
                             float small_r1, float large_r1,
                             float small_r2,float large_r2,
                             float theta1, float theta2, 
                             int inc_rows, 
                             int points_n) {
  int rows = (int)((z2-z1)/inc_rows)+1;
  PVector[][] ret = new PVector[rows][];
  int idx=0;

  float small_r      = small_r1;
  float large_r      = large_r1;
  float small_incr   = (small_r2-small_r1)/rows;
  float large_incr   = (large_r2-large_r1)/rows;
  
  for (float z=z1 ; z<z2 ; z+=inc_rows) {
    ret[idx]=spiralPoints(z,small_r,large_r,theta1,theta2,points_n);
    for (int i=ret[idx].length-1;i>=0;i--) {
      ret[idx][i]=vectorRotate3D(ret[idx][i],
                                 cos(radians((z))),
                                 sin(radians((z))),
                                 0);
    }
    
    small_r += small_incr;
    large_r += large_incr;
    idx+=1;
  }
  
  return ret;
}

PVector vectorRotate3D(PVector v, float x, float y, float z) {
  PMatrix3D matrix3d = new PMatrix3D();
  PVector result = new PVector();
  matrix3d.rotateX(x);
  matrix3d.rotateY(y);
  matrix3d.rotateZ(z);
  matrix3d.mult(v, result);
  return result; //<>//
}

PVector[] spiralPoints(float z, float r1, float r2, float theta1, float theta2, int points_n) {
  PVector[] points = new PVector[points_n];
  float theta      = theta1;
  int   idx        = 0;
  float theta_inc  = (theta2-theta1)/points_n;
  float radius_inc = (r2-r1)/points_n;
  
  for (float r=r1 ; r<r2 ; r+=radius_inc) {
    if (idx>=points_n) break;
    points[idx] = new PVector();
    points[idx].x = r * cos(theta);
    points[idx].y = r * sin(theta);
    points[idx].z = z;
    theta += theta_inc;
    idx++;
  }
  return points;
}