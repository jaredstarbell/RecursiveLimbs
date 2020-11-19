// We are all connected, and we are floating in space
//   Jared S Tarbell
//   November 18, 2020
//   The Treehouse, Orcas Island, Washington, USA

int maxgen = 15;
int maxtotal = 1000;
float minr = .5;
float minlen = 1;

ArrayList<Limb> limbs = new ArrayList<Limb>();

float scl = .17;
float sclUnit = .5;

int num = 23;      // number of tree nodes
float rad = 2000;  // radius of tree nodes

boolean firstTime = true;

void setup () {
  //size(1000,1000,FX2D);
  fullScreen(FX2D);
  background(0);
  blendMode(SCREEN);
 
  init();
}

void init() {
  
  background(0);
  limbs.clear();
  pushMatrix();
  
  translate(width/2,height/2);
  if (!firstTime) {
    scl = .02 + (.5*mouseY)/height;
    sclUnit = .2 + (1.0*mouseX)/width;
  }
  scale(scl);

  println("scl:"+scl+"    sclUnit:"+sclUnit);
  float theta = TWO_PI/num;
  
  // show progress
  for (int i=0;i<num;i++) print(".");
  println(".");

  
  // draw lines of complete graph
  stroke(255,128);
  strokeWeight(1.0/scl);
  for (int k=0;k<num-1;k++) {
    for (int n=k+1;n<num;n++) {
      float ax = rad*cos(theta*k);
      float ay = rad*sin(theta*k);
      float bx = rad*cos(theta*n);
      float by = rad*sin(theta*n);
      line(ax,ay,bx,by);
    }
  }
  
  // generate and render all the recursive tree objects
  noStroke();
  for (int k=0;k<num;k++) {
    pushMatrix();
    rotate(theta*k);
    translate(rad-20,0);
    scale(sclUnit*random(1.0,2.0));
    Limb mother = new Limb(0,1,200,100,90,0);
    mother.generate();
    mother.render();
    limbs.add(mother);
    popMatrix();
    print(".");
  }
  println("done.");
  
  popMatrix();
  
  // render starfield
  starfield(2000);
  
  // mark first time complete
  firstTime = false;
  
}

void draw() {
  
}


void starfield(int num) {
  // generate a field of stars
  for (int n=0;n<num;n++) {
    float xx = random(width);
    float yy = random(height);
    float d = dist(width/2,height/2,xx,yy);
    if (d>rad*scl) {
      // cull stars that appear behind complete graph
      float ww = 1-1.5*log(random(1.0));
      ellipse(xx,yy,ww,ww);
    }
  }
}

void keyPressed() {
  // press spacebar to generate new form, position of mouse determines scale and complexity
  if (key==' ') init();
}
