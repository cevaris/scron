class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.boolean     :repeat, default: true

      t.datetime    :execute_at # Computed, next time to execute
      t.string      :cron    # Backward comapaitble cron statement, ex. 1 0 * * *
      t.text        :command # Can be path to script, or sequence of piped bash commands   

      t.timestamps
    end

    add_index :events, :execute_at, name: 'execute_at_index'
  end
end
