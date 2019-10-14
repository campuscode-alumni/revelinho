class AddCpfToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column :candidates, :cpf, :string
  end
end
