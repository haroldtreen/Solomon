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
     
     if @source[:preferencesA][0] == @source[:preferencesB][0]
        results[:contested] << @source[:preferencesA].shift
        @source[:preferencesB].shift

     else
        @results[:preferencesA] << @source[:preferencesA].shift
        @results[:preferencesB] << @source[:preferencesB].shift
        @source[:preferencesB].delete @results[:preferencesA][-1]
        @source[:preferencesA].delete @results[:preferencesB][-1]
     end
    
   end while @preferencesA.length != 0
  end

  def results
    start unless @results
    return @results  
  end  
end
