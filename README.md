# Text_Reminder

This is a ruby script that I host on Heroku to send daily text reminders to my phone

It pulls data off of a googlespreadsheet that I can edit in reaily time

Then twice a day it parses through the data and uses Twillio to send reminders to my phone.

For example if the spreadsheet had (take vitamins, email professor, and call mom) this would get texted to my phone once in the morning
and once in the evening. Basically the script is just to remind me to do any important tasks before I go to bed
