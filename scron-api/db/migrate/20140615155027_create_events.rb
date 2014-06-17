class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.boolean     :repeat, default: true
      t.datetime    :execute_at
      t.string      :fqdn, default: 'localhost'
      t.text        :command # Can be path to script, or sequence of piped bash commands   

      t.timestamps
    end
  end
end
