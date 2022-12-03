   -- Script name: tests.sql
   -- Author:      Cameron Yee
   -- Purpose:     Implement the business requirements to test the logic of the database system
   
USE LibraryManagementDB;
SET SQL_SAFE_UPDATES = 0;

-- 1. Find the number of reservable rooms that have no room reservations made.
-- For each library, show this number, the number of total reservable rooms, and the
-- name of the library that the room belongs to. Only show this for libraries that have more rooms
-- without reservations than rooms with reservations.
SELECT l.name AS "Library", SUM(IF(rReservation.room_fk IS NULL, 1, 0)) AS UnreservedReservableRooms, COUNT(*) AS "Total Reservable Rooms"
FROM ReservableRoom rRoom
LEFT JOIN RoomReservation rReservation ON rReservation.room_fk = rRoom.reservable_room_id
JOIN Room r ON r.room_id = rRoom.room_fk
JOIN Floor f ON f.floor_id = r.floor_fk
JOIN Library l ON l.library_id = f.library_fk
GROUP BY l.name
HAVING UnreservedReservableRooms > SUM(IF(rReservation.room_fk IS NOT NULL, 1, 0));
-- Output:
-- |		Library				|	UnreservedReservableRooms	|	Total Reservable Rooms
-- | J. Paul Leonard Library	|		5						|		6
-- | Raucous Lageuf Library		|		2						|		2
/*
-- (OLD) 1. Find the number of reservable rooms that have no room reservations made.
-- Show this number, as well as the number of total reservable rooms.
SELECT COUNT(rRoom.reservable_room_id) AS "Unreserved Reservable Rooms", (SELECT COUNT(*) FROM ReservableRoom) AS "Total Reservable Rooms"
FROM ReservableRoom rRoom
LEFT JOIN RoomReservation rReservation ON rReservation.room_fk = rRoom.reservable_room_id
JOIN Room r ON r.room_id = rRoom.room_fk
WHERE rReservation.room_fk IS NULL;
-- Output:
-- |	Unreserved Reservable Rooms	|	Total Reservable Rooms
-- |		8						|		12
*/


-- 2. Find each instance associated with works that have more than one contributing agent.
-- Show the instance titles, work titles, and the number of contributing agents.
SELECT i.title AS "Instance", w.title AS "Work", COUNT(c.contribution_id) AS numOfContributions
FROM Work w
JOIN Instance i ON i.work_fk = w.work_id
JOIN Contribution c ON c.work_fk = w.work_id
GROUP BY i.title, w.title
HAVING numOfContributions > 1;
-- Output:
-- |		Instance									|			Work					|	numOfContributions	|
-- | The Adventures of Some Guy, 1st Edition			|	The Adventures of Some Guy		|		3				|
-- | The Adventures of Some Guy, 2nd Edition			|	The Adventures of Some Guy		|		3				|
-- | The Adventures of Some Guy, Graphic Novel Edition	|	The Adventures of Some Guy		|		3				|
-- | Abstratospheric History, Part 1, 1st Edition		|	Abstrotospheric History, Part 1	|		2				|
-- | Mental Momentum									|	Mental Momentum					|		2				|
-- | Like Clockwork The Film, Theatre Release			|	Like Clockwork The Film			|		2				|


-- 3. Find all of the people that are attending a particular organized event, only if they
-- are members at more than one library.
-- Show the names of attending people and the amount of libraries, each one is a member of.
DELIMITER $$
CREATE PROCEDURE getNumOfMultiMemberAttendants (IN event INT)
	BEGIN
		SELECT p.name AS "Attendant Name", COUNT(m.member_id) numOfLibraries
		FROM Attendance a
		JOIN Person p ON p.person_id = a.attendant_fk
        JOIN Membership m ON m.person_fk = p.person_id
		WHERE a.org_event_fk = event
        GROUP BY p.name
        HAVING numOfLibraries > 1;
   END $$
DELIMITER ;

CALL getNumOfMultiMemberAttendants(1);
-- Output:
-- |	Attendant Name	|	numOfLibraries	|
-- | Lester Reese		|		2			|
-- | Janice				|		2			|


-- 4. Find all of the physical item reservations belonging to a particular member.
-- Show the member's id, and each reservation's start time along with the physical item's id.
DELIMITER $$
CREATE PROCEDURE getNumOfItemReservations (IN member INT)
	BEGIN
		SELECT ir.member_fk AS "Member ID", ir.item_fk AS "Item Call #", ir.start, ir.end
		FROM ItemReservation ir
        WHERE ir.member_fk = member;
   END $$
DELIMITER ;

