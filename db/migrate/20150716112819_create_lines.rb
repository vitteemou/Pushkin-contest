class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :some_line, null: false
      t.belongs_to :poem, index: true
      #t.integer :poem_id 
      #t.integer :prev_id 
      #t.integer :next_id 
      t.timestamps
    end
  end
end
