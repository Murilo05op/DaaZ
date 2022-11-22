//Beatriz Melo Sousa | Pc1960369
//Guilherme Meneses do Prado | Pc196027x
//Murilo Thiago Camargo Desiderio | PC1960342
//Will Lincoln Souza Camolesi | Pc1960202

//import ddf.minim.*;//Minim

PrintWriter output;
boolean esq, dir, cima, baixo, tiro;
Personagem p;
int acerta, vida=180, idLoja, maxZ=0, qtdMunicao = 200, qtdMunicaoMax = 200;
int ini_mortos=0;
int estado=0;
int tempo;
int transicao;
int dinheiro = 0;
int pcolete = 0;
int municao = 0;
int dano = 10;

int maxDano, maxVida, maxPcolete;
int rsVida = 25, rsColete = 50, rsDano = 200, rsPente = 100, rsMunicao = 15;
int max_zumbi=20, pspawna=9950, maxpspawna = 9950; //maximo de zumbia ao mesmo tempo, maximo de probabilidade de spawn, quanto <, mais rapido spawna
Timer dific;
Timer t;
Timer espera;

int larMapa = 7200;
int altMapa = 4480;

PImage tileset;
Map camada1;
Map camadaColisao;
PImage[] spritesZb;
PImage imgZumbi;

PImage carregaimgs;
PImage[] coracao;
PImage[] colete;
PImage[] arma;
PImage[] coin;
PImage[][] pSprites;
PImage[][] iSprites;
PImage fundo_lojaVida;
PImage fundo_lojaArma;
PImage area_lojaVida;
PImage area_lojaArma;
PImage areaLoja;
PImage telaInicio;
PImage telaObjetivo;
PImage telaControle;
PImage telaMorte;
PImage telaRanking;
PImage Mira;

String[] nomes = new String[4];
int[] pontuacao;

float cameraX,cameraY;
float margem;

ArrayList<Bloco> blocos;
ArrayList<Atira> tiros;
ArrayList<Atira> toRemove;
ArrayList<Inimigo> inimigos;
ArrayList<Inimigo> toRemoveIni;

Loja lojaVida;
Loja lojaArma;

boolean loja = false;

Botao btJogar; //botao jogar

Botao btcColete;
Botao btcVida;
Botao btcMunicao;
Botao btcDano;
Botao btcPente;

Input nome; //botao de opções
Score score;

//Minim minim;//Minim
//AudioPlayer musica;
//AudioSample gun;

void setup(){
  fullScreen();
  estado = 0;
  carregarimg();
  
  area_lojaVida = loadImage("./img/Loja/Area-loja-vida.png");
  area_lojaArma = loadImage("./img/Loja/Area-loja-arma.png");
  
  //Configurações da tela
  cameraX=0;
  cameraY=0;
  margem=350;
  
  imgZumbi = loadImage("./img/zumbiCima.png");
    spritesZb = new PImage[3];
    for(int i=0;i<3;i++){  
        spritesZb[i]=imgZumbi.get(i*64,0, 64, 64);
      }

  inimigos = new ArrayList<Inimigo>();
  tiros = new ArrayList<Atira>();
  
  toRemove = new ArrayList<Atira>(); // Remover lixos
  toRemoveIni = new ArrayList<Inimigo>();
  
  
  lojaArma = new Loja(2464-64, 4768,256,320, area_lojaArma);
  lojaVida = new Loja(5312, 1152,256,320, area_lojaVida);
  
  nome = new Input(width/5, 2 * height/5+100,3*width/5,height/8,"Digite seu nome...");
  btJogar = new Botao(width/5, 2*height/5 +200 ,3*width/5,height/8,"Jogar", 30);
  
  //Botões Loja
  btcDano = new Botao(width/2 + 224, height/2 - 81 ,128,65,"$ "+rsDano, 15);
  btcMunicao = new Botao(width/2 + 224, height/2 + 48 ,128,65,"$ "+rsMunicao, 15);
  btcPente = new Botao(width/2 + 224, height/2 + 177 , 128, 65,"$ "+rsPente, 15);
  btcColete = new Botao(width/2 + 224, height/2 + 48, 128,65,"$ "+rsColete, 15); 
  btcVida = new Botao(width/2 + 224, height/2 - 81, 128, 65,"$ "+rsVida, 15);
  
  score = new Score();
  
  nomes[3] = "";

  pontuacao = new int[4];
  
  
  //Minim
  /*minim = new Minim(this);
  musica = minim.loadFile("./som/Tension.wav");
  musica.play();
  musica.setVolume(100);
  musica.loop();
  gun = minim.loadSample("./som/Revolver Gun Shot.mp3");*/
  
  tileset = loadImage("./map/tiles.png");
  camada1 = new Map(275,190,"./map/MapNW",32,32,tileset,37);
  camadaColisao = new Map(275,190,"./map/MapColideNW",32,32,tileset,37);
  
  reseta();
    
  dific = new Timer(15000);
}