CALL getNumOfItemReservations(123456789);
-- Output:
-- |	Member ID	|	Item Call #	|		start			|		end				|
-- | 0123456789		|	DH645-AU77	|	2022-10-04 10:00:00	|	2022-10-11 10:00:00	|
-- | 0123456789		|	DH645-AU78	|	2022-10-04 10:00:00	|	2022-10-11 10:00:00	|


-- 5. Find the number of physical items that each staff has catalogued, but only if this number is over 4.
-- Show the name of the staff and the number of items.
-- Show in descending order, so the staff with the most catalogued items is the first entry.
SELECT p.name AS "Catalogger Name", COUNT(i.catalogger_fk) AS numOfItemsCatalogued
FROM Item i
JOIN Staff s ON s.staff_id = i.catalogger_fk
JOIN Membership m ON m.member_id = s.member_fk
JOIN Person p ON p.person_id = m.person_fk
GROUP BY p.name
HAVING numOfItemsCatalogued > 4
ORDER BY numOfItemsCatalogued DESC;
-- Output:
-- |	Catalogger Name	|	numOfItemsCatalogued	|
-- | Javier Miller		|		7					|
-- | Kozma				|		5					|
/*
-- (OLD) 5. Find the staff that has catalogued the most items. Show the name of the staff and the number of items.
SELECT p.name, COUNT(i.catalogger_fk) AS numOfItemsCatalogued
FROM Item i
JOIN Staff s ON s.staff_id = i.catalogger_fk
JOIN Membership m ON m.member_id = s.member_fk
JOIN Person p ON p.person_id = m.person_fk
GROUP BY p.name
ORDER BY numOfItemsCatalogued DESC
LIMIT 1;
-- Output:
-- |	Catalogger Name	|	numOfItemsCatalogued	|
-- | Javier Miller		|		7					|
*/


-- 6. Find the shelf with the most physical items stored in it.
-- Show the name of the shelf, the name of the room it is in, and the number of physical items stored.
SELECT s.name AS "Shelf Name", r.name AS "Room Name", COUNT(p.call_number) AS numOfItems
FROM Shelf s
JOIN Bookstack b ON b.bookstack_id = s.bookstack_fk
JOIN Room r ON r.room_id = b.room_fk
JOIN PhysicalItem p ON p.shelf_fk = s.shelf_id
GROUP BY s.name, r.name;
-- Output:
-- |	Catalogger Name		|	Rooom Name	|	numOfItems	|
-- | 1 History, N-Z			|	Main Hall	|		6		|
-- | 1 Non-Fiction			|	Main Hall	|		2		|
-- | 2 Science Fiction A-M	|	Main Hall	|		1		|
-- | 1 Sci-Fi DVD's			|	Main Hall	|		1		|


-- 7. Create a trigger that adds a new member whenever a new student is created, which relates the student's
-- associated person with the library that belongs to the school at which the student is enrolled.
DELIMITER $$
CREATE TRIGGER studentCreateMember BEFORE INSERT ON Student
	FOR EACH ROW
		BEGIN
			DECLARE library_fk INT;
			DECLARE person_dob DATE;
            SET library_fk = (SELECT school.library_fk
							  FROM School school
							  WHERE school.school_id = new.school_fk);
			SET person_dob = (SELECT person.dob
							FROM Person person
                            WHERE person.person_id = new.person_fk);

			INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
            VALUES (new.member_fk, new.person_fk, library_fk, date_format(person_dob, '%m%d')); -- Use birthdate as pin
   END $$
DELIMITER ;

-- Connor becomes a student. He should automatically get a membership at his new school's library.
INSERT INTO Student (`student_id`, `school_fk`, `person_fk`, `member_fk`)
VALUES (920699180, 1, 4, 920699180);
-- Output: none


-- 8. Create a trigger that adds a new calendar event and library event, every time a new organized event is created.
DELIMITER $$
CREATE TRIGGER orgEventCreateLibEvent BEFORE INSERT ON OrganizedEvent
	FOR EACH ROW
		BEGIN
			DECLARE event_name VARCHAR(255);
            DECLARE lib_event_id INT;
            SET event_name = CONCAT((SELECT p.name FROM Staff s 
									JOIN Membership m ON m.member_id = s.member_fk
									JOIN Person p ON p.person_id = m.person_fk
									WHERE s.staff_id = new.organizer_fk), "'s New Event");
            
			INSERT INTO LibraryEvent (`name`, `start`, `end`)
			VALUES (event_name, ADDTIME(NOW(), "1:00:00"), ADDTIME(NOW(), "2:00:00"));
            SET lib_event_id = LAST_INSERT_ID();
            SET new.lib_event_fk = lib_event_id;
			INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
            VALUES (lib_event_id, (SELECT s.library_fk FROM Staff s WHERE s.staff_id = new.organizer_fk));
   END $$
