require 'rails_helper'

feature 'Positions list' do
  scenario 'Candidate cannot see positions page' do
    candidate = create(:candidate)

    login_as(candidate, scope: :candidate)
    visit(positions_path)

    expect(current_path).not_to eq(positions_path)
  end
end
