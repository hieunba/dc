require 'rails_helper'

RSpec.describe UnitsHelper do
  describe 'unit_name_from_key' do
    let!(:unit) { create(:unit, name: 'The Unit', key: 'thekey') }

    it 'returns the unit name for the given key' do
      expect(helper.unit_name_from_key('thekey')).to eq 'The Unit'
    end

    it 'returns nil of the unit does not exist' do
      expect(helper.unit_name_from_key('notakey')).to be_nil
    end
  end
end