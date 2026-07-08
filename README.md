
```markdown
<!-- ============================================================ -->
<!-- FILE: learn_postgresql.md                                    -->
<!-- DESCRIPTION: Comprehensive PostgreSQL Guide for Termux       -->
<!-- HOW TO EDIT: Look for <!-- SECTION: ... START/END --> tags   -->
<!-- ============================================================ -->

# Comprehensive PostgreSQL Guide for Termux 🐘

<!-- NAVIGATION: START -->
## 📑 Table of Contents (Navigation)

1. [Installation & Verification](#-1-installation--verification)
2. [Cluster & Server Setup](#-2-cluster--server-setup)
3. [Server Control (Start/Stop/Status)](#-3-server-control-startstopstatus)
4. [Database Connection & Navigation](#-4-database-connection--navigation)
5. [Database Management (Create/Rename/Drop)](#-5-database-management-createrenamedrop)
6. [Table & Structure Management (DDL)](#-6-table--structure-management-ddl)
7. [Data Manipulation (CRUD - DML)](#-7-data-manipulation-crud---dml)
8. [User & Privileges Management (DCL)](#-8-user--privileges-management-dcl)
9. [Backup & Restore](#-9-backup--restore)
10. [Utilities & Extras](#-10-utilities--extras)
11. [Typical Workflow](#-12-typical-workflow)

<!-- NAVIGATION: END -->

---

<!-- SECTION: INSTALLATION START -->
## ✅ 1. Installation & Verification

> **Goal**: Install PostgreSQL and verify that the environment is ready.

### 1.1 Install the package
```bash
pkg install postgresql
```

1.2 Verify the executables

```bash
which postgres   # Path to the main server
which psql       # Path to the command-line interface
which initdb     # Path to the cluster initialization tool
which pg_ctl     # Path to the server control tool
```

1.3 Check versions

```bash
postgres --version
psql --version
```

1.4 View help pages (for reference)

```bash
postgres --help
psql --help
initdb --help
pg_ctl --help
```

<!-- SECTION: INSTALLATION END -->

---

<!-- SECTION: CLUSTER_SETUP START -->

🗂️ 2. Cluster & Server Setup

Goal: Create a project directory and initialize the PostgreSQL cluster.

2.1 Create a project directory

```bash
mkdir -p ~/postgresqlProjects
cd ~/postgresqlProjects
```

2.2 Initialize a new PostgreSQL cluster

```bash
initdb -D .
```

Note: The -D option specifies the directory where the cluster data will be stored. The dot (.) refers to the current directory.

<!-- You can add advanced initialization settings here (e.g., locale/encoding) -->

<!-- SECTION: CLUSTER_SETUP END -->

---

<!-- SECTION: SERVER_CONTROL START -->

🚀 3. Server Control (Start/Stop/Status)

Goal: Start, stop, and check the status of the PostgreSQL server.

3.1 Start the server (with logging enabled)

```bash
pg_ctl -D . -l logfile start
```

3.2 Check server status

```bash
pg_ctl -D . status
```

3.3 Read the server logs

```bash
cat logfile                # Read the entire log
tail -f logfile            # Follow logs in real-time (useful for debugging)
```

3.4 Stop the server

· Graceful shutdown (waits for queries to finish):
  ```bash
  pg_ctl -D . stop
  ```
· Fast shutdown (terminates queries immediately):
  ```bash
  pg_ctl -D . -m fast stop
  ```

<!-- SECTION: SERVER_CONTROL END -->

---

<!-- SECTION: CONNECTION_NAVIGATION START -->

🔌 4. Database Connection & Navigation

Goal: Connect to the psql shell and navigate between databases.

4.1 Connect to the default database (postgres)

```bash
psql -d postgres
```

To connect to a specific database with a specific user: psql -d db_name -U user_name

4.2 Inside psql - General Information

· Show current connection info:
  ```sql
  \conninfo
  ```
· Show current user:
  ```sql
  SELECT current_user;
  ```
· Show current database:
  ```sql
  SELECT current_database();
  ```

4.3 Display databases and schemas

· List all databases:
  ```sql
  \l
  ```
  (If nothing shows up due to the pager, run \pset pager off first)
· Show databases with their Object IDs (OIDs):
  ```sql
  SELECT oid, datname FROM pg_database;
  ```
· List all schemas:
  ```sql
  \dn
  ```

4.4 Switch between databases

· Connect to a different database:
  ```sql
  \c test
  -- Or:
  \connect test
  ```

4.5 Execute Shell commands without exiting

```sql
\! ls
\! pwd
\! date
\! cat logfile
```

4.6 Change the current working directory (inside psql)

```sql
\cd ..
```

4.7 Exit psql

```sql
\q
```

<!-- SECTION: CONNECTION_NAVIGATION END -->

---

<!-- SECTION: DATABASE_MANAGEMENT START -->

🗄️ 5. Database Management (Create/Rename/Drop)

Goal: Create, rename, and delete databases.

5.1 Create a new database

```sql
CREATE DATABASE test;
```

5.2 Rename a database

```sql
ALTER DATABASE test RENAME TO college;
```

(Make sure no active connections are using the database before renaming)

5.3 Drop (delete) a database

```sql
-- First, connect to a different database (e.g., postgres)
\c postgres
DROP DATABASE test;
-- Or using the safe syntax:
DROP DATABASE IF EXISTS test;
```

<!-- SECTION: DATABASE_MANAGEMENT END -->

---

<!-- SECTION: TABLE_DDL START -->

📋 6. Table & Structure Management (DDL)

Goal: Create, rename, view, and delete tables.

6.1 Create a new table

```sql
CREATE TABLE persons (
  id INT,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  address VARCHAR(255)
);
```

· Create table only if it doesn't already exist:
  ```sql
  CREATE TABLE IF NOT EXISTS persons (
    id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    address VARCHAR(255)
  );
  ```

6.2 Rename a table

```sql
ALTER TABLE person RENAME TO persons;
```

6.3 View table structure

· List tables in the current schema:
  ```sql
  \dt
  ```
· Show details of a specific table:
  ```sql
  \d persons
  ```
· Show extended details (size, comments, etc.):
  ```sql
  \d+ persons
  ```
· SQL query to list tables:
  ```sql
  SELECT table_name
  FROM information_schema.tables
  WHERE table_schema = 'public';
  ```

6.4 Drop (delete) a table

```sql
DROP TABLE persons;
-- Or safely:
DROP TABLE IF EXISTS persons;
```

<!-- SECTION: TABLE_DDL END -->

---

<!-- SECTION: DATA_CRUD START -->

✏️ 7. Data Manipulation (CRUD - DML)

Goal: Insert, query, update, and delete data within tables.

· Insert (CREATE):
  ```sql
  INSERT INTO persons (id, first_name, last_name, address)
  VALUES (1, 'John', 'Doe', 'New York');
  ```
· Query (READ):
  ```sql
  SELECT * FROM persons;
  SELECT first_name, last_name FROM persons WHERE id = 1;
  ```
· Update (UPDATE):
  ```sql
  UPDATE persons SET address = 'Los Angeles' WHERE id = 1;
  ```
· Delete (DELETE):
  ```sql
  DELETE FROM persons WHERE id = 1;
  ```
· Truncate (remove all rows, keep structure):
  ```sql
  TRUNCATE TABLE persons;
  ```

🧠 Most Common Data Types

INT, FLOAT, DOUBLE, DECIMAL, BOOLEAN, VARCHAR, DATE

<!-- SECTION: DATA_CRUD END -->

---

<!-- SECTION: USERS_DCL START -->

👥 8. User & Privileges Management (DCL)

Goal: Create users, grant permissions, and manage roles.

8.1 Create a new user (role)

```sql
CREATE USER jane WITH PASSWORD 'secure123';
-- Or using ROLE:
CREATE ROLE jane WITH LOGIN PASSWORD 'secure123';
```

8.2 Grant access permissions to a database

```sql
GRANT CONNECT ON DATABASE college TO jane;
```

8.3 Grant permissions on a specific table

```sql
-- Grant read, insert, update, and delete:
GRANT SELECT, INSERT, UPDATE, DELETE ON persons TO jane;

