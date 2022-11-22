//PVector loc; //localização do personagem
class Inimigo extends Personagem 
{
  PVector ini;
  PVector iniV;
  int vida = 30;
  
  PImage[] sprites;
  
  final int ESQ = 3;
  final int BAIXO = 2;

public Inimigo(float x, float y, int lar, int alt, float vel, PImage[] sp)
  {
   super(x,y,lar,alt,vel,null,null);
    
    ini = new PVector(x, y);
    iniV = new PVector(x, y); 
    
    sprites = sp;
    
  }


/*
  public Inimigo(float x, float y, int lar, int alt, float vel, String imgPersonagem)
  {
    super(x,y,lar,alt,vel, imgPersonagem);
    ini = new PVector(x, y);
    iniV = new PVector(x, y);
  
    imagem = loadImage(imgPersonagem);
    sprites = new PImage[4][3];
    for(int i=0;i<4;i++){
      for(int j=0;j<3;j++){
        //sprites[i][j]=imagem.get(j*48,i*64, 48, 64);
        sprites[i][j]=imagem.get(j*lar,i*alt, lar, alt);
      }
    }
  }
  */
  void movimenta()
  {
    iniV = new PVector(p.loc.x, p.loc.y);
    ini.x=loc.x;
    ini.y=loc.y;
    iniV.sub(ini);
    iniV.setMag(vel);
    //ini.add(iniV);
    ini.x+=iniV.x;
    loc.x=ini.x;
    /*
    if(colidiuCenario(camadaColisao))
    {
      if(iniV.x>0) loc.x-=(loc.x+lar)%camadaColisao.tLar;
      else loc.x += 32 -(loc.x+lar)%camadaColisao.tLar;
    }*/
    ini.y+=iniV.y;
    loc.y=ini.y;
    /*
    if(colidiuCenario(camadaColisao))
    {
      if(iniV.y>0) loc.y-=(loc.y+alt)%camadaColisao.tAlt;
      else loc.y += 32 - (loc.y+alt)%camadaColisao.tAlt;
    }*/
    
    
    //loc.x=ini.x;
        
    /*for(Bloco b: blocos)
    {
      if(b.colidiu(this)){
        if(iniV.x>0.1)loc.x=b.x-lar;
        else if(iniV.x<-0.1) loc.x=b.x+b.lar;
      }
    }*/
    
    
    
    /*for(Bloco b: blocos)
    {
      if(b.colidiu(this)){
        if(iniV.y>0.1){
          loc.y=b.y-alt;
        }
        else if(iniV.y<-0.1)
        {
          loc.y=b.y+b.alt;
        }
      }
    }*/
  }
  
  void desenha()
  { 
     strokeWeight(1);
     fill(255,0,0);
  
     if((estado !=3) && tAni.disparou()){
       quadro++;
     }
     if(quadro==3)quadro=0;

     /*
     if(abs(iniV.x)>abs(iniV.y)){
       if(iniV.x<0) ani=ESQ;     
       else ani=DIR;
     }
     else{
       if(iniV.y<0)ani=CIMA;
       else ani=BAIXO;
     }*/
     

   float radians = (float)Math.atan2(cameraY - alt/2 + (p.loc.y-cameraY) - loc.y, cameraX - lar/2 +(p.loc.x-cameraX) - loc.x);
   pushMatrix();
     translate(loc.x-cameraX + lar/2, loc.y-cameraY + alt/2);
     rotate(radians+1.57);
     translate(-lar/2, -alt/2);
     image(sprites[quadro],0,0);
   popMatrix();
   
     
     
     
     /*
     else if(iniV.y<0)ani=CIMA;
     else if(iniV.y>0)ani=BAIXO;
     */
     //image(sprites[quadro],loc.x-cameraX,loc.y-cameraY);
     //rect(loc.x-cameraX,loc.y-cameraY, alt, lar);
     fill(255);
     if(vida != 30) rect(loc.x-cameraX+(lar/2)-(30/2)-10,loc.y-cameraY-10, vida, 5);
     
     /*/*///Arrumar o calculo acima
     /*//*/
     
  }
  
  boolean atinge()
  {
   if (loc.x < p.loc.x + p.alt &&
   loc.x + alt > p.loc.x &&
   loc.y < p.loc.y + p.lar &&
   loc.y + lar > p.loc.y) return true;
   return false;
  }
  
  boolean morte(){
    if(vida <= 0) return true;
    else return false;
  }
  
}
