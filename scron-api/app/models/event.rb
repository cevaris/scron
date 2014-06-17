# boolean     :repeat, default: true
# datetime    :execute_at
# string      :fqdn, default: 'localhost'
# text        :command
# timestamps

class Event < ActiveRecord::Base
  before_save :default_values
  


  def parse_cron(cron_str)
    cron_arr = cron_str.strip.split(/\s+/)

    if cron_arr.size != 5
      Rails.logger.info "Cron statement is not correctly formated #{cron_str}"
      return nil
    end

    minute = cron_arr[0]
    hour   = cron_arr[1]
    day    = cron_arr[2]
    month  = cron_arr[3]
    week   = cron_arr[4]
    

  end

  def default_values
    self.execute_at ||= parse_cron(self.cron)
  end
end
