class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.string :name
      t.string :icon, default: 'https://img.icons8.com/ios/512/bank-cards.png'

      t.timestamps
    end
  end
end
