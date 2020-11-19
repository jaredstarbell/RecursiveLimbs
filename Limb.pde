class Limb {
  ArrayList<Limb> children = new ArrayList<Limb>();
  
  int gen;
  int total;
  float len;
  float r0, r1;
  float theta;
  
  float x, y;
  
  Limb(int _gen, int _total, float _len, float _r0, float _r1, float _theta) {
    gen = _gen;
    total = _total;
    len = _len;
    r0 = _r0;
    r1 = _r1;
    theta = _theta;
    
  }
  
  int render() {
    pushMatrix();
    rotate(theta);
    
    fill(255,128);
    noStroke();
    ellipse(len,0,r1*2,r1*2);
    beginShape();
    vertex(0,-r0);
    vertex(len,-r1);
    vertex(len,r1);
    vertex(0,r0);
    endShape(CLOSE);
    
    // bright core
    fill(255);
    rectMode(CENTER);
    rect(len/2,0,len,r0*.2);
    
    translate(len,0);
    int cnt = 1;
    for (Limb l:children) cnt+=l.render();
    
    popMatrix();
    
    return cnt;
  }
  
  void generate() {
    // check against limits before generating new children
    if (gen>=maxgen) return;
    if (total>=maxtotal) return;
    if (r1*scl*sclUnit<=minr) return;
    if (len*scl*sclUnit<=minlen) return;
    
    // calculate number of children to have
    int num = floor(random(1,gen*.5));
    num = max(floor((maxgen-gen)*.2),num);
    num = min(num,5);
    // create the children
    for (int n=0;n<num;n++) {
      float nlen = len*random(.94,.98);
      if (n==0 && random(1.0)<.3) nlen*=random(1.5,2.5); else if (nlen>100) nlen=100;
      if (n>0 && random(1.0)<.4) nlen/=2;
      float nr0 = r1;
      float nr1 = r1*random(.6,.9);
      float ntheta = random(-QUARTER_PI,QUARTER_PI);
      Limb neo = new Limb(gen+1,total+num+1,nlen,nr0,nr1,ntheta);
      children.add(neo);
      neo.generate();
      
      // create anti-thesis
      //Limb oen = new Limb(gen+1,total+num+1,nlen,nr0,nr1,-ntheta);
      //children.add(oen);
      //oen.generate();
    }
    
  }
  
}
