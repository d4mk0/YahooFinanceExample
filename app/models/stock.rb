class Stock < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :user_id

  def history_for(options = {})
    YahooFinance::Client.new.historical_quotes(
      name,
      {
        start_date: Time.now - options[:period].to_i,
        end_date: Time.now,
        period: options[:type]
      }
    ).map{|quote| [quote[:trade_date], quote[:open]]}
  end
end
