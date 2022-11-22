class Loja {
  float locX, locY, alt, lar;
  boolean dentro=false;
  PImage imgLoja;
  
  
  
  public Loja(float locX, float locY, float alt, float lar, PImage lj)
  {
    this.locX=locX;
    this.locY=locY;
    this.alt=alt;
    this.lar=lar;
    imgLoja = lj;
  }
  
  void desenha(){
    noStroke();
    fill(100,0,0);
    image(imgLoja, locX-cameraX,locY-cameraY);
    //rect(locX-cameraX,locY-cameraY,lar,alt);
  }
  
  boolean safeZone()
  {
    float a, b, c, d, a2, b2, c2, d2;
    a=p.loc.x;
    b=p.loc.x+p.lar;
    c=locX;
    d=locX+lar;
    a2=p.loc.y;
    b2=p.loc.y+p.alt;
    c2=locY;
    d2=locY+alt;
    if(a<d && c<b && a2<d2 && c2<b2) dentro=true;
    else dentro=false;
    return (a<d && c<b && a2<d2 && c2<b2);
   }
}
