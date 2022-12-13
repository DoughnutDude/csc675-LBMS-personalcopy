Library Management System Business Requirements
version2

1. Find the number of reservable rooms that have no room reservations made.
For each library show this number, the number of total reservable rooms, and the
name of the library that the room belongs to. Only show this for libraries that have more rooms
without reservations than rooms with reservations. Command: !recommend_room_reservations
2. Find each instance associated with works that have more than one contributing agent.
Show the instance titles, work titles, and the number of contributing agents. Comand: !get_contributions
3. Find all of the people that are attending a particular organized event, only if they
are members at more than one library.
Show the names of attending people and the amount of libraries, each one is a member of. Command: !get_attendants <event_id>
4. Find all of the physical item reservations belonging to a particular member.
Show the member's id, and each reservation's start time along with the physical item's id. Command: !get_item_reservations <member_id>
5. Find the number of physical items that each staff has catalogued, but only if this number is over 4.
Show the name of the staff and the number of items.
Show in descending order, so the staff with the most catalogued items is the first entry. Command: !get_top_cataloggers
6. Find all shelves in the database and order them by the number of physical items stored in each one, from most to least. Show the name of the shelf, the name of the room it is in, and the number of physical items stored. Command: !get_most_filled_shelves
7. Create a trigger that adds a new member whenever a new student is created, which relates the student's associated person with the library that belongs to the school at which the student is enrolled. Command: !make_new_student <student_id> <school_id> <person_id>
8. Create a trigger that adds a new calendar event and library event, every time a new organized event is created. Command: !make_new_event <staff_id>
9. Create a procedure to make an equipment reservation, only if there is no equipment reservation for that equipment with the same time slot as the one being made. Command: !reserve_equipment <member_id> <equipment_id> <start_time> <end_time>
10. Create a procedure to add a library event as a calendar event for every single library. Command: !add_event_to_all_calendars <library_event>
11. Create a function to check if a person has any complete forms that are invalid, and return the number of invalid forms. Command: !check_forms_validity <person_id>
12. Create a function to check which library event that has the closest start time after the current time.
Return the id of the library event. Command: !get_next_event
13. Update the name of a language, along with the names of any formats with text containing that language. Command: !update_language_name <language_id> <new_name>
14. Update a form's data, and mark each complete form belonging to the updated form as being invalid, in order to mark them for reprocessing. Command: !update_form <form_id> <new_path>
15. Delete a library, along with any associated memberships, calendar events, and/or other
related entities as necessary. Command: !delete_library <library_id>
16. Delete a work, along with any associated descriptions, discussions, contributions, instances, items and/or other related entities as necessary. Command: !delete_work <work_id>

1.(OLD) Find the number of reservable rooms that have no room reservations made.
Show this number, as well as the number of total reservable rooms.

5.(OLD) Find the staff that has catalogued the most items. Show the name of the staff and the number of items.
