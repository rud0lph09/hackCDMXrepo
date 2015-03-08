import json
import urllib2
from twilio.rest import TwilioRestClient
i = 1
memo = "+520445519660929"
yo = "+520445521061342"
alonso = "+520445514781420" 
def notif(number):
# Your Account Sid and Auth Token from twilio.com/user/account
  account_sid = "AC5b5e46b16de29eed890699a1230e26a9"
  auth_token  = "70c4ad4a988de702986ad5574f3a147a"
  client = TwilioRestClient(account_sid, auth_token)
 
  message = client.messages.create(body="Test",
      to=number,    # Replace with your phone number
      from_="+16615284910") # Replace with your Twilio numberbody="Prueba, avisame si funciono", 
  print message.sid

#print  jsonData['status']
while i == 1 :
  httpResponse = urllib2.urlopen('https://warm-depths-9978.herokuapp.com/message/last.json') # 
  jsonString = httpResponse.read() # 

  jsonData = json.loads(jsonString) # 
  print jsonData['message']
  if jsonData['message'] == 'pedo':
    notif(yo)
    notif(memo)
    notif(alonso)
  pass
  pass