# cmdparser.py
# Parses incoming commands and passes arguments to the correct functions.

import botcommands
import database as db


def response(msg):
  response_data = None  #python's version of NULL

  #split between cmd and args
  msg_data = msg.split()
  bot_cmd = msg_data[0]
  bot_args = msg_data[1:]  #python array slicing
  print("cmd: {} | args: {}".format(bot_cmd, bot_args))

  if bot_cmd == botcommands.TEST_CMD:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = testcmd(arg1)
    else:
      return "Test command requires 1st arg"
  elif bot_cmd == botcommands.GET_LIB_ROOM_RESERVATIONS:
    response_data = db.getNumOfReservableRoomsPerLibrary()
  elif bot_cmd == botcommands.GET_CONTRIBUTIONS:
    response_data = db.getContributions()
  elif bot_cmd == botcommands.GET_ATTENDANTS:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.getNumOfMultiMemberAttendants(arg1)
    else:
      return "Please specify the id of the event you'd like to get the attendants of: e.g. '!get_attendants 1'"
  elif bot_cmd == botcommands.GET_ITEM_RESERVATIONS:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.getNumOfItemReservations(arg1)
    else:
      return "Please specify the member you wish to get the reservations for: e.g. '!get_item_reservations 123456789'"
  elif bot_cmd == botcommands.GET_TOP_CATALOGGERS:
    response_data = db.getTopCataloggers()
  elif bot_cmd == botcommands.GET_MOST_FILLED_SHELVES:
    response_data = db.getFullestShelves()
  else:
    return "command not found: " + bot_cmd
    

  if response_data:
    return response_data
  else:
    return "something went wrong with bot_cmd: " + bot_cmd


def testcmd(arg1):
  return 'y'