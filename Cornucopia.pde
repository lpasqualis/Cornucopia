/*
 * Cornucopia
 * Author: Lorenzo Pasqualis
 */

float r=0;
CornucopiaShape cs = new CornucopiaShape();

void setup() {
  size(600, 600, P3D);
  frameRate(60);
  cs.generate(-180,180,
              8,20,
              10,80,
              radians(0), radians(600),
              5,
              80);
  smooth(8);
}

void draw() {
  lights();
  spotLight(51, 102, 126, 
            50, 50, 400, 
            0, 0, -1, 
            PI/16, 4000); 
  lightSpecular(255, 255, 255);
  specular(255, 255, 255);          
  
  background(0);
  translate(width/2, height/2,100);
  rotateX(radians(r*0.3));
  rotateY(radians(r*0.2));
  rotateZ(radians(r*0.5));
  r+=1;
  noStroke();

  cs.rotate(noise(r/500,-r/300)*8-4,noise(r/1000,r/1000)*8-4,0);
  cs.draw();
}

void keyPressed() {
  if (key == 's') {
    save("saved-image.png");
  }
}