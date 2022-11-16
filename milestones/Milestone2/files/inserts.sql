   -- Script name: inserts.sql
   -- Author:      Cameron Yee
   -- Purpose:     Insert sample data to test the integrity of the database system

USE LibraryManagementDB;

-- Language table inserts
INSERT INTO Language (`name`)
VALUES ("English");
INSERT INTO Language (`name`)
VALUES ("Spanish");
INSERT INTO Language (`name`)
VALUES ("SQL");

-- Region table inserts
INSERT INTO Region (`name`)
VALUES ("Belmont");
INSERT INTO Region (`name`)
VALUES ("San Mateo");
INSERT INTO Region (`name`)
VALUES ("San Francisco");
INSERT INTO Region (`name`)
VALUES ("San Carlos");
INSERT INTO Region (`name`)
VALUES ("Abstratosphere");

-- Vendor table inserts
INSERT INTO Vendor (`name`, `region_fk`)
VALUES ("Pancake Printing Company", 2);
INSERT INTO Vendor (`name`, `region_fk`)
VALUES ("Robert's Computer Distribution Services", 1);
INSERT INTO Vendor (`name`, `region_fk`)
VALUES ("Double Dice Books", 5);

-- Library table inserts
INSERT INTO Library (`name`, `region_fk`)
VALUES ("Belmont Public Library", 1);
INSERT INTO Library (`name`, `region_fk`)
VALUES ("College of San Mateo Library", 2);
INSERT INTO Library (`name`, `region_fk`)
VALUES ("J. Paul Leonard Library", 3);
INSERT INTO Library (`name`, `region_fk`)
VALUES ("San Carlos Public Library", 4);
INSERT INTO Library (`name`, `region_fk`)
VALUES ("Raucous Lageuf Library", 5);

-- Floor table inserts
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("G", 1);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("1", 1);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("B", 2);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("1", 2);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("2", 2);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("G", 3);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("1", 3);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("2", 3);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("3", 3);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("4", 3);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("Roof", 5);
INSERT INTO Floor (`name`, `library_fk`)
VALUES ("B413", 5);

-- Room table inserts
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room A", 1);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Main Hall", 1);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("East Section", 1);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room B", 1);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room C", 1);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room D", 2);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Storage Room R", 3);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Commons", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room A", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room B", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room C", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room D", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room E", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Study Room F", 6);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Research Commons", 7);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Roof Conference Room A", 11);
INSERT INTO Room (`name`,`floor_fk`)
VALUES ("Super Secret Basement Recording Studio", 12);

-- ReservableRoom table inserts
INSERT INTO ReservableRoom (`room_fk`)
VALUES (1);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (4);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (5);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (6);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (9);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (10);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (11);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (12);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (13);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (14);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (16);
INSERT INTO ReservableRoom (`room_fk`)
VALUES (17);

-- Bookstack table inserts
INSERT INTO Bookstack (`room_fk`)
VALUES (2);
INSERT INTO Bookstack (`room_fk`)
VALUES (3);
INSERT INTO Bookstack (`room_fk`)
VALUES (7);

-- Shelf table inserts
INSERT INTO Shelf (`name`, `bookstack_fk`)
VALUES ("1 History, A-M", 1);
INSERT INTO Shelf (`name`, `bookstack_fk`)
VALUES ("1 History, N-Z", 1);
INSERT INTO Shelf (`name`, `bookstack_fk`)
VALUES ("1 Non-Fiction", 1);
INSERT INTO Shelf (`name`, `bookstack_fk`)
VALUES ("2 Science Fiction A-M", 1);
INSERT INTO Shelf (`name`, `bookstack_fk`)
VALUES ("1 Sci-Fi DVD's", 1);

-- School table inserts
INSERT INTO School (`name`, `library_fk`, `region_fk`)
VALUES ("College of San Mateo", 2, 2);
INSERT INTO School (`name`, `library_fk`, `region_fk`)
VALUES ("San Francisco State University", 3, 3);
INSERT INTO School (`name`, `library_fk`, `region_fk`)
VALUES ("Phatten Groof Academy", 5, 5);

