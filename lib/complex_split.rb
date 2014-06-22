class ComplexSplit

  def initialize preferences
    @preferences_a = preferences[:preferences_a]
    @preferences_b = preferences[:preferences_b]
    @available = preferences[:preferences_b].dup
    @stage = 0
  end

  def results
    start unless @results
    return @results  
  end

  def start
    @results = {preferences_a: [], preferences_b: [], contested: []}

    begin     
     compare_preference
      if @available.length == 1
        @results[:contested] << @available[0] if @available.length ==1
        @available.delete_at 0
      end
    end while @available.length != 0

  end

  def compare_preference
    available_a = get_available_preferences @preferences_a
    available_b = get_available_preferences @preferences_b

    if available_a[0] == available_b[0]
      if @stage == 0
          allocate_contested available_a[0]
      else
        feasibility_a = get_feasibility @preferences_a, available_a, @results[:preferences_a] || @preferences_a.length
        feasibility_b = get_feasibility @preferences_b, available_b, @results[:preferences_b] || @preferences_b.length
        if feasibility_a <= @stage
          allocate_item available_a[1], @results[:preferences_a]
          allocate_item available_b[0], @results[:preferences_b]
          @stage += 1
        elsif feasibility_b <= @stage
          allocate_item available_a[0], @results[:preferences_a]
          allocate_item available_b[1], @results[:preferences_b]
          @stage += 1
        else
          allocate_contested available_a[0]
        end
      end

    else
      allocate_item available_a[0], @results[:preferences_a]
      allocate_item available_b[0], @results[:preferences_b]
      @stage += 1
    end
  end

  def get_available_preferences preferences
    preferences.select{|preference| @available.include? preference}
  end

  def get_feasibility preferences, available, results
    index = preferences.index available[1]
    results_length = results.length || 0
    index - results_length
  end

  def allocate_item item, result
    @available.delete item
    result << item 
  end

  def allocate_contested item
    @available.delete item
    @results[:contested] << item
  end
end