class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.name        :name
      t.boolean     :repeat
      t.datetime    :execute_at
      t.text        :command # Can be path to script, or sequence of piped bash commands   

      t.timestamps
    end
  end
end
