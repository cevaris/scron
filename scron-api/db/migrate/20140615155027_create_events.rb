class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.name        :name

      t.boolean     :repeat

      t.datetime    :execution
      t.boolean     :executed
      

      t.timestamps
    end
  end
end
