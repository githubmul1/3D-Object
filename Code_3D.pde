import processing.core.PApplet;
PApplet p;

float angleX = 0, angleY = 0, angleZ = 0;
float scaleFactor = 1.0;
color objColor;

float camX = 0, camY = 0;
boolean textureOn = false;
boolean lightingOn = true;

void settings() {
  size(800, 600, P3D);
  objColor = color(173, 216, 230); // Biru muda
}

PImage tex;

void setup() {
  p = this;
  frameRate(60);
  tex = loadImage("teksture.jpg"); // pastikan file ini ada di folder "data"
}


void draw() {
  background(0);

  if (lightingOn) {
    lights();
    directionalLight(255, 255, 255, 1, 1, -1);
  } else {
    noLights();
  }

  translate(width / 2 + camX, height / 2 + camY, 0);
  rotateX(radians(angleX));
  rotateY(radians(angleY));
  rotateZ(radians(angleZ));
  scale(scaleFactor);

  pushMatrix();
  fill(objColor);

  drawM(-260, 0);
  drawU(0, 0);
  drawL(240, 0);

  popMatrix();

  updateControls();
}

void drawM(float x, float y) {
  pushMatrix();
  translate(x, y, 0);

  // Balok kiri
  pushMatrix();
  translate(-40, 0, 0);
  if (textureOn) drawTexturedBox(20, 200, 30);
  else box(20, 200, 30);
  popMatrix();

  // Balok kanan
  pushMatrix();
  translate(40, 0, 0);
  if (textureOn) drawTexturedBox(20, 200, 30);
  else box(20, 200, 30);
  popMatrix();

  // Diagonal kiri
  pushMatrix();
  translate(-20, -40, 0);
  rotateZ(radians(-45));
  if (textureOn) drawTexturedBox(20, 110, 30);
  else box(20, 110, 30);
  popMatrix();

  // Diagonal kanan
  pushMatrix();
  translate(20, -40, 0);
  rotateZ(radians(45));
  if (textureOn) drawTexturedBox(20, 110, 30);
  else box(20, 110, 30);
  popMatrix();

  popMatrix();
}


void drawU(float x, float y) {
  pushMatrix();
  translate(x, y, 0);

  // Kiri
  pushMatrix();
  translate(-50, 0, 0);
  if (textureOn) drawTexturedBox(20, 200, 30);
  else box(20, 200, 30);
  popMatrix();

  // Bawah
  pushMatrix();
  translate(0, 80, 0);
  if (textureOn) drawTexturedBox(100, 20, 30);
  else box(100, 20, 30);
  popMatrix();

  // Kanan
  pushMatrix();
  translate(50, 0, 0);
  if (textureOn) drawTexturedBox(20, 200, 30);
  else box(20, 200, 30);
  popMatrix();

  popMatrix();
}


void drawL(float x, float y) {
  pushMatrix();
  translate(x, y, 0);

  // Vertikal
  pushMatrix();
  translate(-30, 0, 0);
  if (textureOn) drawTexturedBox(20, 200, 30);
  else box(20, 200, 30);
  popMatrix();

  // Horizontal
  pushMatrix();
  translate(20, 80, 0);
  if (textureOn) drawTexturedBox(100, 20, 30);
  else box(100, 20, 30);
  popMatrix();

  popMatrix();
}


void drawTexturedBox(float w, float h, float d) {
  beginShape(QUADS);
  texture(tex);

  // Depan
  vertex(-w/2, -h/2, d/2, 0, 0);
  vertex( w/2, -h/2, d/2, tex.width, 0);
  vertex( w/2,  h/2, d/2, tex.width, tex.height);
  vertex(-w/2,  h/2, d/2, 0, tex.height);

  // Belakang
  vertex( w/2, -h/2, -d/2, 0, 0);
  vertex(-w/2, -h/2, -d/2, tex.width, 0);
  vertex(-w/2,  h/2, -d/2, tex.width, tex.height);
  vertex( w/2,  h/2, -d/2, 0, tex.height);

  // Kiri
  vertex(-w/2, -h/2, -d/2, 0, 0);
  vertex(-w/2, -h/2,  d/2, tex.width, 0);
  vertex(-w/2,  h/2,  d/2, tex.width, tex.height);
  vertex(-w/2,  h/2, -d/2, 0, tex.height);

  // Kanan
  vertex( w/2, -h/2,  d/2, 0, 0);
  vertex( w/2, -h/2, -d/2, tex.width, 0);
  vertex( w/2,  h/2, -d/2, tex.width, tex.height);
  vertex( w/2,  h/2,  d/2, 0, tex.height);

  // Atas
  vertex(-w/2, -h/2, -d/2, 0, 0);
  vertex( w/2, -h/2, -d/2, tex.width, 0);
  vertex( w/2, -h/2,  d/2, tex.width, tex.height);
  vertex(-w/2, -h/2,  d/2, 0, tex.height);

  // Bawah
  vertex(-w/2,  h/2,  d/2, 0, 0);
  vertex( w/2,  h/2,  d/2, tex.width, 0);
  vertex( w/2,  h/2, -d/2, tex.width, tex.height);
  vertex(-w/2,  h/2, -d/2, 0, tex.height);

  endShape();
}


void keyPressed() {
  if (key == 'r' || key == 'R') angleZ += 5;
  if (key == 'l' || key == 'L') angleZ -= 5;
  if (key == '+') scaleFactor += 0.1;
  if (key == '-') {
    scaleFactor -= 0.1;
    if (scaleFactor < 0.1) scaleFactor = 0.1;
  }
  if (key == 'a' || key == 'A') camX -= 10; // Crab Left
  if (key == 'd' || key == 'D') camX += 10; // Crab Right
  if (key == 'w' || key == 'W') camY -= 10; // Ped Up
  if (key == 's' || key == 'S') camY += 10; // Ped Down
  if (key == 't' || key == 'T') textureOn = !textureOn; // Texture toggle
  if (key == 'x' || key == 'X') lightingOn = !lightingOn; // Lighting toggle
  if (key == 'm' || key == 'M') objColor = color(173, 216, 230); // Biru muda
  if (key == 'h' || key == 'H') objColor = color(0, 255, 0); // Hijau
  if (key == 'b' || key == 'B') objColor = color(0, 0, 255); // Biru
}

void updateControls() {
  if (keyPressed) {
    if (keyCode == LEFT) angleY -= 2;
    if (keyCode == RIGHT) angleY += 2;
    if (keyCode == UP) angleX += 2;
    if (keyCode == DOWN) angleX -= 2;
  }
}

void mouseDragged() {
  float sensitivity = 0.5;
  angleY += (mouseX - pmouseX) * sensitivity;
  angleX -= (mouseY - pmouseY) * sensitivity;
}
