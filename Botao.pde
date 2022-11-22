class Botao{
  int x, y,size;
  String texto;
  int lar,alt;
  boolean pressionado;
  
  
  public Botao(int x, int y, int lar, int alt, String texto, int size){
    this.x=x;
    this.y=y;
    this.lar=lar;
    this.alt=alt;
    this.texto=texto;
    this.size=size;
    pressionado=false;
  }
  
  boolean mouseSobre(){
    return (mouseX>x&&mouseX<x+lar&&mouseY>y&&mouseY<y+alt);
  }
  
  void destaque(){
    pressionado=true;
  }
  
  void removeDestaque(){
    pressionado=false;
  }
  
  void desenhe(){ //int tSize, int opacidade
    if(pressionado)fill(255,255,100);
    else fill(255);
    rect(x,y,lar,alt);
    fill(120);
    textAlign(CENTER,CENTER);
    textSize(size);
    text(texto,x,y,lar,alt);
  }
}
