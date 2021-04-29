class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.user_id :integer

      t.timestamps
    end
  end
end
