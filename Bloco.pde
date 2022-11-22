class Bloco{
  float x,y;
  float lar, alt;
  
  public Bloco(float xi, float yi, float lar, float alt){
    x=xi;
    y=yi;
    this.alt=alt;
    this.lar=lar;
  }
  
  void desenha(){
    noStroke();
    fill(100,200,100);
    rect(x-cameraX,y-cameraY,lar,alt);
  }
  
  boolean colidiu(Personagem p)
  {
    float a, b, c, d, a2, b2, c2, d2;
    a=p.loc.x;
    b=p.loc.x+p.lar;
    c=x;
    d=x+lar;
    a2=p.loc.y;
    b2=p.loc.y+p.alt;
    c2=y;
    d2=y+alt;
    return (a<d && c<b && a2<d2 && c2<b2);
  }
}
