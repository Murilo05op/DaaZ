class Atira{
  PVector tiro; //posicao do tiro
  PVector tiroV; //velocidade do tiro
  PVector mouse;
  
  float x,y,px,py;
  float lar, alt;
  
  int dano;
  int tamanho_municao = 8;
  
  public Atira(float x, float y, int dano){
    this.x=x;
    this.y=y;
    this.dano=dano;
  
    tiro = new PVector(p.loc.x+p.lar/2,p.loc.y+p.alt/2); //inicia o Pvector de tiro com o argumento da localização do personagem
    tiroV = new PVector(mouseX+cameraX,mouseY+cameraY); //recebe  o Pvetor da localização do mouse
    tiroV.sub(tiro); //
    tiroV.setMag(15);
  }
  
  void desenha(){
    fill(0);
    tiro.add(tiroV);
    ellipse(tiro.x-cameraX,tiro.y-cameraY,tamanho_municao,tamanho_municao);
  }
  
  void cadenciaTiro(){
  
  }
  
  
  //Acerta o tiro no inimigo?
  Inimigo acerta(){
      for(Inimigo i: inimigos){
        if((i.loc.x < tiro.x +tamanho_municao && i.loc.y < tiro.y + tamanho_municao)
        && (i.loc.x+i.lar > tiro.x -tamanho_municao && i.loc.y+i.alt > tiro.y -tamanho_municao)){
          i.vida -= dano;
          return i;
        }
      }
      return null;   
    }
    
    
    //Se colide com os blocos ou se colide com fora da tela
    boolean colide(){
      /*for(Bloco b: blocos){
         if(((b.x < tiro.x + tamanho_municao && b.y < tiro.y + tamanho_municao)
          && (b.x+b.lar > tiro.x - tamanho_municao && b.y+b.alt > tiro.y - tamanho_municao)
          ||
          (cameraX > tiro.x+tamanho_municao || cameraY > tiro.y+tamanho_municao || cameraX+width < tiro.x - tamanho_municao || cameraY+height < tiro.y+tamanho_municao)
          )){
          return true;
        }
      }*/
      return false;
    }
}
