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
      "Bot failed to create a connection with your database because your secret environment variables "
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
      #variable = (company_name)
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
  except: 
    return cursor._last_executed
  

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
      #variable = (company_name)
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
  except: 
    return cursor._last_executed


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
      variable = (arg1)
      cursor = connection.cursor()
      cursor.execute(sql, variable)
      connection.commit()
      results = cursor.fetchall()
      for row in results:
        row["Number of Library Memberships"] = row.pop('numOfLibraries')
      print(results)
      if results:
        return results
      return "no multi member attendants found for event #" + arg1 
  except: 
     return cursor._last_executed


def getNumOfItemReservations(arg1):
  try: 
    connection = connect()
    if connection:
      sql = """
		      SELECT ir.member_fk AS "Member ID", ir.item_fk AS "Item Call #", ir.start, ir.end
		      FROM ItemReservation ir
          WHERE ir.member_fk = %s;"""
      variable = (arg1)
      cursor = connection.cursor()
      cursor.execute(sql, variable)
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
  except: 
    return cursor._last_executed


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
  except: 
    return cursor._last_executed


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
  except: 
    return cursor._last_executed
    
    
def load(className, entityID):
  sql = """SELECT * FROM {className} WHERE id = {entityID}"""
  return sql