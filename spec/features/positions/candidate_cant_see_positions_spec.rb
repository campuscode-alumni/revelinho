require 'rails_helper'

feature 'Positions list' do
  scenario 'Candidate cannot see positions page' do
    candidate = create(:candidate)

    login_as(candidate, scope: :candidate)
    visit(positions_path)

    expect(current_path).to eq(root_path)
  end
end
