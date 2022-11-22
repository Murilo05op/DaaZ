class Personagem
{
  PVector loc;
  float vel;
  float alt, lar;
  PImage imagem, imagemTiro, lanterna;
  int estado;
  final int ANDANDO=0;
  final int ATIRANDO=1;
  
  PImage[][] sprites;
  int ani; //animação do zezinho
  int quadro;
  Timer tAni; //timer animação
  final int ESQ = 2;
  final int DIR = 1;
  final int CIMA = 0;
  final int BAIXO = 3 ;
  public Personagem(float x, float y, int lar, int alt, float vel, String imgPersonagem,String imgAtirando)
  {
    loc = new PVector(x, y);
    ani=0;
    quadro=0;
    this.alt=alt;
    this.lar=lar;
    //this.x=x;
    //this.y=y;
    this.vel=vel;
    

    //imagem = loadImage("./img/test.png");
    if(imgPersonagem!=null){
    estado = ANDANDO;
    //lanterna = loadImage("./img/lanterna.png");
    imagem = loadImage(imgPersonagem);
    imagemTiro = loadImage(imgAtirando);
    //imagem.resize(0,72);
    sprites = new PImage[2][4];
    for(int i=0;i<2;i++){
      for(int j=0;j<4;j++){
        if(i==0)
          sprites[i][j]=imagem.get(j%2*lar,i*alt, lar, alt);
        else sprites[i][j]=imagemTiro.get(j*lar,0, lar, alt);
        //sprites[i][j].resize(0, 128);
      }
    }
    }
    tAni = new Timer(1000/(12));
  }
  
  void movimenta()
  {
    if((cima|| baixo) && (dir || esq)) vel=2.83;
    else vel=4;
    

    if(dir){
      loc.x=loc.x+vel;
      if(p.colidiuCenario(camadaColisao))
      loc.x-=(loc.x+lar)%camadaColisao.tLar;
    }
    else if(esq){
      loc.x=loc.x-vel;
      if(p.colidiuCenario(camadaColisao))
      loc.x += 32 -(loc.x+lar)%camadaColisao.tLar;
    }
    
    if(baixo){
      loc.y=loc.y+vel;
      if(p.colidiuCenario(camadaColisao))
      loc.y-=(loc.y+alt)%camadaColisao.tAlt;
    }
    else if(cima){
      loc.y=loc.y-vel;
      if(p.colidiuCenario(camadaColisao))
      loc.y += 32 - (loc.y+alt)%camadaColisao.tAlt;
    }    
    
    
    //Verifica e arruma a camera //campo de visão
    if(loc.x>cameraX+width-margem-lar)
      cameraX=loc.x-width+margem+lar;
    if(loc.x-lar-cameraX<margem)
      cameraX=loc.x-lar-margem;
    if(loc.y>cameraY+height-margem-alt)
      cameraY=loc.y-height+margem+alt;
    if(loc.y-alt-cameraY<margem)
      cameraY=loc.y-alt-margem;
  }
  
  
  void desenha()
  {
   strokeWeight(1);
   fill(255);

   if(estado==ANDANDO && (esq || dir || cima || baixo) && tAni.disparou()){
     quadro++;
     if(quadro==4)quadro=0;
     //quadro = (quadro+1)%4;
   }
   else if(estado==ATIRANDO)
   {
     if(tAni.disparou())
     quadro++;
     if(quadro==4)
     {
       quadro=0;
       estado=ANDANDO;
     }
   }
   
   if(esq)ani=ESQ;
   else if(dir)ani=DIR;
   else if(cima)ani=CIMA;
   else if(baixo)ani=BAIXO;
   
   float radians = (float)Math.atan2(cameraY - alt/2 + mouseY - loc.y, cameraX - lar/2 + mouseX - loc.x);  
   pushMatrix();
     translate(loc.x-cameraX + lar/2, loc.y-cameraY + alt/2);
     rotate(radians+1.57);
     translate(-lar/2, -alt/2);
     image(sprites[estado][quadro],0,0);

beginShape();
fill(0,0,0,200);
//vertex(loc.x-cameraX + lar/2-2*width,loc.y-cameraY + alt/2-2*height);
//vertex(width/2, height/2);
//vertex(loc.x-cameraX + lar/2, loc.y-cameraY + alt/2);
vertex(-2*width+lar/2,-3*height+alt/2);

vertex(lar/2, alt/2);
vertex(2*width+lar/2,-3*height+alt/2);
vertex(2*width+lar/2,2*height+alt/2);
vertex(-2*width+lar/2,2*height+alt/2);
//vertex(loc.x-cameraX + lar/2+2*width,loc.y-cameraY + alt/2-2*height);
//vertex(loc.x-cameraX + lar/2+2*width,loc.y-cameraY + alt/2+2*height);
//vertex(loc.x-cameraX + lar/2-2*width,loc.y-cameraY + alt/2+2*height);
endShape(CLOSE);

     //Lanterna
     imageMode(CENTER);
     //image(lanterna,0,0);
     noStroke();

     imageMode(CORNER);
   popMatrix();
   
   
   
   /*
   pushMatrix();
     translate(width/2, height/2);
     rotate(radians+1.57);
     translate(-width/2, -height/2);
beginShape();
vertex(-width, -2*height);
vertex(width/2, height/2);
vertex(2*width, -2*height);
vertex(2*width, 3*height);
vertex(-width, 3*height);
endShape(CLOSE);
    imageMode(CORNER);
   popMatrix();
   */
   
   fill(0,0,0,90);
   rect(0,0,width,height);
   //image(lanterna,0,0);
   
   //image(sprites[0][quadro],loc.x-cameraX,loc.y-cameraY);
   //rect(loc.x-cameraX,loc.y-cameraY, alt, lar);
  }
  
  boolean colidiuCenario(Map colisao){
    int xi,xf,yi,yf;
    
    xi= (int)(loc.x)/colisao.tLar;
    xf= (int)(loc.x+lar-1)/colisao.tLar;
    yi= (int)(loc.y)/colisao.tAlt;
    yf= (int)(loc.y+alt-1)/colisao.tAlt;
    
    if(xi<0)xi=0;
    if(xi>colisao.lar-1) xi=colisao.lar-1;
    if(xf<0)xf=0;
    if(xf>colisao.lar-1) xf=colisao.lar-1;
    
    if(yi<0)yi=0;
    if(yi>colisao.alt-1) yi=colisao.alt-1;
    if(yf<0)yf=0;
    if(yf>colisao.alt-1) yf=colisao.alt-1;
    
    for(int i=xi; i<=xf;i++){
      for(int j=yi; j<=yf; j++){
        if(colisao.get(j,i)!=-1) return true;
      }
    }
    return false;
  }
}
