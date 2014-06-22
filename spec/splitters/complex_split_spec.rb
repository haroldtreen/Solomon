require 'spec_helper'

describe ComplexSplit do
  context "complex_split" do
    it "should divide a [1] [1] dispute successfully" do
      
      result = {preferences_a: [], preferences_b: [], contested: [1]}
      preferences = {preferences_a: [1], preferences_b: [1], itemList: [1]}
      dispute = ComplexSplit.new preferences
      expect(dispute.results).to eq result
    end

    it "should divide a [1,2] [2,1] dispute successfully" do
      preferences = {preferences_a: [1,2], preferences_b: [2,1], itemList: [1,2]}
      dispute = ComplexSplit.new preferences
      result = {preferences_a: [1], preferences_b: [2], contested: []}
      expect(dispute.results).to eq result
    end

    it "should divide a [1,2] [1,2] dispute successfully" do
      preferences = {preferences_a: [1,2], preferences_b: [1,2], itemList: [1,2]}
      dispute = ComplexSplit.new preferences
      result = {preferences_a: [], preferences_b: [], contested: [1,2]}
      expect(dispute.results).to eq result
    end

    it 'should divide a [1,2,3,4] [2,3,4,1] dispute successfuly' do
      preferences = {preferences_a: [1,2,3,4], preferences_b: [2,3,4,1], itemList: [1,2,3,4]}
      dispute = ComplexSplit.new preferences
      result = {preferences_a: [1,3], preferences_b: [2,4], contested: []}
      expect(dispute.results).to eq result
    end

    it 'should divide a [1,2,3,4,5,6] [2,3,5,4,1,6] dispute successfuly' do
      preferences = {preferences_a: [1,2,3,4,5,6], preferences_b: [2,3,5,4,1,6], itemList: [1,2,3,4,5,6]}
      dispute = ComplexSplit.new preferences
      result = {preferences_a: [1,3], preferences_b: [2,5], contested: [4,6]} 
      expect(dispute.results).to eq result
    end
  end
 
end