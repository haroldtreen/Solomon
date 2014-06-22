class SimpleSplit

  def initialize args
    @preferencesA = args[:preferencesA]
    @preferencesB = args[:preferencesB]
    @itemList = args[:itemList]

  end

  def start
    size = @preferencesA.size
    @source = {preferencesA: @preferencesA.dup, preferencesB: @preferencesB.dup,}
    @results = {preferencesA: [], preferencesB: [], contested: []}

    begin
     
     if @preferencesA[0] == @preferencesB[0]
        results[:contested] << @preferencesA.shift

     else
        @results[:preferencesA] << @preferencesA.shift
        @results[:preferencesB] << @preferencesB.shift
        @preferencesB.delete @results[:preferencesA][-1]
        @preferencesA.delete @results[:preferencesB][-1]
     end
    
   end while @preferencesA.length != 0
  end

  def results
    start unless @results
    return @results  
  end  
end
