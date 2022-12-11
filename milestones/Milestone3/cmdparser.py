# cmdparser.py
# Parses incoming commands and passes arguments to the correct functions.

import botcommands
import database as db


def response(msg):
  response_data = None  #python's version of NULL

  #split between cmd and args
  msg_data = msg.split()
  bot_cmd = msg_data[0].lower()
  bot_args = msg_data[1:]  #python array slicing
  print("cmd: {} | args: {}".format(bot_cmd, bot_args)) #debug output

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
      return "Please specify the id of the event you'd like to get the attendants of: e.g. **!get_attendants <event_id>**"
  elif bot_cmd == botcommands.GET_ITEM_RESERVATIONS:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.getNumOfItemReservations(arg1)
    else:
      return "Please specify the member you wish to get the reservations for: e.g. **!get_item_reservations <member_id>**"
  elif bot_cmd == botcommands.GET_TOP_CATALOGGERS:
    response_data = db.getTopCataloggers()
  elif bot_cmd == botcommands.GET_MOST_FILLED_SHELVES:
    response_data = db.getFullestShelves()
  elif bot_cmd == botcommands.MAKE_NEW_STUDENT:
    if len(bot_args) == 3:
      arg1 = bot_args[0]
      arg2 = bot_args[1]
      arg3 = bot_args[2]
      response_data = db.makeNewStudent(arg1, arg2, arg3)
    else:
      return "Please specify the student_id, the person_id, and the school_id of the new student: e.g. **!make_new_student <student_id> <school_id> <person_id>**"
  elif bot_cmd == botcommands.MAKE_NEW_ORG_EVENT:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.makeNewOrganizedEvent(arg1)
    else:
      return "Please specify your staff_id: e.g. **!make_new_event <staff_id>**"
  elif bot_cmd == botcommands.RESERVE_EQUIPMENT:
    if len(bot_args) == 4:
      arg1 = bot_args[0]
      arg2 = bot_args[1]
      arg3 = bot_args[2]
      arg4 = bot_args[3]
      response_data = db.reserveEquipment(arg1, arg2, arg3, arg4)
    else:
      return "Please specify your member_id, the equipment_id you want to reserve, the start_time and the ending_time: e.g. **!make_new_event <member_id> <equipment_id> <start_time> <end_time>**"
  elif bot_cmd == botcommands.ADD_EVENT_TO_ALL_LIB_CALENDARS:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.addEventToAllLibCalendars(arg1)
    else:
      return "Please specify the event you want to add to the library calendars: e.g. **!add_event_to_all_calendars <event_id>**"
  elif bot_cmd == botcommands.CHECK_FORM_VALIDITY:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.checkForInvalidForms(arg1)
    else:
      return "Please specify the person_id for whom you want to check form validity: e.g. **!check_forms_validity <person_id>**"
  elif bot_cmd == botcommands.GET_NEXT_EVENT:
    response_data = db.getNextLibEvent()
  elif bot_cmd == botcommands.UPDATE_LANGUAGE_NAME:
    if len(bot_args) == 2:
      arg1 = bot_args[0]
      arg2 = bot_args[1]
      response_data = db.updateLanguageName(arg1, arg2)
    else:
      return "Please specify the language_id you want to update, and the new name you want to assign the language: e.g. **!update_language_name <language_id> <new_name>**"
  elif bot_cmd == botcommands.UPDATE_FORM_PATH:
    if len(bot_args) == 2:
      arg1 = bot_args[0]
      arg2 = bot_args[1]
      response_data = db.updateFormPath(arg1, arg2)
    else:
      return "Please specify the form_id of the form you want to update, and the path to the new pdf to be used in the future: e.g. **!update_form <form_id> <new_path>**"
  elif bot_cmd == botcommands.DELETE_LIBRARY:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.deleteLibrary(arg1)
    else:
      return "Please specify the library_id of the library you want to delete: e.g. **!delete_library <library_id>**"
  elif bot_cmd == botcommands.DELETE_WORK:
    if len(bot_args) == 1:
      arg1 = bot_args[0]
      response_data = db.deleteWork(arg1)
    else:
      return "Please specify the work_id of the work you want to delete: e.g. **!delete_work <work_id>**"
  else:
    return "command not found: " + bot_cmd
    
  if response_data:
    return response_data
  else:
    return "something went wrong with bot_cmd: " + bot_cmd


def testcmd(arg1):
  return 'y'