Library Management System Business Requirements
version2

1. Find the number of reservable rooms that have no room reservations made.
For each library show this number, the number of total reservable rooms, and the
name of the library that the room belongs to. Only show this for libraries that have more rooms
without reservations than rooms with reservations.
2. Find each instance associated with works that have more than one contributing agent.
Show the instance titles, work titles, and the number of contributing agents.
3. Find all of the people that are attending a particular organized event, only if they
are members at more than one library.
Show the names of attending people and the amount of libraries, each one is a member of.
4. Find all of the physical item reservations belonging to a particular member.
Show the member's id, and each reservation's start time along with the physical item's id.
5. Find the number of physical items that each staff has catalogued, but only if this number is over 4.
Show the name of the staff and the number of items.
Show in descending order, so the staff with the most catalogued items is the first entry.
6. Find the shelf with the most physical items stored in it. Show the name of the shelf, the name of the
room it is in, and the number of physical items stored.
7. Create a trigger that adds a new member whenever a new student is created, which relates the student's
associated person with the library that belongs to the school at which the student is enrolled.
8. Create a trigger that adds a new calendar event and library event, every time a new organized event is created.
9. Create a procedure to make an equipment reservation, only if there is no equipment reservation for that
equipment with the same time slot as the one being made.
10. Crete a procedure to add a library event as a calendar event for every single library.
11. Create a function to check if a person has any complete forms that are invalid, and return the number
of invalid forms.
12. Create a function to check which library event that has the closest start time after the current time.
Return the id of the library event.
13. Update the name of a language, along with the names of any formats with text containing that language.
14. Update a form's data, and mark each complete form belonging to the updated form as being invalid,
in order to mark them for reprocessing.
15. Delete a library event, along with any associated calendar events, organized events, and/or other
related entities as necessary.
16. Delete a work, along with any associated descriptions, discussions, contributions, instances, items
and/or other related entities as necessary.
1.(OLD) Find the number of reservable rooms that have no room reservations made.
Show this number, as well as the number of total reservable rooms.
5.(OLD) Find the staff that has catalogued the most items. Show the name of the staff and the number of items.