-- Person table inserts
INSERT INTO Person (`name`, `email`, `region_fk`, `dob`)
VALUES ("Joe", "joe@joe", 1, "1983-01-04");
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Angel", "angel@joe", 2);
INSERT INTO Person (`name`, `email`, `region_fk`, `dob`)
VALUES ("Lester Reese", "lester@joe", 1, "1972-06-10");
INSERT INTO Person (`name`, `email`, `region_fk`, `dob`, `parent_id`)
VALUES ("Connor Reese", "connor@joe", 1, "2004-12-14", 3);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Janice", "janice@joe", 2);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Charlotte", "char@joe", 4);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Milton Laces", "milton@joe", 4);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Rana", "ranalala@joe", 2);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("pasha", "pashb@joe", 1);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Zach Wong", "zack@joe", 5);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Jesse", "jesse@bpl", 1);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Javier Miller", "javtheclav@bpl", 1);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Petra", "petra@bpl", 1);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Bonnie Dominguez", "bdominguez@my.smccd.edu", 2);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Michael Michael", "michaelmichael@mail.sfsu.edu", 3);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("James Barnes", "jamesbarnes@scl", 4);
INSERT INTO Person (`name`, `email`, `region_fk`)
VALUES ("Kozma", "kozma@spiral", 5);

-- Membership table inserts
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (123456789, 1, 1, 0000);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (987654321, 2, 1, 1234);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (900000001, 5, 1, 8887);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (888888888, 5, 2, 0815);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (012345678, 3, 1, 1994);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (876543210, 3, 4, 4530);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (148568784, 6, 1, 0783);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (876568456, 7, 4, 4535);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (161811950, 8, 2, 0164);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (012615608, 9, 4, 9260);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (100000000, 10, 5, 7797);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000001, 11, 1, 1612);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000002, 12, 1, 2222);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000003, 13, 1, 5549);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000101, 14, 2, 4321);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000201, 15, 3, 7214);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000301, 16, 4, 5678);
INSERT INTO Membership (`member_id`, `person_fk`, `library_fk`, `pin`)
VALUES (000000401, 17, 5, 3469);

-- Student table inserts
INSERT INTO Student (`student_id`, `school_fk`, `person_fk`, `member_fk`)
VALUES (920699179, 1, 5, 888888888);
INSERT INTO Student (`student_id`, `school_fk`, `person_fk`, `member_fk`)
VALUES (920692287, 1, 8, 161811950);
INSERT INTO Student (`student_id`, `school_fk`, `person_fk`, `member_fk`)
VALUES (301010560, 3, 10, 100000000);

-- Staff table inserts
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123456789, 1, 000000001, TRUE);
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123456755, 1, 000000002, TRUE);
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123456357, 1, 000000003, FALSE);
INSERT INTO Staff (`staff_id`,  `library_fk`, `member_fk`, `is_librarian`)
VALUES (123457272, 2, 000000101, TRUE);
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123454321, 3, 000000201, TRUE);
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123456282, 4, 000000301, TRUE);
INSERT INTO Staff (`staff_id`, `library_fk`, `member_fk`, `is_librarian`)
VALUES (123456285, 5, 000000401, TRUE);

-- Form table inserts
INSERT INTO Form (`description`, `creator_fk`, `form_location`)
VALUES ("Belmont Public Library: Guardian-Minor Authorization", 123456789, "/forms/minorAuth.pdf");
INSERT INTO Form (`description`, `creator_fk`, `form_location`)
VALUES ("Belmont Public Library: Member Organized Event Form", 123456357, "/forms/eventForm.pdf");
INSERT INTO Form (`description`, `creator_fk`, `form_location`)
VALUES ("Belmont Public Library: Library System Feature Request", 123456357, "/forms/featureRequestV2.pdf");

-- CompleteForm table inserts
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `is_valid`, `form_location`)
VALUES (1, 2, 123456789, TRUE, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `is_valid`, `form_location`)
VALUES (3, 1, 123456357, FALSE, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `form_location`)
VALUES (3, 2, 123456357, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `is_valid`, `form_location`)
VALUES (3, 3, 123456789, TRUE, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `is_valid`, `form_location`)
VALUES (3, 3, 123456789, TRUE, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));
INSERT INTO CompleteForm (`person_fk`, `form_fk`, `processor_fk`, `is_valid`, `form_location`)
VALUES (1, 3, 123456789, TRUE, CONCAT(CONCAT("/completeforms/", LAST_INSERT_ID()), ".pdf"));

-- LibraryEvent table inserts
INSERT INTO LibraryEvent (`name`, `start`, `end`)
VALUES ("Jesse's Book Club", "2022-10-04 10:00:00", "2022-10-04 11:00:00");
INSERT INTO LibraryEvent (`name`, `start`, `end`)
VALUES ("National Library Day", "2022-05-06", "2022-05-07");
INSERT INTO LibraryEvent (`name`, `start`, `end`)
VALUES ("Food Truck Expo", "2022-08-10 09:00:00", "2022-08-21 11:59:00");
INSERT INTO LibraryEvent (`name`, `start`, `end`)
VALUES ("Petra's 3D Printing Tutorial", "2022-11-14 12:30:00", "2022-11-14 14:00:00");
INSERT INTO LibraryEvent (`name`, `start`, `end`)
VALUES ("Petra's Sewing Machine Demonstration", "2022-11-17 13:00:00", "2022-11-17 14:00:00");

