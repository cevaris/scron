# boolean     :repeat, default: true
# datetime    :execute_at
# string      :fqdn, default: 'localhost'
# text        :command
# timestamps

class Event < ActiveRecord::Base
  before_save :default_values

  def next_execution(cron_str)
    cron_arr = cron_str.strip.split(/\s+/)

    if cron_arr.size != 5
      Rails.logger.info "Cron statement is not correctly formated #{cron_str}"
      return nil
    end

    minute = cron_arr[0]
    hour   = cron_arr[1]
    day    = cron_arr[2]
    month  = cron_arr[3]
    week   = cron_arr[4] # Not used, just run daily
    Time.new(Time.now.year, month, day, hour, minute)
  end

  def default_values
    if self.cron
      self.execute_at ||= next_execution(self.cron)
    end
  end
end