DELIMITER ;

INSERT INTO OrganizedEvent (`organizer_fk`, `lib_event_fk`)
VALUES (123456357, 0);
-- Output: none


-- 9. Create a procedure to make an equipment reservation, only if there is no equipment reservation for that
-- equipment with the same time slot as the one being made.
DELIMITER $$
CREATE PROCEDURE attemptEquipmentReservation (IN member_id INT, equipment_id INT, start DATETIME, end DATETIME)
	BEGIN
		DECLARE numOfConflicts INT;
		SET numOfConflicts = (SELECT COUNT(*)
						FROM EquipmentReservation er
						WHERE er.equipment_fk = equipment_id AND er.start < end AND er.end > start);
		
        IF numOfConflicts = 0 THEN
			INSERT INTO EquipmentReservation (`member_fk`, `equipment_fk`, `start`, `end`)
            VALUES (member_id, equipment_id, start, end);
        END IF;
   END $$
DELIMITER ;

CALL attemptEquipmentReservation(900000001, 1, "2022-10-11 10:30:00", "2022-10-11 12:03:00"); -- This should not insert
CALL attemptEquipmentReservation(876543210, 1, "2022-10-11 10:30:00", "2022-10-11 12:00:00"); -- This should insert
-- Output: none


-- 10. Crete a procedure to add a library event as a calendar event for every single library.
DELIMITER $$
CREATE PROCEDURE addCalendarEventToAll (IN lib_event_id INT)
	BEGIN
		DECLARE temp_lib_id INT;
        
        CREATE TEMPORARY TABLE temp_libraries
        SELECT library_id
        FROM Library;
        
        while_loop:
        WHILE EXISTS (SELECT 1 FROM temp_libraries) DO
			SET temp_lib_id = (SELECT tl.library_id FROM temp_libraries tl LIMIT 1);
        
			INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
			VALUES (lib_event_id, temp_lib_id);
            
			DELETE FROM temp_libraries LIMIT 1;
    	END WHILE
        while_loop;
		DROP TABLE temp_libraries;
	END $$
DELIMITER ;

CALL addCalendarEventToAll(2);
-- Output: none


-- 11. Create a function to check if a person has any complete forms that are invalid, and return the number
-- of invalid forms.
DELIMITER $$
CREATE FUNCTION checkForInvalidForms (person_id INT)
	RETURNS INT DETERMINISTIC
	BEGIN
		DECLARE numOfInvalidForms INT;
        SET numOfInvalidForms = (SELECT COUNT(*) FROM CompleteForm WHERE person_fk = person_id AND is_valid = FALSE);
        RETURN numOfInvalidForms;
	END $$
DELIMITER ;

SELECT checkForInvalidForms(3) AS "Number of Invalid Forms for Reese";
-- Output:
-- |	Number of Invalid Forms for Reese	|
-- |			2							|


-- 12. Create a function to check which library event that has the closest start time after the current time.
-- Return the id of the library event.
DELIMITER $$
CREATE FUNCTION getNextLibEvent ()
	RETURNS INT DETERMINISTIC
	BEGIN
        RETURN (SELECT le.lib_event_id
					FROM LibraryEvent le
					WHERE le.start > NOW()
                    ORDER BY le.start ASC
                    LIMIT 1);
	END $$
DELIMITER ;

SELECT getNextLibEvent() AS "ID of Next Event";
-- Output:
-- |	ID of Next Event	|
-- |		6				|


-- 13. Update the name of a language, along with the names of any formats with text containing that language.
UPDATE Language l -- Change Spanish to Español
JOIN Format f ON f.language_fk = l.language_id
SET l.name = "Español", f.name = REPLACE(f.name, "Spanish", l.name)
WHERE l.language_id = 2;
-- Output: none


-- 14. Update a form's data, and mark each complete form belonging to the updated form as being invalid,
-- in order to mark them for reprocessing.
UPDATE Form f
JOIN CompleteForm cf ON cf.form_fk = f.form_id
SET f.form_location = "forms/featureRequestV3.pdf", cf.is_valid = FALSE
WHERE f.form_id = 3;
-- Output: none


-- 15. Delete a library event, along with any associated calendar events, organized events, and/or other
-- related entities as necessary.
DELETE FROM Library
WHERE library_id = 1;
-- Output: none


-- 16. Delete a work, along with any associated descriptions, discussions, contributions, instances, items
-- and/or other related entities as necessary.
DELETE FROM Work
WHERE work_id = 1;
-- Output: none
