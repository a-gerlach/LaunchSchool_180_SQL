Things to do before Assessment
  - Go through the exercises:
    - Did Easy 1; went well, do not have to do again
    - DML, DDL, DCL gemacht; war gut, muss aber nochmal Sequences nachlesen
    - LOOK UP: Do we have to specifiy NOT NULL and INTEGER for primary and foreign keys? Also how to you add them later to the table
    after the table has been created.
    - Ddid DDL exercises, look up a few things about primary and foreign keys
    - FINISHED DML, went well, but look into different types of keys. 
    - WHAT IS THE DIFFERENCES between a RIGHT AND LEFT OUTER JOIN


- A quick way to insert data into a file is this: INSERT INTO birds VALUES (1, 'owl', 16, 'brown');

- INSERT INTO birds (name, age, species) VALUES
  ('Charlie', 3, 'Finch'),
  ('Allie', 5, 'Owl'),
  ('Jennifer', 3, 'Magpie'),
  ('Jamie', 4, 'Owl'),
  ('Roy', 8, 'Crow');

- Whether you use parentheses around the columns you wish to query is important. 
  Leave the parentheses off and we get 4 individual columns returned in a table. 
  Include parentheses, and all our data gets grouped together into one column, like so:
  ==> SELECT (id,name,age,species) FROM birds;
              row
    -----------------------
     (1,Charlie,3,Finch)
     (2,Allie,5,Owl)
     (3,Jennifer,3,Magpie)
     (4,Jamie,4,Owl)
     (5,Roy,8,Crow)
    (5 rows)

- ALTER TABLE birds ADD CONSTRAINT check_age CHECK (age > 0);
  The "check age" is a name we can choose

- We also make sure to use a 
  PRIMARY KEY constraint in the table definition. This ensures that any ids must be UNIQUE and NOT NULL. 

- This expression converts an integer into a string. Then we can use the like 
  method on it: 
    - part_number::text 

- This is how you could add an on delete cascade function to an already existing table
  device_id is the column we want to use as a foreign key and devices.id is the id column
  in the devices table:
  - ALTER TABLE parts 
    ADD CONSTRAINT device_id_fkey 
    FOREIGN KEY (device_id) REFERENCES devices (id)
    ON DELETE CASCADE;

- CURRENT_TIMESTAMP is an alias for the NOW() function. 
  They can both be used to set the default of a timestamp as the current date and time.

- Foreign key columns are used to reference another row of data, perhaps in another table. In order to reference another row, 
  the database needs a unique 
  identifier for that row. Therefore, foreign key columns contain the value of the referenced rows primary key.

- When a primary_key consists of a unique pair PRIMARY KEY (user_id, book_id), 
  it is known as a composite key. It usually occurs in many-to-many relationships, 
  and we need to add an extra table to store this relationship data. 
  The composite key ensures that the data in the table will be unique for the relation between the user and book. 
  Example:
  - All three records below are valid and the table has primary keys (1,1), (1,2) and (2,1). 
    Therefore a new record (1,1) will be rejected by the database.

- The HAVING clause: this is required when selecting rows based on aggegated data such as a count. Example:
  - HAVING COUNT(name) >= 3
  - ORDER BY CLAUSES must come after having

STUDY GUIDE

