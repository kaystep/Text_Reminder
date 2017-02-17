require 'rubygems'
require 'twilio-ruby'
require 'open-uri'
require 'json'


#Defined constant for your Spreadsheet ID
SPREADSHEET_ID = 'put your spreadsheet ID here'


#URL for my to-do list converted into JSON
def spreadsheet_url
	"Put your spreadsheet url in JSON form here"
end

#Open my Google Doc and parse through the data
def data_from_to_do_list
	file = open(spreadsheet_url).read
	JSON.parse(file)
end

#iterate through the google spreadsheet and pull out the to do list items
def items_from_to_do_list
	list = {}
	data_from_to_do_list['feed']['entry'].each do |entry|
		priority = entry['gsx$priority']['$t']
		todo = entry['gsx$todo']['$t']
		list[todo] = priority
	end
	list
end


# put your own credentials here
account_sid = 'your account sid for twilio'
auth_token = 'your account token for twilio'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@client.account.messages.create({
  :from => 'twilio #',
  :to => 'Personal Cell #', 
  :body => items_from_to_do_list,
  })
