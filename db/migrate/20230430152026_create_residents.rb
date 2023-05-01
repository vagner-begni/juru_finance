class CreateResidents < ActiveRecord::Migration[7.0]
  def change
    create_table :residents do |t|
      t.string :name
      t.string :cpf
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
