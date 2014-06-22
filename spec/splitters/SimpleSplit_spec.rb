require 'spec_helper'

describe SimpleSplit do
  context "simple_split" do
    it "should divide a [1] [1] dispute successfully" do
      preferences = {preferencesA: [1], preferencesB: [1], itemList: [1]}
      dispute = SimpleSplit.new preferences
      result = {preferencesA: [], preferencesB: [], contested: [1]}
      expect(dispute.results).to eq result
    end
    it "should divide a [1,2] [2,1] dispute successfully" do
      preferences = {preferencesA: [1,2], preferencesB: [2,1], itemList: [1,2]}
      dispute = SimpleSplit.new preferences
      result = {preferencesA: [1], preferencesB: [2], contested: []}
      expect(dispute.results).to eq result
    end
    it "should divide a [1,2] [1,2] dispute successfully" do
      preferences = {preferencesA: [1,2], preferencesB: [1,2], itemList: [1,2]}
      dispute = SimpleSplit.new preferences
      result = {preferencesA: [], preferencesB: [], contested: [1,2]}
      expect(dispute.results).to eq result
    end
    it 'should divide a [1,2,3,4] [2,3, 4,1] dispute successfuly' do
      preferences = {preferencesA: [1,2,3,4], preferencesB: [2,3,4,1], itemList: [1,2,3,4]}
      dispute = SimpleSplit.new preferences
      result = {preferencesA: [1], preferencesB: [2], contested: [3,4]} 
      expect(dispute.results).to eq result
    end
    it 'should divide a [1,2,3,4,5,6] [2,3,5,4,1,6] dispute successfuly' do
      preferences = {preferencesA: [1,2,3,4,5,6], preferencesB: [2,3,5,4,1,6], itemList: [1,2,3,4,5,6]}
      dispute = SimpleSplit.new preferences
      result = {preferencesA: [1,4], preferencesB: [2,5], contested: [3,6]} 
      expect(dispute.results).to eq result
    end
  end
end
