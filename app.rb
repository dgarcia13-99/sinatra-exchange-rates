require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  access_exchange_key= ENV.fetch("EXCHANGE_RATE_KEY")
  currencies_url= HTTP.get("https://api.exchangerate.host/list?access_key=#{access_exchange_key}")
  currency_data=JSON.parse(currencies_url)
  currencies_hash=currency_data.fetch("currencies")
  @list_of_currencies=currencies_hash.keys

  erb(:home)
end

get("/:currency") do
  access_exchange_key= ENV.fetch("EXCHANGE_RATE_KEY") 
  currencies_url= HTTP.get("https://api.exchangerate.host/list?access_key=#{access_exchange_key}")
  currency_data=JSON.parse(currencies_url)
  currencies_hash=currency_data.fetch("currencies")
  @list_of_currencies=currencies_hash.keys

  @individual_currency = params.fetch("currency")
  erb(:currency_page)
end

get("/:currency/:other_currency") do
@first_currency = params.fetch("currency")
@second_currency = params.fetch("other_currency")
access_exchange_key= ENV.fetch("EXCHANGE_RATE_KEY") 
conversion_url= HTTP.get("https://api.exchangerate.host/convert?from=#{@first_currency}&to=#{@second_currency}&amount=1&access_key=#{access_exchange_key}")
conversion_data=JSON.parse(conversion_url)
@conversion_amount=conversion_data.fetch("result")
erb(:conversion_page)

end
