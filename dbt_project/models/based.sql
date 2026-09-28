select
	rate_date "Дата",
	currency_name "Название валюты",
	rate "Курс к рублю",
	max(rate) over(partition by c.currency_name) "Максимальное значение",
	avg(rate) over(partition by c.currency_name) "Среднее",
	min(rate) over(partition by c.currency_name) "Минимальное значение"
from staging.rates r
	join staging.currencies c on c.char_code = r.char_code
ORDER BY c.currency_name DESC
