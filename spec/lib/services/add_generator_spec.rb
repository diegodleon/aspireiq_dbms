require 'spec_helper'

describe Services::AddGenerator do
  
  context 'when additioning to first level entities' do
    let(:parent_id) { nil }
    let(:mutation) { {'foo' => 'bar'} }
    let(:src_array) { [] }
    let(:type) { Services::StatementGenerator::POSTS_IDENTIFIER }
    let(:expected_hash) {{'posts'=> [{'foo' => 'bar'}]}}
    
    it 'generates a correct POSTS entry' do
      result_hash = described_class.new(mutation, type, src_array, parent_id).generate
      expect(result_hash).to eq(expected_hash)
    end

  end

  context 'when additioning to second level entities' do
    let(:parent_id) { 1 }
    let(:mutation) { {'foo' => 'bar'} }
    let(:src_array) { [{'_id' => 1, 'mentions' => []}] }
    let(:type) { Services::StatementGenerator::MENTIONS_IDENTIFIER }
    let(:expected_hash) {{'posts.0.mentions'=> [{'foo' => 'bar'}]}}
    
    it 'generates a correct POSTS entry' do
      result_hash = described_class.new(mutation, type, src_array, parent_id).generate
      expect(result_hash).to eq(expected_hash)
    end

  end

end
