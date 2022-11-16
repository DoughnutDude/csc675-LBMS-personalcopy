# This file contains the logic for processing commands and selecting functions to call.

def response(msg):
  response_data = None #python version of NULL

  #split between cmd and args
  msg_data = msg.split()
  bot_cmd = msg_data[0]
  bot_args = msg_data[1:] #python array slicing

  if bot_command in bot_commands.NUM_OF_EMPLOYEES:
    response_data = numOfEmployees(companyName)