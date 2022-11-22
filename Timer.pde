class Timer{
  private long tempoAtual;
  private long ultimoTempo;
  public int intervalo;
  private long tini;
  
  public Timer(int intervalo){
    this.intervalo=intervalo;
    ultimoTempo= millis();
    tini=ultimoTempo;
  }
  
  public boolean disparou(){
    tempoAtual=millis();
    if(tempoAtual-ultimoTempo>intervalo){
      ultimoTempo=tempoAtual+intervalo;
      return true;
    }
    return false;
  } 
  
  public long tempoPassou(){
    tempoAtual=millis();
    if(tempoAtual-tini<intervalo)
    return tempoAtual-tini;
    return intervalo;
  }  
  
   public boolean Cronometro(){
    tempoAtual=millis();
    if(tempoAtual-tini >=  intervalo) return true;
    
    return false;
  }  
}



/*class Timer{
  private long tempoAtual;
  private long ultimoTempo;
  private int intervalo;
  
  public Timer(int intervalo){
    this.intervalo=intervalo;
    ultimoTempo= millis();
  }
  
  public boolean disparou(){
    tempoAtual=millis();
    if(tempoAtual-ultimoTempo>intervalo){
      ultimoTempo=ultimoTempo+intervalo;
      return true;
    }
    return false;
  }      
}*/
