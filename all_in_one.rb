require 'rubygems'
require 'twilio-ruby'
require 'open-uri'
require 'json'


#Defined constant for your Spreadsheet ID
SPREADSHEET_ID = '1ffnWnDcoiMG3NYxPmRNtYDKFZg4VapLcg_xPdRk_vxw'


#URL for my to-do list converted into JSON
def spreadsheet_url
	"https://spreadsheets.google.com/feeds/list/1ffnWnDcoiMG3NYxPmRNtYDKFZg4VapLcg_xPdRk_vxw/od6/public/values?alt=json"
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
account_sid = 'AC765d7e39286e78bf171516cecc9068da'
auth_token = '4fecd2e23f5515db45059d19427ddd88'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

@client.account.messages.create({
  :from => '17342344318',
  :to => '+15174491114', 
  :body => items_from_to_do_list,
  })