SQL

    Explain the difference between INNER, LEFT OUTER, and RIGHT OUTER joins.
      - The difference is simple – in a left outer join, all of the rows from the “left” table will be displayed, 
        regardless of whether there are any matching columns in the “right” table. In a right outer join, 
        all of the rows from the “right” table will be displayed, regardless of whether 
        there are any matching columns in the “left” table. 
        Hopefully the example that we gave above help clarified this as well.

    Name and define the three sublanguages of SQL.
      - DDL: Data Definition Language

          The data definition parts of SQL are what allow a user to create and modify the schema stored within a database. 
          It includes CREATE TABLE, ALTER TABLE, ADD COLUMN, and several 
          other statements for creating or modifying the structure of or rules that govern the data that is held within a database.
      
      - DML: Data Manipulation Language

          This part of the SQL language is what allows a user to retrieve or modify the data stored within a database. Some databases consider the retrieval and manipulation 
          as two separate languages themselves, but PostgreSQL documentation combines them and accordingly, we will as well.

          DML includes SELECT, INSERT, UPDATE, and DELETE. 

      - DCL: Data Control Language

          DCL is tasked with controlling the rights and access roles of the users interacting with a database or table. 
          We are not going to spend much time on this part of SQL in this course since most databases you will be working with will utilize a database user 
          that has complete control of and access to a database, its schema, and its data. You may work on a project at 
          some point where this is not the case, but what that usually looks like is that you have been granted read-only access 
          and can only use SELECT statements.

      - Write SQL statements using INSERT, UPDATE, DELETE, CREATE/ALTER/DROP TABLE, ADD/ALTER/DROP COLUMN.

        - INSERT: 
          - INSERT INTO people (name, age) VALUES ('Adrian', 27);
          - INSERT INTO people ('Adrian', 27) # We have to mirror the table column perfectly

        - UPDATE: 
          - UPDATE people SET age = 50 WHERE age = 20;

        - DELETE:
          - DELETE FROM people WHERE id = 3;

        - CREATE: CREATE TABLE address (id integer PRIMARY KEY, street text NOT NULL, 
                                        people_id integer REFERENCES people (id));

        - ALTER: 
          - ALTER TABLE citizens ADD COLUMN marital_status boolean DEFAULT = false;
          - ALTER TABLE people RENAME TO citizens;
          - ALTER TABLE citizens ALTER name TYPE text;
          - ALTER TABLE citizens DROP marital_status;

        - Understand how to use GROUP BY, ORDER BY, WHERE, and HAVING
        SYNTAX: SELECT select_list FROM ... [WHERE ...] GROUP BY ... HAVING boolean_expression

        - GROUP BY:
          - SELECT SUM(paid_out) AS paid_out_to FROM transactions GROUP BY description;
            - What this SELECT query does is pick a field using the GROUP BY operation, in this case the description, 
              and groups rows by the field specified. Since, in this case, the transactions 
              are grouped by description, we can use the SUM() 
              function to compute the total value of all the paid_out values in the table, which is the total cost from each source.

        - WHERE: where search_condition is any value expression (see Section 4.2) that returns a value of type boolean.
          - After the processing of the FROM clause is done, 
            each row of the derived virtual table is checked against the search condition. 
            If the result of the condition is true, 
            the row is kept in the output table, otherwise (i.e., if the result is false or null) it is discarded.
            aggregate functions are not allowed in WHERE, we can use having for that

        - GROUP: The GROUP BY Clause is used to group together those rows in a table that have the same values in all the columns listed. 
          The order in which the columns are listed does not matter. 
          The effect is to combine each set of rows having common values into one group row that represents all rows in the group. 
          This is done to eliminate redundancy in the output and or compute aggregates that apply to these groups.

          In general, if a table is grouped, columns that are not listed in GROUP BY cannot be referenced 
          except in aggregate expressions. An example with aggregate expressions is:

          => SELECT x, sum(y) FROM test1 GROUP BY x;
           x | sum
          ---+-----
           a |   4
           b |   5
           c |   2
          (3 rows)

          Here sum is an aggregate function that computes a single value over the entire group. 

          Tip: Grouping without aggregate expressions effectively calculates the set of distinct values in a column. 
          This can also be achieved using the DISTINCT clause

        - HAVING: is like WHERE but we can use aggregate functions in HAVING and not in WHERE
          - The optional HAVING clause has the general form

              HAVING condition # this is a code example

          where condition is the same as specified for the WHERE clause.

          HAVING eliminates group rows that do not satisfy the condition. HAVING is different from WHERE: 
            WHERE filters individual rows before the application of GROUP BY, while HAVING filters group rows created by GROUP BY. 
            Each column referenced in condition must unambiguously reference a grouping column, unless 
            the reference appears within an aggregate function or the ungrouped column is functionally dependent on the grouping columns.

          The presence of HAVING turns a query into a grouped query even if there is no GROUP BY clause. 
          This is the same as what happens when the query contains aggregate functions but no GROUP BY clause. 
          All the selected rows are considered to form a single group, 
          and the SELECT list and HAVING clause can only reference table columns from within aggregate functions. 
          Such a query will emit a single row if the HAVING condition is true, zero rows if it is not true.

        - ORDER BY:

          The optional ORDER BY clause has this general form:

            ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...]

          The ORDER BY clause causes the result rows to be sorted according to the specified expression(s). 
          If two rows are equal according to the leftmost expression, they are compared according to the next expression and so on. 
          If they are equal according to all specified expressions, they are returned in an implementation-dependent order.

          Each expression can be the name or ordinal number of an output column (SELECT list item), 
          or it can be an arbitrary expression formed from input-column values.

