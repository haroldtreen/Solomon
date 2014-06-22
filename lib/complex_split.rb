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
    end while @available.length != 0
  end

  def compare_preference
    available_a = get_available @preferences_a
    available_b = get_available @preferences_b

    if available_a[0] == available_b[0]
      if initial_stage
        @available.delete available_a[0]
        @results[:contested] << available_a[0]
      else
        feasibility_a = get_feasibility @preferences_a, available_a, @results[:preferences_a] || @preferences_a.length
        feasibility_b = get_feasibility @preferences_b, available_b, @results[:preferences_b] || @preferences_b.length
        debugger
        if feasibility_a <= stage
          @available.delete available_a[1]
          @available.delete available_b[0]
          @results[:preferences_a] << available_a[1]
          @results[:preferences_b] << available_b[0]
          @stage += 1
        elsif feasibility_b <= stage
          @available.delete available_b[1]
          @available.delete available_a[0]
          @results[:preferences_b] << available_b[1]
          @results[:preferences_a] << available_a[0]
          @stage += 1
        end
      end

    else
      @available.delete available_a[0]
      @available.delete available_b[0]
      @results[:preferences_a] << available_a[0]
      @results[:preferences_b] << available_b[0]
      @stage += 1
    end
  end

  def get_first_available preferences
    preferences.each do |preference|
     return preference if @available.include? preference 
    end
  end

  def get_available_preferences preferences
    preferences.select{|preference| @avialable.include? preference}
  end

  def get_feasibility preferences, available, results
    index = preferences.index available[1]
    results_length = results.length || 0
    index - results_length
  end
end