-- Grant all privileges:
GRANT ALL PRIVILEGES ON persons TO jane;
```

8.4 Grant database creation privileges

```sql
ALTER USER jane CREATEDB;
```

8.5 Change a user's password

```sql
ALTER USER jane WITH PASSWORD 'new_password';
```

8.6 Drop a user

```sql
DROP USER jane;
-- Or:
DROP ROLE jane;
```

8.7 View users and roles

```sql
\du
-- Or using a query:
SELECT rolname FROM pg_roles;
```

<!-- SECTION: USERS_DCL END -->

---

<!-- SECTION: BACKUP_RESTORE START -->

💾 9. Backup & Restore

Goal: Create backups of databases and restore them later.

9.1 Dump a database to a plain SQL file (Text format)

```bash
pg_dump -d database_name > backup.sql
# With specific user:
pg_dump -U username -d database_name > backup.sql
```

9.2 Dump in custom format (recommended for pg_restore)

```bash
pg_dump -Fc -d database_name > backup.dump
```

9.3 Restore from a plain SQL file

```bash
psql -d database_name < backup.sql
```

9.4 Restore from a custom format file

```bash
pg_restore -d database_name backup.dump
```

<!-- SECTION: BACKUP_RESTORE END -->

---

<!-- SECTION: UTILITIES START -->

🛠️ 10. Utilities & Extras

Goal: Additional commands and configurations to enhance daily workflows.

10.1 Set PGDATA environment variable (to avoid typing -D .)

Add this to your ~/.bashrc or ~/.zshrc:

```bash
export PGDATA=~/postgresqlProjects
```

After that, you can use:

```bash
pg_ctl start -l logfile
pg_ctl status
```

10.2 View database size

```sql
SELECT pg_database_size('database_name') / 1024 / 1024 AS size_mb;
```

10.3 View active connections / processes

```sql
SELECT pid, usename, application_name, client_addr, state, query
FROM pg_stat_activity;
```

10.4 Terminate a stuck process (using PID)

```sql
SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid = 12345;
```

10.5 Performance tuning

Edit the postgresql.conf file located in the data directory to change ports, memory settings, etc.

<!-- SECTION: UTILITIES END -->

---

<!-- SECTION: WORKFLOW START -->

🔁 11. Typical Workflow

Here is the most common daily routine for starting, working, and stopping your session:

```bash
# 1. Navigate to the project directory
cd ~/postgresqlProjects

# 2. Start the server
pg_ctl -D . -l logfile start

# 3. Connect to the default database
psql -d postgres

# 4. (Inside psql) Create a new database and connect to it
CREATE DATABASE test;
\c test

# 5. (Inside psql) Create a table and perform operations
CREATE TABLE persons (id INT, name VARCHAR(100));
INSERT INTO persons VALUES (1, 'Termux User');
SELECT * FROM persons;

# 6. Exit psql
\q

# 7. Stop the server
pg_ctl -D . stop
```

<!-- SECTION: WORKFLOW END -->

---

📝 Final Notes

· All commands are tailored to work within the Termux environment on Android.
· To add new information, simply search for the <!-- SECTION: ... START --> and <!-- SECTION: ... END --> comments and insert your content between them.
· Happy learning and coding with PostgreSQL! 🎉
