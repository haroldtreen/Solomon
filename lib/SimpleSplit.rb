class SimpleSplit

  def initialize args
    @preferences_a = args[:preferences_a]
    @preferences_b = args[:preferences_b]
  end

  def start
    @results = {preferences_a: [], preferences_b: [], contested: []}

    begin     
     if @preferences_a[0] == @preferences_b[0]
        results[:contested] << @preferences_a.shift
        @preferences_b.shift
     else
        @results[:preferences_a] << @preferences_a.shift
        @results[:preferences_b] << @preferences_b.shift
        @preferences_b.delete @results[:preferences_a][-1]
        @preferences_a.delete @results[:preferences_b][-1]
     end
    end while @preferences_a.length != 0
  end

  def results
    start unless @results
    return @results  
  end
end
