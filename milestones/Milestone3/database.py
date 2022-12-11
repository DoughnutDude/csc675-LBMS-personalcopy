# database.py
# Handles all the methods interacting with the database of the application.

import os
import pymysql.cursors

db_host = os.environ['DB_HOST']
db_username = os.environ['DB_USER']
db_password = os.environ['DB_PASSWORD']
db_name = os.environ['DB_NAME']


def connect():
  try:
    conn = pymysql.connect(host=db_host,
                          port=3306,
                          user=db_username,
                          password=db_password,
                          db=db_name,
                          charset="utf8mb4",
                          cursorclass=pymysql.cursors.DictCursor,
                          ssl={"fake_flag_to_enable_tls": True}) #added ssl requirement for microsoft azure database connection
    print("Bot connected to database {}".format(db_name))
    return conn
  except:
    print(
      "Bot failed to create a connection with your database because your secret environment argss "
      + "(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) are not set".format(db_name))
    print("\n")


def getNumOfReservableRoomsPerLibrary():
  try: 
    connection = connect()
    if connection:
      sql = """
          SELECT l.name AS "Library", SUM(IF(rReservation.room_fk IS NULL, 1, 0)) AS UnreservedReservableRooms, COUNT(*) AS "Total Reservable Rooms"
          FROM ReservableRoom rRoom
          LEFT JOIN RoomReservation rReservation ON rReservation.room_fk = rRoom.reservable_room_id
          JOIN Room r ON r.room_id = rRoom.room_fk
          JOIN Floor f ON f.floor_id = r.floor_fk
          JOIN Library l ON l.library_id = f.library_fk
          GROUP BY l.name
          HAVING UnreservedReservableRooms > SUM(IF(rReservation.room_fk IS NOT NULL, 1, 0));"""
      #args = (company_name)
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Total Rooms"] = row.pop('Total Reservable Rooms')
        row["Unreserved Rooms"] = row.pop('UnreservedReservableRooms')
      print(results)
      if results:
        return results
      return "no data" 
  except Exception as e: 
    print(e)
    return "Failed to retrieve reservable rooms"
  

def getContributions():
  try: 
    connection = connect()
    if connection:
      sql = """
          SELECT i.title AS "Instance", w.title AS "Work", COUNT(c.contribution_id) AS numOfContributions
          FROM Work w
          JOIN Instance i ON i.work_fk = w.work_id
          JOIN Contribution c ON c.work_fk = w.work_id
          GROUP BY i.title, w.title
          HAVING numOfContributions > 1;"""
      #args = (company_name)
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Work Title"] = row.pop('Work')
        row["Version Title"] = row.pop('Instance')
        row["Number of Contributing Agents"] = row.pop('numOfContributions')
      print(results)
      if results:
        return results
      return "no data" 
  except Exception as e: 
    print(e)
    return "Failed to retrieve contributions"


def getNumOfMultiMemberAttendants(arg1):
  try: 
    connection = connect()
    if connection:
      sql = """
		      SELECT p.name AS "Attendant Name", COUNT(m.member_id) numOfLibraries
      		FROM Attendance a
      		JOIN Person p ON p.person_id = a.attendant_fk
          JOIN Membership m ON m.person_fk = p.person_id
      		WHERE a.org_event_fk = %s
          GROUP BY p.name
          HAVING numOfLibraries > 1;"""
      args = (arg1)
      cursor = connection.cursor()
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Number of Library Memberships"] = row.pop('numOfLibraries')
      print(results)
      if results:
        return results
      return "no multi member attendants found for event #" + arg1 
  except Exception as e: 
    print(e)
    return "Failed to retrieve attendants"


def getNumOfItemReservations(arg1):
  try: 
    connection = connect()
    if connection:
      sql = """
		      SELECT ir.member_fk AS "Member ID", ir.item_fk AS "Item Call #", ir.start, ir.end
		      FROM ItemReservation ir
          WHERE ir.member_fk = %s;"""
      args = (arg1)
      cursor = connection.cursor()
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Call Number of Item"] = row.pop('Item Call #')
        row["Start of Reservation"] = row.pop('start')
        row["End of Reservation"] = row.pop('end')
      print(results)
      if results:
        return results
      return "no item reservations found for member #" + arg1 
  except Exception as e: 
    print(e)
    return "Failed to retrieve item reservations"


