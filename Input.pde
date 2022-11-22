class Input {
  int x, y;
  String texto;
  int lar,alt, count = 0;
  boolean pressionado;
  
   public Input(int x, int y, int lar, int alt, String texto){
    this.x=x;
    this.y=y;
    this.lar=lar;
    this.alt=alt;
    this.texto=texto;
    //this.size=size;
    pressionado=false;
  }
  
  boolean mouseSobre(){
    return (mouseX>x&&mouseX<x+lar&&mouseY>y&&mouseY<y+alt);
  }
  
  void destaque(){
    pressionado=true;
  }
  
  
   void desenhe(){
     fill(255);
     rect(x,y,lar,alt);
     fill(120);
     textAlign(CENTER,CENTER);
     textSize(30);
     if(count<20)text(texto,x,y,lar,alt);
     else text(texto + "|",x,y,lar,alt);
     count++;
     if(count>40) count = 0;

   }
}