//JOGABILIDADE
void keyPressed() {
  
  //Funcionalidades do teclado em cada estado
  if(estado == 0)
  {
    if(10 == key) btJogar.destaque();
    else if(8 ==key) nomes[3] = nomes[3].replaceFirst(".$","");
    else if(estado == 0 && (key >= 32 && key <=122 )) nomes[3] = nomes[3]+key;
    nome = new Input(width/5, 2 * height/5+100,3*width/5,height/8,nomes[3]);
  }
  else if(estado == 1)
  {
    movimentacao(true);
  
    if(key == 'b' && (lojaVida.safeZone() || lojaArma.safeZone()) || key == 'B' && (lojaVida.safeZone() || lojaArma.safeZone()))
      estado = 3;
  }
  else if(estado == 3) estado = 1;
}
void keyReleased() {
  if(estado == 0 && 10 == key  && nomes[3] != "") estado =10;
  movimentacao(false);
}
void mousePressed() {
  if(estado==0 && btJogar.mouseSobre() && nomes[3] != "") btJogar.destaque();  
  
  if(estado==3 && btcColete.mouseSobre()) btcColete.destaque();
  if(estado==3 && btcDano.mouseSobre()) btcDano.destaque();
  if(estado==3 && btcVida.mouseSobre()) btcVida.destaque();
  if(estado==3 && btcPente.mouseSobre()) btcPente.destaque();
  if(estado==3 && btcMunicao.mouseSobre()) btcMunicao.destaque();
  
  if((mouseX>nome.x && mouseX<nome.x+nome.lar && mouseY>nome.y && mouseY<nome.y+nome.alt) && nomes[3] == "") nome.texto="";
  
  if (mousePressed && (mouseButton == LEFT) && estado == 1 && qtdMunicao > 0)
  {
    qtdMunicao--;
    
    gun.trigger();
    tiros.add(new Atira(p.loc.x+p.lar/2,p.loc.y+p.alt/2, dano));
    p.estado=p.ATIRANDO;
    p.tAni = new Timer(1000/(12));
    p.quadro=0;
  }
}

void mouseReleased(){
  if(estado==0 && btJogar.pressionado && btJogar.mouseSobre()){
    estado = 10;
  }
  
  //Colete
  if(estado==3 && lojaVida.dentro == true && btcColete.pressionado && btcColete.mouseSobre() && dinheiro >= rsColete)
  {
    if(pcolete+30 <= 180){
      dinheiro-=rsColete;
      pcolete = pcolete + 30;
    }  
  }
  
  //Dano
  if(estado==3 && lojaArma.dentro == true && btcDano.pressionado && btcDano.mouseSobre() && dinheiro >= rsDano)
  {
    dinheiro-=rsDano;
    dano+=5;
  }
  
  //Pente
  if(estado==3 && lojaArma.dentro == true && btcPente.pressionado && btcPente.mouseSobre() && dinheiro >= rsPente)
  {
    dinheiro-=rsPente;
    qtdMunicaoMax+=50;
  }
  
  //Municao
  if(estado==3 && lojaArma.dentro == true && btcMunicao.pressionado && btcMunicao.mouseSobre() && qtdMunicao + 5 < qtdMunicaoMax && dinheiro >= rsMunicao)
  {
    dinheiro-=rsMunicao;
    qtdMunicao+=5;
  }
  
  //Vida
  if(estado==3 && lojaVida.dentro == true && btcVida.pressionado && btcVida.mouseSobre() && dinheiro >= rsVida)
  {
    if(vida+30 <= 180){
      dinheiro-=rsVida;
      vida+=30;
    }
    else if(vida+30 < 210)
    {
      dinheiro-=rsVida;
      vida=180;
    }
  }
  btcColete.removeDestaque();
  btcDano.removeDestaque();
  btcVida.removeDestaque();
  btcMunicao.removeDestaque();
  btcPente.removeDestaque();
  btJogar.removeDestaque();
  
}
/////////////////////////////////////////