def getTopCataloggers():
  try: 
    connection = connect()
    if connection:
      sql = """
		      SELECT p.name AS "Catalogger Name", COUNT(i.catalogger_fk) AS numOfItemsCatalogued
          FROM Item i
          JOIN Staff s ON s.staff_id = i.catalogger_fk
          JOIN Membership m ON m.member_id = s.member_fk
          JOIN Person p ON p.person_id = m.person_fk
          GROUP BY p.name
          HAVING numOfItemsCatalogued > 4
          ORDER BY numOfItemsCatalogued DESC;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Number of Items Catalogued"] = row.pop('numOfItemsCatalogued')
      print(results)
      return results 
  except Exception as e: 
    print(e)
    return "Failed to retrieve cataloggers"


def getFullestShelves():
  try: 
    connection = connect()
    if connection:
      sql = """
          SELECT s.name AS "Shelf Name", r.name AS "Room Name", COUNT(p.call_number) AS numOfItems
          FROM Shelf s
          JOIN Bookstack b ON b.bookstack_id = s.bookstack_fk
          JOIN Room r ON r.room_id = b.room_fk
          JOIN PhysicalItem p ON p.shelf_fk = s.shelf_id
          GROUP BY s.name, r.name;"""
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Number of Items"] = row.pop('numOfItems')
      print(results)
      return results 
  except Exception as e: 
    print(e)
    return "Failed to retrieve shelves"
    

def makeNewStudent(student_id, school_id, person_id):
  try: 
    connection = connect()
    if connection:
      sql = """
          INSERT INTO Student (`student_id`, `school_fk`, `person_fk`, `member_fk`)
          VALUES (%s, %s, %s, %s);
          """
      cursor = connection.cursor()
      args = (student_id, school_id, person_id, student_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(f"results {results}")
      return "New student membership created successfully"
  except Exception as e: 
    print(e)
    return "Failed to create new student membership. Please check that the entered school_id and person_id are correct"


def makeNewOrganizedEvent(staff_id):
  try: 
    connection = connect()
    if connection:
      sql = """
          INSERT INTO OrganizedEvent (`organizer_fk`, `lib_event_fk`)
          VALUES (%s, 0);
          """
      cursor = connection.cursor()
      args = (staff_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(f"results {results}")
      return "New organized event created successfully"
  except Exception as e: 
    print(e)
    return "Failed to create new organized event. Please check that the entered staff_id is correct."


def reserveEquipment(member_id, equipment_id, start_time, end_time):
  try: 
    connection = connect()
    if connection:
      sql = """
          CALL attemptEquipmentReservation(%s, %s, %s, %s);
          """
      cursor = connection.cursor()
      args = (member_id, equipment_id, start_time, end_time)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(f"results {results}")
      return "New equipment reservation created successfully"
  except Exception as e: 
    print(e)
    return "Failed to create new equipment reservation. Please check that the entered datetime values for start and end are the correct format: **YYYY-MM-DD HH:MM:SS**, and check that the entered values member_id and equipment_id are correct"


def addEventToAllLibCalendars(event_id):
  try: 
    connection = connect()
    if connection:
      sql = """
          CALL addCalendarEventToAll(%s);
          """
      cursor = connection.cursor()
      args = (event_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(f"results {results}")
      return "Event successfully added event to all libraries' calendars"
  except Exception as e: 
    print(e)
    return "Failed to add event to library calendars. Please check that the entered library event is correct"


def checkForInvalidForms(person_id):
  try: 
    connection = connect()
    if connection:
      sql = """
          SELECT checkForInvalidForms(%s) AS "Number of Invalid Forms";
          """
      cursor = connection.cursor()
      args = (person_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(results)
      if results:
        return results
      return "no data" 
  except Exception as e: 
    print(e)
    return "Failed to check invalid forms. Please check that the entered person_id is correct"


def getNextLibEvent():
  try: 
    connection = connect()
    if connection:
      sql = """
          SELECT getNextLibEvent() AS "ID of Next Upcoming Event";
          """
      cursor = connection.cursor()
      cursor.execute(sql)
      connection.commit()
      results = cursor.fetchall()
      print(results)
      if results:
        return results
      return "no data" 
  except Exception as e: 
    print(e)
    return "Failed to retrieve the next upcoming library event"


def updateLanguageName(language_id, new_name):
  try: 
    connection = connect()
    if connection:
      cursor = connection.cursor()
      sql = """
          SELECT name FROM  Language WHERE language_id = %s;
          """
      args = (language_id)
      cursor.execute(sql, args)
      connection.commit()
      old_name = cursor.fetchall()[0]['name']
      print(f"old_name {old_name}")#debug output
      sql = """
          UPDATE Language l
          JOIN Format f ON f.language_fk = l.language_id
          SET f.name = REPLACE(f.name, %s, %s), l.name = %s
          WHERE l.language_id = %s;
          """
      args = (old_name, new_name, new_name, language_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(results)
      return "Successfully updated language name"
  except Exception as e: 
    print(e)
    return "Failed to update the name of the language. Please check that the entered library_id is correct"


def updateFormPath(form_id, new_path):
  try: 
    connection = connect()
    if connection:
      cursor = connection.cursor()
      sql = """
          UPDATE Form f
          JOIN CompleteForm cf ON cf.form_fk = f.form_id
          SET f.form_location = %s, cf.is_valid = FALSE
          WHERE f.form_id = %s;
          """
      args = (new_path, form_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.fetchall()
      print(results)
      return "Successfully updated form"
  except Exception as e: 
    print(e)
    return "Failed to update the form. Please check that the entered form_id is correct"


def deleteLibrary(library_id):
  try: 
    connection = connect()
    if connection:
      cursor = connection.cursor()
      sql = """
          DELETE FROM Library
          WHERE library_id = %s;
          """
      args = (library_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.rowcount
      print(results)
      if results:
        return "Successfully deleted work"
      return "Failed to delete the work. Please check that the entered work_id is correct"
  except Exception as e: 
    print(e)
    return "Failed to delete the library. Please check that the entered library_id is correct"


def deleteWork(work_id):
  try: 
    connection = connect()
    if connection:
      cursor = connection.cursor()
      sql = """
          DELETE FROM Work
          WHERE work_id = %s;
          """
      args = (work_id)
      cursor.execute(sql, args)
      connection.commit()
      results = cursor.rowcount
      print(results)
      if results:
        return "Successfully deleted work"
      return "Failed to delete the work. Please check that the entered work_id is correct"
  except Exception as e: 
    print(e)
    return "Failed to delete the work. Please check that the entered work_id is correct"

    
def load(className, entityID):
  sql = """SELECT * FROM {className} WHERE id = {entityID}"""
  return sql
