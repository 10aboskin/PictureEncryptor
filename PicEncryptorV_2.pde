PImage src;
PImage img1;
PImage img2;

float transparency;

int frameCountBase;
int magic;

void settings() {
  src = loadImage("fish237.jpg");
  int imgWidth = src.width;
  int imgHeight = src.height;
  size(imgWidth, imgHeight);
}

void setup() {
  magic = generateMagic();
  img1 = src;
  img2 = encrypt(src);
  image(img1, 0, 0);
  delay(2000);
}

void draw() {
  transparency = frameCount - frameCountBase ; 
  tint(255, transparency * 2.5);
  image(img2, 0, 0, width, height);
  tint(255, 255 - transparency * 2.5);
  image(img1, 0, 0, width, height);
  if (255 - transparency * 2.5<=0) {
   delay(2000);
   img1 = img2;
   magic = generateMagic();
   img2 = encrypt(src);
   frameCountBase = frameCount;
  }
}

int generateMagic() {
  int magic = (int)random(7, 4297);
  while (!isPrime(magic)) {
    magic = (int)random(7, 4297); 
  }
  return magic;
}

boolean isPrime(int n) {
  if (n % 2 == 0) return false;
  
  for (int i = 3; i * i <= n; i += 2) {
    if (n % i == 0) return false; 
  }
  return true;
}

PImage encrypt(PImage img) {
  PImage encryptedImg = createImage(img.width, img.height, RGB);
  if (isPrime(magic) && magic >= 7 && magic <= 4297) {
    for (int i = 0; i < img.pixels.length; i++) {
      int newLoc = (i * magic) % img.pixels.length;
      encryptedImg.pixels[newLoc] = img.pixels[i];
    }
  } else {
    println("Invalid Magic Number");
    noLoop();
  }
  return encryptedImg;
}