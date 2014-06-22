class HardSplit
  
  # more complicated implementation of the division algorithm
  # args is a hash of 3 different parameters
  # - preferencesA
  # - preferencesB
  # - itemList
  #
  def initialize args

    @preferencesA = args[:preferencesA]
    @preferencesB = args[:preferencesB]
    @itemList = args[:itemList]

    @contested = []
    @resultA = []
    @resultB = []
    
  end

  def stage_zero 

    @resultA = @preferencesA.dup
    @resultB = @preferencesB.dup

    size = @preferencesA.size

    (0...size).each do |n|
      if @preferencesA[n] == @preferencesB[n]
        @contested << @preferencesA[n]

        @resultA.delete(@preferencesA[n])
        @resultB.delete(@preferencesA[n])


        return {A: @resultA, B: @resultB, Contested: @contested}

      end
    end

  end

end
