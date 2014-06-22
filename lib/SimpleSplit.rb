class SimpleSplit

  def initialize args
    @preferencesA = args[:preferencesA]
    @preferencesB = args[:preferencesB]
    @itemList = args[:itemList]
  end

  def start
    size = @preferencesA.size
    results = {preferencesA: [], preferencesB: [], contested: []}
    
    begin
     
     if @preferencesA[0] == @preferencesB[0]
        results[:contested] << @preferencesA[0]
        @preferencesA.delete results[:contested][-1]
        @preferencesB.delete results[:contested][-1]
     else
        results[:preferencesA] << @preferencesA[0]
        results[:preferencesB] << @preferencesB[0]
        @preferencesA.delete results[:preferencesA][-1]
        @preferencesB.delete results[:preferencesA][-1]
        @preferencesA.delete results[:preferencesB][-1]
        @preferencesB.delete results[:preferencesB][-1]
     end
    
   end while @preferencesA.length != 0

   return results
  end
  
end
