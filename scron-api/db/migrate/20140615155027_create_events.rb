class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.name        :name

      t.boolean     :repeat

      t.datetime    :execution
      t.boolean     :executed

      t.string      :server
      t.string      :path


      t.timestamps
    end
  end
end