-- OrganizedEvent table inserts
INSERT INTO OrganizedEvent (`organizer_fk`, `lib_event_fk`)
VALUES (123456789, 1);
INSERT INTO OrganizedEvent (`organizer_fk`, `lib_event_fk`)
VALUES (123456357, 4);
INSERT INTO OrganizedEvent (`organizer_fk`, `lib_event_fk`)
VALUES (123456357, 5);

-- Attendance table inserts
INSERT INTO Attendance (`attendant_fk`, `org_event_fk`)
VALUES (1, 1);
INSERT INTO Attendance (`attendant_fk`, `org_event_fk`)
VALUES (2, 1);
INSERT INTO Attendance (`attendant_fk`, `org_event_fk`)
VALUES (3, 1);
INSERT INTO Attendance (`attendant_fk`, `org_event_fk`)
VALUES (5, 1);
INSERT INTO Attendance (`attendant_fk`, `org_event_fk`)
VALUES (6, 1);

-- CalendarEvent table inserts
INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
VALUES (1, 1);
INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
VALUES (3, 1);
INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
VALUES (3, 2);
INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
VALUES (4, 1);
INSERT INTO CalendarEvent (`lib_event_fk`, `library_fk`)
VALUES (5, 1);

-- Work table inserts
INSERT INTO Work (`title`, `date`)
VALUES ("The Adventures of Some Guy", "1985-01-01");
INSERT INTO Work (`title`)
VALUES ("Abstrotospheric History, Part 1");
INSERT INTO Work (`title`, `date`)
VALUES ("RWV 1080", "1777-01-01");
INSERT INTO Work (`title`, `date`)
VALUES ("B.O.R.E. Magazine, Issue #47: Historical Autobiographies, an Anthology", "2018-06-12");
INSERT INTO Work (`title`, `date`)
VALUES ("Mental Momentum", "2014-01-29");
INSERT INTO Work (`title`, `date`)
VALUES ("Like Clockwork", "7743-03-16");
INSERT INTO Work (`title`, `date`)
VALUES ("Like Clockwork The Film", "7755-03-16");

-- WorkReference table inserts
INSERT INTO WorkReference (`referencer_fk`, `referenced_fk`)
VALUES (4, 1);
INSERT INTO WorkReference (`referencer_fk`, `referenced_fk`)
VALUES (2, 3);
INSERT INTO WorkReference (`referencer_fk`, `referenced_fk`)
VALUES (2, 4);

-- Event table inserts
INSERT INTO Event (`description`, `date`)
VALUES ("World War I", "1914-07-28 00:00:00");
INSERT INTO Event (`description`, `date`)
VALUES ("Death of Raucous Lageuf", "1797-03-27 00:00:00");
INSERT INTO Event (`description`, `date`)
VALUES ("Creation of Abstratosphere", "1111-04-13 23:11:00");
INSERT INTO Event (`description`, `date`)
VALUES ("Founding of Phatten Groof Academy", "7777-07-11 04:13:00");

-- Agent table inserts
INSERT INTO Agent (`name`)
VALUES ("Some Guy");
INSERT INTO Agent (`name`)
VALUES ("Olive Branch");
INSERT INTO Agent (`name`)
VALUES ("Raucous Lageuf");
INSERT INTO Agent (`name`)
VALUES ("BOSS Foundation");
INSERT INTO Agent (`name`, `organization_id`)
VALUES ("Artemis Raynes", 4);
INSERT INTO Agent (`name`, `organization_id`)
VALUES ("George Sirlin", 4);
INSERT INTO Agent (`name`)
VALUES ("R.K. Miller");
INSERT INTO Agent (`name`)
VALUES ("Asumi Markovich");
INSERT INTO Agent (`name`)
VALUES ("Clay Evans");

-- Subject table inserts
INSERT INTO Subject (`description`)
VALUES ("War");
INSERT INTO Subject (`description`, `overarching_subject_id`)
VALUES ("World War I", 1);
INSERT INTO Subject (`description`)
VALUES ("Comedy");
INSERT INTO Subject (`description`, `overarching_subject_id`)
VALUES ("Pranks", 3);
INSERT INTO Subject (`description`)
VALUES ("Philosophy");
INSERT INTO Subject (`description`, `overarching_subject_id`)
VALUES ("Existentialism", 6);
INSERT INTO Subject (`description`)
VALUES ("Math");
INSERT INTO Subject (`description`)
VALUES ("History");
INSERT INTO Subject (`description`)
VALUES ("Fiction");
INSERT INTO Subject (`description`)
VALUES ("Technology");

