class Score {
  
  public void calculaScore() {
    BufferedReader reader = createReader("ranking.txt");
    String line = null;
    try
    {
      line = reader.readLine();
      nomes[0] = line;
      line = reader.readLine();
      pontuacao[0] = int(line);
      
      line = reader.readLine();
      nomes[1] = line;
      line = reader.readLine();
      pontuacao[1] = int(line);
      
      line = reader.readLine();
      nomes[2] = line;
      line = reader.readLine();
      pontuacao[2] = int(line);
      
      reader.close();
      
      println(nomes[0] + " " + pontuacao[0]);
      println(nomes[1] + " " + pontuacao[1]);
      println(nomes[2] + " " + pontuacao[2]);
      
      
      
      output = createWriter("ranking.txt");
      if(pontuacao[3] > pontuacao[2])
      {
        if(pontuacao[3] > pontuacao[1])
        {
          if(pontuacao[3] > pontuacao[0])
          {
            output.println(nomes[3]);
            output.println(pontuacao[3]);
            
            output.println(nomes[0]);
            output.println(pontuacao[0]);
            
            output.println(nomes[1]);
            output.println(pontuacao[1]);
          }
          else
          {
            output.println(nomes[0]);
            output.println(pontuacao[0]);
            
            output.println(nomes[3]);
            output.println(pontuacao[3]);
            
            output.println(nomes[1]);
            output.println(pontuacao[1]);
          }
        }
        else
        {
          output.println(nomes[0]);
          output.println(pontuacao[0]);
            
          output.println(nomes[1]);
          output.println(pontuacao[1]);
            
          output.println(nomes[3]);
          output.println(pontuacao[3]);
        }
        
     }
     else
     {
       output.println(nomes[0]);
       output.println(pontuacao[0]);
            
       output.println(nomes[1]);
       output.println(pontuacao[1]);
            
       output.println(nomes[2]);
       output.println(pontuacao[2]);
     }
     output.flush();
     output.close(); // Finishes the file
    }
    catch (IOException e) {
    e.printStackTrace();
   }
  }
}
