# Scron (Scalable Cron)

## Goals
- API based cron job
- Cross platform, start with Python
- Small to large distributed projects


### Ideas
- Schedule code, scripts, anything
- Priority based
- Decentralized

## API

### Code


	# Schedule a function to be invoked at given time
	# time: int  - time to be executed
	# func:f()   - function to be executed
	# params:{}  - params to be passed to function
	# repeat:int - seconds to be executed again
	def schedule(time, function, params={}, repeat=False)
	
	# List all scheduled funtions
	def list()

## RESTful/Remote


	POST /api/v1/schedule
	{
		'time'      : 100,
		'function'  : '/path/to/function',
		'params'    : CSV list of strings,
		'repeat'    : 20,
	}
	