-- Description table inserts
INSERT INTO Description (`work_fk`, `event_fk`)
VALUES (1, 1);
INSERT INTO Description (`work_fk`, `event_fk`)
VALUES (2, 3);
INSERT INTO Description (`work_fk`, `event_fk`)
VALUES (2, 4);
INSERT INTO Description (`work_fk`, `event_fk`)
VALUES (3, 3);

-- Contribution table inserts
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (1, 1, "Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (1, 2, "Illustrator");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (1, 3, "Editor");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (3, 3, "Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (2, 5, "Co-Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (2, 6, "Co-Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (5, 6, "Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (5, 7, "Editor");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (6, 7, "Author");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (7, 8, "Director");
INSERT INTO Contribution(`work_fk`, `agent_fk`, `role`)
VALUES (7, 9, "Producer");

-- Discussion table inserts
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (1, 1);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (1, 2);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (2, 8);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (3, 4);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (3, 7);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (5, 7);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (5, 9);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (6, 9);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (6, 10);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (7, 9);
INSERT INTO Discussion(`work_fk`, `subject_fk`)
VALUES (7, 10);

-- Instance table inserts
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("The Adventures of Some Guy, 1st Edition", 1, "1985-01-01");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("The Adventures of Some Guy, 2nd Edition", 1, "1997-01-01");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("The Adventures of Some Guy, Graphic Novel Edition", 1, "2008-09-01");
INSERT INTO Instance (`title`, `work_fk`)
VALUES ("Abstratospheric History, Part 1, 1st Edition", 2);
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("RWV 1080, Original", 3, "1777-01-01");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("RWV 1080, Spanish Translation", 3, "1892-01-01");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("RWV 1080, Restored", 3, "2012-01-01");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("B.O.R.E. Magazine, Issue #47: Historical Autobiographies, an Anthology", 4, "2018-06-12");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("Mental Momentum", 5, "2014-01-29");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("Like Clockwork", 6, "7743-03-16");
INSERT INTO Instance (`title`, `work_fk`, `date`)
VALUES ("Like Clockwork The Film, Theatre Release", 7, "7755-03-16");

-- InstanceReference table inserts
INSERT INTO InstanceReference (`referencer_fk`, `referenced_fk`)
VALUES (3, 1);
INSERT INTO InstanceReference (`referencer_fk`, `referenced_fk`)
VALUES (4, 5);
INSERT INTO InstanceReference (`referencer_fk`, `referenced_fk`)
VALUES (7, 5);

-- Format table inserts
INSERT INTO Format (`name`)
VALUES ("Autobiography");
INSERT INTO Format (`name`)
VALUES ("Book");
INSERT INTO Format (`name`, `language_fk`)
VALUES ("English Text", 1);
INSERT INTO Format (`name`, `language_fk`)
VALUES ("Spoken English", 1);
INSERT INTO Format (`name`, `language_fk`)
VALUES ("English Subtitles", 1);
INSERT INTO Format (`name`, `language_fk`)
VALUES ("Spanish Text", 2);
INSERT INTO Format (`name`, `language_fk`)
VALUES ("Spoken Spanish", 2);
INSERT INTO Format (`name`, `language_fk`)
VALUES ("Spanish Subtitles", 2);
INSERT INTO Format (`name`)
VALUES ("Comic");
INSERT INTO Format (`name`)
VALUES ("Poem");
INSERT INTO Format (`name`)
VALUES ("Magazine");
INSERT INTO Format (`name`)
VALUES ("Illustration");
INSERT INTO Format (`name`, `language_fk`)
VALUES ("SQL Code", 3);
INSERT INTO Format (`name`)
VALUES ("Film");

-- Publisher table inserts
INSERT Publisher (`name`, `region_fk`)
VALUES ("B.O.R.E. Books", 3);
INSERT Publisher (`name`, `region_fk`)
VALUES ("BOSS Foundation Publishing", 5);
INSERT Publisher (`name`, `region_fk`)
VALUES ("Astralis Books", 2);
INSERT Publisher (`name`)
VALUES ("Self Published");

-- Media table inserts
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (1, 1);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (1, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (1, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (2, 1);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (2, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (2, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (3, 1);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (3, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (3, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (3, 9);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (4, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (4, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (5, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (5, 10);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (6, 10);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (6, 6);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (7, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (7, 10);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (8, 11);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (8, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (9, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (9, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (9, 13);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (10, 2);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (10, 3);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (11, 4);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (11, 5);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (11, 8);
INSERT INTO Media (`instance_fk`, `format_fk`)
VALUES (11, 14);

-- Issue table inserts
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (1, 1);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (2, 1);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (3, 3);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (4, 2);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (5, 2);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (6, 2);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (7, 2);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (8, 1);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (9, 4);
INSERT INTO Issue (`instance_fk`, `publisher_fk`)
VALUES (10, 2);

-- Item table inserts
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (1, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (2, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (3, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (3, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (3, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (4, 3, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (6, 1, 123457272);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (7, 1, 123456755);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (5, 3, 123456285);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (8, 1, 123456285);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (9, 1, 123456285);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (9, 1, 123456285);
INSERT INTO Item (`instance_fk`, `supplier_fk`, `catalogger_fk`)
VALUES (10, 1, 123456285);
INSERT INTO Item (`instance_fk`, `catalogger_fk`)
VALUES (11, 123454321);

-- PhysicalItem table inserts
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("DH645-AU77", 1, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("DH645-AU78", 2, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("DH645-AG78", 3, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("DH645-AG78", 4, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("DH645-AG78", 5, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("AX111-CA29", 6, 2);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("RG17-CA18", 7, 3);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("RG17-SP80", 8, 3);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("SC10-AK43", 11, 4);
INSERT INTO PhysicalItem (`call_number`, `item_fk`, `shelf_fk`)
VALUES ("SC10-AK55", 14, 5);

-- Equipment table inserts
INSERT INTO Equipment (`library_fk`, `model`, `serial_num`, `supplier_fk`)
VALUES (1, "ThinkPad", "AC86fkQy", 2);
INSERT INTO Equipment (`library_fk`, `model`, `serial_num`, `supplier_fk`)
VALUES (1, "ThinkPad", "fygoBTqH", 2);
INSERT INTO Equipment (`library_fk`, `model`, `serial_num`, `supplier_fk`)
VALUES (1, "ThinkPad", "iGoJjw4k", 2);
INSERT INTO Equipment (`library_fk`, `model`, `serial_num`, `supplier_fk`)
VALUES (1, "ThinkPad", "K1xfcFHa", 2);

-- ItemReservation table inserts
INSERT INTO ItemReservation (`member_fk`, `item_fk`, `start`, `end`)
VALUES ("123456789", "DH645-AU77", "2022-10-04 10:00:00", "2022-10-11 10:00:00");
INSERT INTO ItemReservation (`member_fk`, `item_fk`, `start`, `end`)
VALUES ("123456789", "DH645-AU78", "2022-10-04 10:00:00", "2022-10-11 10:00:00");
INSERT INTO ItemReservation (`member_fk`, `item_fk`, `start`, `end`)
VALUES ("012345678", "DH645-AU77", "2022-11-02 10:00:00", "2022-11-07 10:00:00");

-- EquipmentReservation table inserts
INSERT INTO EquipmentReservation (`member_fk`, `equipment_fk`, `start`, `end`)
VALUES ("123456789", "1", "2022-10-04 10:00:00", "2022-10-11 10:00:00");
INSERT INTO EquipmentReservation (`member_fk`, `equipment_fk`, `start`, `end`)
VALUES ("900000001", "2", "2022-10-04 10:00:00", "2022-10-11 10:00:00");
INSERT INTO EquipmentReservation (`member_fk`, `equipment_fk`, `start`, `end`)
VALUES ("012345678", "1", "2022-10-11 12:00:00", "2022-10-13 11:00:00");
INSERT INTO EquipmentReservation (`member_fk`, `equipment_fk`, `start`, `end`)
VALUES ("987654321", "3", "2022-11-02 10:00:00", "2022-11-07 10:30:00");

-- RoomReservation table inserts
INSERT INTO RoomReservation (`room_fk`, `member_fk`, `start`, `end`)
VALUES (1, 888888888, "2022-10-12 09:00:00", "2022-10-12 10:00:00");
INSERT INTO RoomReservation (`room_fk`, `member_fk`, `start`, `end`)
VALUES (2, 148568784, "2022-10-12 09:00:00", "2022-10-12 10:00:00");
INSERT INTO RoomReservation (`room_fk`, `member_fk`, `start`, `end`)
VALUES (3, 100000000, "2022-10-12 10:30:00", "2022-10-12 12:30:00");
INSERT INTO RoomReservation (`room_fk`, `member_fk`, `start`, `end`)
VALUES (9, 000000201, "2022-11-9 14:00:00", "2022-11-09 16:00:00");