void draw(){ 
  
  switch(estado){
    case 0:
      menu();
    break;
    
    case 10:
      cursor(Mira, 3, 3);
      image(telaObjetivo, 0, 0);
      if(keyPressed)
      {
        espera = new Timer(3000);
        estado=11;
      }
    break;
    
    case 11:
      image(telaControle, 0, 0);
      if(espera.Cronometro() && keyPressed) estado=1;
     break;
    case 1:
      if(vida <= 0){
        image(telaMorte, 0, 0);
        cursor();
        score.calculaScore();
        estado=100; 
        t = new Timer(2000);
        espera = new Timer(4000);
      }
      else fase1();
    break;
    case 100:
    if(t.disparou())
    {
      dead();
      
    }
    if(espera.Cronometro() && keyPressed){ 
      estado=0;
      reseta();
    }
    break;
    
  
    case 3:
      visaoLoja();
    break; 
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
//FASES/ESTADOS

void visaoLoja() {
  background(0,0,0);
  
  for(Inimigo i: inimigos)
    i.desenha();
    
  for(Atira a: tiros)
    a.desenha(); // Desenha os projeteis

  camada1.desenha(1.0);
  camadaColisao.desenha(1.0);
  
  if(lojaVida.dentro == true)
  {
    image(fundo_lojaVida, width/2-416, height/2-268-25);
    btcColete.desenhe();
    btcVida.desenhe();
  }
  else
  {
    image(fundo_lojaArma, width/2-416, height/2-268-25);
    btcDano.desenhe();
    btcMunicao.desenhe();
    btcPente.desenhe();
  }
  
  game_interface();
  fill(255);
}

void menu() {
  background(0,0,120);
  
  image(telaInicio, 0, 0);
  nome.desenhe();
  btJogar.desenhe();
}

void dead() {    
  
  background(0, 0, 0);
  textAlign(LEFT);
  image(telaRanking, 0, 0);
  

  text(pontuacao[3], width/2, height/2-300);
  
  text(nomes[0], width/2 -60, height/2 -14);
  text(pontuacao[0], width/2 +227, height/2 -14);
  
  text(nomes[1], width/2 - 60, height/2 +97);
  text(pontuacao[1], width/2 +227, height/2 + 97);
  
  text(nomes[2], width/2 - 60, height/2 +194);
  text(pontuacao[2], width/2 +227, height/2 +194);
  
  /*text("1: " + nomes[0] + " " + pontuacao[0], width/2, height/2-200);
  text("2: " + nomes[1] + " " + pontuacao[1], width/2, height/2-160);
  text("3: " + nomes[2] + " " + pontuacao[2], width/2, height/2-120);
  text("Inimigo mortos: " + pontuacao[3], width/2, height/2-40);
  text("Tempo: " + tempo/60 + " segundos", width/2, height/2);*/
  
  
}

void fase1() {
  tempo++;
  
  /*SPAWN ALEATORIO*/
  spawna();
  background(0,0,0);
  
  camada1.desenha(1.0);
  
  for(Inimigo i: inimigos)
  {
    i.movimenta();
    i.desenha();
    
    if(i.atinge())
    {
      if(pcolete <= 0) vida--;
      else pcolete--;
    }
    
    if(i.morte())
    {
      dinheiro+=5;
      pontuacao[3]++;
      toRemoveIni.add(i);
    }
  }
  inimigos.removeAll(toRemoveIni);
  
  camadaColisao.desenha(1.0);
  
  if(dific.disparou()){
     max_zumbi+=1;
     pspawna-=25;
   }
 
  fill(0, 0, 0);
  p.movimenta(); //Movimenta o personagem
  p.desenha(); //Desenha o personagem
  
  lojaVida.desenha();
  lojaArma.desenha();
  
  if(lojaArma.safeZone())
  {
    idLoja = 3;
    loja=true;
    textAlign(CENTER);
    text(" pressione B para abrir a loja", width/2, height/2);
  }
  
  
  fill(255, 0, 0);
  
  for(Atira a: tiros)
  {
    a.desenha(); // Desenha os projeteis
    if(a.colide()) toRemove.add(a);
    
    Inimigo ini = a.acerta(); //Verifica a colisão do Tiro e se colidir adiciona o elemento para parar o tiro
    if(ini != null)
    {
      toRemove.add(a);
    }
    else if(PVector.dist(a.tiro,p.loc)>2*width) toRemove.add(a);
  }
  tiros.removeAll(toRemove); //Remove as munições colididas
  
  fill(255, 0, 0, 180-vida); //Tela vermelha conforme a vida vai abaixando
  noStroke();
  rect(0,0,width,height);

  game_interface();
}

//////////////////////////////////////////////////////////////////////////////////////////////////
//Funções n/
void movimentacao (boolean torf){
  switch(key){
    case 'a':
    case 'A':
      esq=torf;
    break;
    
    case 'd':
    case 'D':
      dir=torf;
    break; 
    
    case 'w':
    case 'W':
      cima=torf;
    break; 
    
    case 's':
    case 'S':
      baixo=torf;
    break; 
  
    case CODED:
      if(keyCode==LEFT) esq=torf;
      if(keyCode==RIGHT) dir=torf;
      if(keyCode==UP) cima=torf;
      if(keyCode==DOWN) baixo=torf;
    break;
  }
}

boolean posicaoInvalida(int x, int y, int lar, int alt)
{
    int xi,xf,yi,yf;
    
    xi= x/camadaColisao.tLar;
    xf= (x+lar-1)/camadaColisao.tLar;
    yi= y/camadaColisao.tAlt;
    yf= (y+alt-1)/camadaColisao.tAlt;
    
    if(xi<0)xi=0;
    if(xi>camadaColisao.lar-1) xi=camadaColisao.lar-1;
    if(xf<0)xf=0;
    if(xf>camadaColisao.lar-1) xf=camadaColisao.lar-1;
    
    if(yi<0)yi=0;
    if(yi>camadaColisao.alt-1) yi=camadaColisao.alt-1;
    if(yf<0)yf=0;
    if(yf>camadaColisao.alt-1) yf=camadaColisao.alt-1;
    
    for(int i=xi; i<=xf;i++){
      for(int j=yi; j<=yf; j++){
        if(camadaColisao.get(j,i)!=-1) return true;
      }
    }
    
    return false;
}


void spawna(){
  if(inimigos.size() > max_zumbi) return;
  int c;
  float zbx, zby;
  if(random(0, 10000) > pspawna)
  {
    Inimigo i;
    c=0;
    zby=cameraY-10;
    print("A");
    do
    {
      //i = new Inimigo(random(cameraX, cameraX+width),cameraY-10,48, 102, random(2.5, 5.5), spritesZb);
      zbx = random(cameraX, cameraX+width);      
      c++;
    }while(posicaoInvalida((int)zbx,(int)zby,64,64) && (c>3));
    if(c<3) inimigos.add(new Inimigo(zbx,zby,64, 64, random(3.5, 6.5), spritesZb));
    
    c=0;
    zby=cameraY+height;
    print("B");
    do
    {
      zbx = random(cameraX, cameraX+width);  
      //i = new Inimigo(random(cameraX, cameraX+width),cameraY+height,48, 102, random(2.5, 5.5), spritesZb);
      c++;
    }while(posicaoInvalida((int)zbx,(int)zby,64,64) && (c>3));
    if(c<3) inimigos.add(new Inimigo(zbx,zby,64, 64, random(3.5, 6.5), spritesZb));
    
    c=0;
    zby=cameraX-10;
    do
    {
      zbx=random(cameraY, cameraY+height);
      //i = new Inimigo(cameraX-10,random(cameraY, cameraY+height),48, 102, random(2.5, 5.5), spritesZb);
      c++;
    }while(posicaoInvalida((int)zbx,(int)zby,64,64) && (c>3));
    if(c<3) inimigos.add(new Inimigo(cameraX-10,random(cameraY, cameraY+height),64, 64, random(3.5, 6.5), spritesZb));
    
    
    c=0;
    zby=cameraX+width;
    do
    {
      zbx=random(cameraY, cameraY+height);
      //i = new Inimigo(cameraX+width,random(cameraY, cameraY+height),48, 102, random(2.5, 5.5), spritesZb);
      c++;
    }while(posicaoInvalida((int)zbx,(int)zby,64,64)&& (c>3));
    if(c<3) inimigos.add(new Inimigo(cameraX+width,random(cameraY, cameraY+height),64, 64, random(3.5, 6.5), spritesZb));
  }
}

void game_interface(){
  //coração da bia
  for(int i = 0; i < 180; i=i+30) image(coracao[0],width-50-((i/30)*32), 10);
  for(int i = -30; i < 150; i=i+30) if(vida > i+30) image(coracao[1],width-50-((i/30)*32)-32, 10);
  for(int i = 0; i <= vida; i=i+30) if(vida >= i+30) image(coracao[2],width-50-((i/30)*32), 10);
  
  //colete da bia
  for(int i = 0; i < 180; i=i+30) image(colete[1],width-50-((i/30)*32), 42);
  for(int i = 0; i < pcolete; i=i+30) image(colete[0],width-50-((i/30)*32), 42);
  
  textSize(26); 
  fill(255,255,255);
  textAlign(RIGHT);
  
  //tiro
  image(arma[0],width-180, 72);
  text(qtdMunicao + "/" + qtdMunicaoMax, width-20, 97);
  
  image(coin[0],width-100, 102);
  text(dinheiro, width-20, 122);

  /*textAlign(LEFT);
  text("Inimigo mortos: " + pontuacao[3], 10, 30);
  text("Vidas restantes: " + vida, 10, 60);*/
}

void reseta(){
  //Configurações da tela
  cameraX=0;
  cameraY=0;
  margem=350;
  max_zumbi=20;
  pspawna=maxpspawna;
  
  esq=false;
  dir=false;  
  cima=false;
  baixo=false;
  tiro=false;
  
  qtdMunicaoMax = 200;
  qtdMunicao = 200;
  t = new Timer(10000);
  tempo = 0;
  vida = 180;
  dinheiro = 0;
  pontuacao[3] = 0;
  inimigos = new ArrayList<Inimigo>();
  tiros = new ArrayList<Atira>();
  nomes[3] = "";
  nome = new Input(width/5, 2 * height/5+100,3*width/5,height/8,"Digite seu nome...");
  dinheiro = 0;
  //p = new Personagem(width*2,height, 64, 64,4.5, "./img/andando.png","./img/tiro.png");
  p = new Personagem(4384, 2560, 64, 64,4.5, "./img/andando.png","./img/tiro.png");
}

void carregarimg(){
  carregaimgs = loadImage("./img/cbia.png");
  coracao = new PImage[3];
  for(int i=0;i<3;i++) coracao[i]=carregaimgs.get(i*32, 0, 32, 32);
   
  carregaimgs = loadImage("./img/tcolete.png");
  colete = new PImage[3];
  for(int i=0;i<3;i++) colete[i]=carregaimgs.get(i*32, 0, 32, 32);
  
  carregaimgs = loadImage("./img/arma_contorno.png");
  arma = new PImage[2];
  for(int i=0;i< 2;i++) arma[i]=carregaimgs.get(i*32, 0, 32, 32);
  
  //carregaimgs = loadImage("./img/colete.png");
  carregaimgs = loadImage("./img/coin/coin_01.png");
  coin = new PImage[8];
  for(int i=0;i<8;i++) coin[i]=carregaimgs.get(i*48, 0, 48, 48);
  
  coin[0].resize(0, 22);
  
  
  fundo_lojaVida = loadImage("./img/Loja/Loja-photoshop-vida.png");
  fundo_lojaArma = loadImage("./img/Loja/Loja-photoshop-arma.png");
  area_lojaVida = loadImage("./img/Loja/Area-loja-vida.png");
  area_lojaArma = loadImage("./img/Loja/Area-loja-arma.png");
  
  telaInicio = loadImage("./img/TelaInicio.jpg");
  telaInicio.resize(width, height);
  telaMorte = loadImage("./img/TelaMorte.png");
  telaMorte.resize(width, height);
  telaRanking = loadImage("./img/TelaRanking.png");
  telaRanking.resize(width, height);
  telaObjetivo = loadImage("./img/objetivo.png");
  telaObjetivo.resize(width, height);
  telaControle = loadImage("./img/controles.png");
  telaControle.resize(width, height);
  
  Mira = loadImage("./img/Mira.png");
  Mira.resize(6, 6);
  
  
}