PostgreSQL

  - Describe what a sequence is and what they are used for.

    - A sequence is a special kind of database object designed for generating unique numeric identifiers. 
      It is typically used to generate artificial primary keys.

      How Do I Use A Sequence In A Table?

      Sequences are most commonly used via the serial pseudotype. A serial is a special data type that encodes the following information:

      - it indicates that the values for the column will be generated by consulting the sequence
      - therefore, it creates a new sequence object, and sets the default value for the column to be 
        the next value produced by the sequence
      - since a sequence always produces non-NULL values, it adds a NOT NULL constraint to the column
      - since the sequence that is produced is created "behind the scenes", PostgreSQL assumes that the sequence 
        is only used to generate values for the table containing the serial column. 
        Therefore, if this column is dropped, the sequence will be automatically removed.

    Serial Types

    The data types smallserial, serial and bigserial are not true types, 
    but merely a notational convenience for creating unique identifier columns:

      CREATE TABLE tablename (
      colname SERIAL
      );

    is equivalent to specifying:

      CREATE SEQUENCE tablename_colname_seq;
      CREATE TABLE tablename (
      colname integer NOT NULL DEFAULT nextval('tablename_colname_seq')
      );
      ALTER SEQUENCE tablename_colname_seq OWNED BY tablename.colname;

      Thus, we have created an integer column and arranged for its default values to be assigned from a sequence generator. 
      A NOT NULL constraint is applied to ensure that a null value cannot be inserted. 
      (In most cases you would also want to attach a UNIQUE or PRIMARY KEY constraint 
      to prevent duplicate values from being inserted by accident, but this is not automatic.) 
      Lastly, the sequence is marked as "owned by" the column, so that it will be dropped if the column or table is dropped.

      To insert the next value of the sequence into the serial column, 
      specify that the serial column should be assigned its default value. This can be done either 
      by excluding the column from the list of columns in the INSERT statement, or through the use of the DEFAULT key word.

  - Define a default value for a column.

      - CREATE TABLE test (
        id serial PRIMARY KEY, # create a primary key with an self-incrementing sequence
        bool boolean DEFAULT('true') # define the default value of "true"
        );
      - ALTER TABLE test ADD COLUMN five integer DEFAULT(5);
      - ALTER TABLE test ALTER COLUMN five SET DEFAULT 10;

      CREATE TABLE stars (
        id serial PRIMARY KEY, # primary key
        name varchar(25) UNIQUE NOT NULL, # UNIQUE and NOT NULL Constraint
        distance integer NOT NULL CHECK (distance > 0), # check Constraint
        spectral_type char(1), 
        companions integer NOT NULL CHECK (companions >= 0)
      );

  - Be able to describe what a primary, foreign, natural, and surrogate keys are.
      - https://launchschool.com/books/sql/read/constraints # other keys
      - https://launchschool.com/lessons/d8c90dd4/assignments/93c5c267 # primary and surrogate key, also Sequences
      - https://launchschool.com/lessons/1b2f0fb4/assignments/ac98dd47
      Difference between primary_key and surrogate Key:
      The difference between the two is documenting your intention as a database designer. By using PRIMARY KEY, 
      the fact that a certain column can be relied upon as a way to identify specific rows is baked into the tables schema.

    - How PostgreSQL Executes Queries: https://launchschool.com/lessons/d8c90dd4/assignments/7761a32a

    - Create and remove CHECK constraints from a column.
      - ALTER TABLE colors ADD CONSTRAINT id_unique UNIQUE (id); # add a unique constraint
      - ALTER TABLE films DROP CONSTRAINT films_pkey; # this remove a primary key constraint
      - ALTER TABLE employees ALTER COLUMN vacation_remaining SET DEFAULT 0; # setting a default
      - ALTER TABLE employees ALTER COLUMN vacation_remaining SET NOT NULL; # setting a NOT NULL CONSTRAINT
      - ALTER TABLE temperatures ALTER COLUMN rainfall TYPE numeric(6,3); # changing the type of a column
      - ALTER TABLE films DROP CONSTRAINT title_unique; # Remove a Constraint
      - ALTER TABLE films ADD CONSTRAINT title_length CHECK (length(title) >= 1); # add a length constraint
      - ALTER TABLE films ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100); # a check with between
      - ALTER TABLE books_categories ADD UNIQUE (book_id, category_id); #Add a unique combination of two columns

      List three ways to use the schema to restrict what values can be stored in a column.    
        - Data type (which can include a length limitation)
        - NOT NULL Constraint
        - Check Constraint

    - Create and remove foreign key constraints from a column.
      - As we saw above, foreign key columns allow NULL values. 
        As a result, it is often necessary to use NOT NULL and a foreign key constraint together.

      CREATE TABLE orders (
        id serial PRIMARY KEY,
        product_id integer REFERENCES products (id), # this creates a foreign key
        quantity integer NOT NULL
      );

      OR

      ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES products(id);

      -ALTER TABLE Orders ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID); # adding a foregn key to a column 
      # that clready exists (personid)

      - ALTER TABLE planets ADD COLUMN star_id integer NOT NULL REFERENCES stars (id); # adding a column that thta is defined as a foreign key which references
      # another column in a table and is an integer and not null.


    - WHEN I THINK about cardinality : https://launchschool.com/lessons/1b2f0fb4/assignments/db29d48b and https://launchschool.com/lessons/1b2f0fb4/assignments/088499c6

      - Cardinality refers to the relationship that one table can have with another table. 
        These relationships include: many-to-many, many-to-one/one-to-many, 
        or one-to-one – whichever one of these characteristics a table has in relationship with another table is said to be the cardinality of that table. 

      - Suppose we have three tables that are used by a company to store employee information: an Employee table, an Employee_Salary table, and a Department table. 
        The Department table will have a one to many relationship with the Employee table, because every employee can belong to only one department, 
        but a department can consist of many employees. 
        In other words, the cardinality of the Department table in relationship to the employee table is one to many.

      -  Cardinality refers to the maximum number of times an instance in one entity can be associated with instances in the related entity

      - Modality refers to the minimum number of times an instance in one entity can be associated with an instance in the related entity.

      - https://www.calebcurry.com/blogs/database-design/cardinality-and-modality # great link for cardinality and modality

    On the many side there will be a foreign key that points to the the primary key to the entitiy with a single relationship relationship.

  Sequel

    - Use Sequel to connect to a database.
      -DB = Sequel.connect("postgres://localhost/sequel-single-table") # my own way is a little different, because i have to connect to Sequel over cloud9.
      # I have saved that code in my evernote.

    - Use the Sequel Ruby API to create and execute common queries.
      -  DB.create_table(:people) do # create a table
      ..   primary_key :id
      ..   String :name
      ..   Integer :age
      ..   String :occupation
      .. end

      - DB.tables # see all tables

      - DB[:people].insert(name: "Abby", age: 34, occupation: "biologist") # insert data

      - DB[:people].where(age: 26).first # search for a row using where. .first returns a hash with the first entry.

      - DB[:birds].all # return all rows in a table. .all returns an Array.

      - DB[:birds].select(:name, :family).where(extinct: false).order(Sequel.desc(:length)).all # we select the columns 
       # name and family for the birds table. Then we filter the row where the column extinct is false and only return those.
       # Then we order the remaining rows based on length with the with the longest one at the top.

      - DB[:birds].select(:name, :family).where(extinct: false).order(Sequel.desc(:length)).sql # This is the same command
      # as above, but now it return a sequel string
      => "SELECT \"name\", \"family\" FROM \"birds\" WHERE (\"extinct\" IS FALSE) ORDER BY \"length\" DESC"

      - >> DB[:birds].select do # here we use funtions to return three values using select
        ..   [avg(wingspan), min(wingspan), max(wingspan)]
        .. end.first

      - >> DB.create_table :menu_items do
        ..   primary_key :id # a primary key, self-incrementing
        ..   String :item, unique: true, null: false # this column mast have unique value and cannot be empty
        ..   Integer :prep_time, null: false # cannot be empty
        ..   Numeric :ingredient_cost, size: [4,2], null: false # numeric with a total length of four number and two after the point
        ..   Integer :sales, null: false # cant be nil
        ..   Numeric :menu_price, size: [4,2], null: false # same as above

            constraint(:menu_price_non_negative_constraint) { menu_price >= 0.00 } # adding a constraint, that the menu_price must be more than 0.00 or equal
        .. end

      - result[:profit].to_f # converting a result to a float

      - DB[:tickets].select { count(customer_id).distinct }.first #selecting the count of a distinct row

      - DB[:events].select { [events__name, count(tickets__id)] }.
      .. left_outer_join(:tickets, event_id: :id).
      .. group(:events__id).
      .. order { count(tickets__id) }.reverse.all # performing a left outer join the "__" is equivalent to ".". 
      # So events__id is equivalent to events.id
 
      - DB[:tickets].select do
    ..   [event_name.as(event), events__starts_at, sections__name.as(section), seats__row, seats__number.as(seat)]
    .. end.
    .. join(:events, id: :event_id).
    .. join(:customers, id: :tickets__customer_id).
    .. join(:seats, id: :tickets__seat_id).
    .. join(:sections, id: :seats__section_id).
    .. where(customers__email: "gennaro.rath@mcdermott.co").all # an inner join the end denotes the end of the select block

    - More importantly, Sequel provides the concept of a dataset, which allows queries and parts of queries to be reused 
      and modified as needed.

    - DB.create_table(:customers_services) do
        primary_key :id
        foreign_key :customer_id, :customers, on_delete: :cascade
        foreign_key :service_id, :services # creating a foreign key (service_id) that references another table (services)
      end

    - DB[:services].select{ [description, count(customer_id)]}.join(:customers_services, service_id: :id).group(:description)
      .having{ count(customer_id) > 2}.all # selecting descriptiong and the customer_count for services, then joining it with customers_services
      # grouping it by description and then only selecting the services with a customer count of more than 2.

    - Links for Sequel:
      - http://sequel.jeremyevans.net/documentation.html
      - http://sequel.jeremyevans.net/rdoc/files/doc/cheat_sheet_rdoc.html

    - Dataset
      - Datasets are the primary way Sequel uses to access the database. While most database libraries 
        have specific support for updating all records or only a single record, 
        Sequels ability to represent SQL queries themselves as objects is what gives Sequel most of its power.

      - What a Dataset Represents¶ ↑

        A Dataset can be thought of representing one of two concepts:

        - An SQL query

        - An abstract set of rows and some related behavior

      - One of the core dataset ideas that should be understood is that datasets use a functional style of modification, 
        in which methods called on the dataset return modified copies of the dataset, they dont modify the dataset themselves

      - Datasets are Enumerable objects, so they can be manipulated using any of the Enumerable methods, such as map, inject, etc.

      - Another important thing to realize is that dataset methods that return modified datasets 
        do not execute the datasets code on the database. 
        Only dataset methods that return or yield results will execute the code on the database
        # for example .all and .first

      - Most Dataset methods that users will use can be broken down into two types:

        - Methods that return modified datasets # examples: .select, .from. ahving, .order, .limit, .where

        - Methods that execute code on the database # exmaples: .insert, .update. delete, .all. each, .first

      - Sequel datasets are roughly analogous to SQL statements; 
        each dataset can be thought of as representing the SQL statement needed to accomplish a query or action.

      - .select_all(:tablename) will select all rows from a table:
        - .select_all(:lists)

      - when performing searches on a dataset, the functions do not have to be in perfect order like in a SQL statement

      - Links to Sequel documentation:
        - http://sequel.jeremyevans.net/rdoc/files/doc/sql_rdoc.html
        - http://tutorials.jumpstartlab.com/topics/sql/sequel.html
        - http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html
        - http://sequel.jeremyevans.net/rdoc/classes/Sequel/Dataset.html#DISTINCT
        - http://sequel.jeremyevans.net/rdoc/files/README_rdoc.html
        - http://sequel.jeremyevans.net/rdoc/files/doc/schema_modification_rdoc.html
        - http://sequel.jeremyevans.net/documentation.html
        - http://sequel.jeremyevans.net/rdoc/files/doc/querying_rdoc.html
        - http://sequel.jeremyevans.net/rdoc/files/doc/cheat_sheet_rdoc.html


def create_new_list(list_name)
  @db[:lists].insert(name: list_name)
end

def delete_list(id)
  @db[:todos].where(list_id: id).delete
  @db[:lists].where(id: id).delete
end

def update_list_name(id, new_name)
  @db[:lists].where(id: id).update(name: new_name)
end

def create_new_todo(list_id, todo_name)
  @db[:todos].insert(list_id: list_id, name: todo_name)
end

def delete_todo_from_list(list_id, todo_id)
  @db[:todos].where{(list_id: list_id) & (id: todo_id)}.delete
end

def update_todo_status(list_id, todo_id, new_status)
  @db[:todos].where(id: todo_id, list_id: list_id).update(completed: new_status)
end

def mark_all_todos_as_completed(list_id)
  @db[:todos].where(list_id: list_id).update(completed: true)
end