# This file contains the logic for processing commands and selecting functions to call.
import botcommands

def response(msg):
  response_data = None  #python's version of NULL

  #split between cmd and args
  msg_data = msg.split()
  bot_cmd = msg_data[0]
  bot_args = msg_data[1:]  #python array slicing

  if bot_cmd == botcommands.TEST_CMD:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = testcmd(arg1)
    else:
      return "Test command requires 1st arg to be 'x'"

  if response_data:
    return response_data
  return "command not found: " + bot_cmd


def testcmd(arg1):
  return 'y'
