# Snowflake & SnowSQL Quick Reference

## Overview

Snowflake is a cloud-based data warehouse (SaaS) that separates compute and storage. You interact with it using SnowSQL (CLI).

**Key Concepts:**
- Database & Table: Core objects for storing/querying data
- Loading data: Use CSV files
- Querying: SQL queries

## Requirements

- Database
- Table
- Virtual Warehouse (compute)

Trial accounts have privileges to create objects. `ACCOUNTADMIN` or `SECURITYADMIN` can create users.
If manual updates are prohibited, use the RPM package to install SnowSQL. For Linux/WSL, download the appropriate installer.

Snowflake runs as SaaS, so you choose your cloud provider (where compute & data live).


## Credits & Costs

**Credits** are the currency for compute usage (virtual warehouse). Suspend warehouses when not in use—Snowflake charges by the second.

You pay for:
- **Compute** (main cost)
- **Storage** (lower cost)

Larger warehouses = more compute (CPU/RAM) = higher credit usage.

| **Warehouse Size** | **Credit/Hour** | **Clusters** |
|--------------------|-----------------|--------------|
| X-Small (XS)       | 1               | 1            |
| Small (S)          | 2               | 2            |
| Medium (M)         | 4               | 4            |
| Large (L)          | 8               | 8            |

Warehouse size = compute power, not storage. Storage cost is separate and does not depend on warehouse size.

## Snowflake Architecture

1. **Database (Storage):** Cloud storage (S3, Blob, etc.)
2. **Query (Compute):** Virtual warehouse pulls from storage
3. **Cloud (Management):** Admin/orchestration

Snowflake is fully managed (SaaS): no admin/tuning/scaling required. You just write SQL and load data.

`curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.4/linux_x86_64/snowsql-1.4.<>-linux_x86_64.bash.sig
gpg --verify snowsql-1.4.<>-linux_x86_64.bash.sig snowsql-1.4.<>-linux_x86_64.bash`

## GPG Security Verification

GPG (GNU Privacy Guard) checks authenticity and prevents tampering.
- **Public key:** trusted return address
- **Digital signature:** cryptographic seal

Benefit: Verifies your download wasn't swapped with malware.

**Verify a download:**
```bash
curl -O https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/1.4/linux_x86_64/snowsql-1.4.5-linux_x86_64.bash.sig
gpg --verify snowsql-1.4.5-linux_x86_64.bash.sig snowsql-1.4.5-linux_x86_64.bash
```
Example output:
```
gpg: Good signature from "Snowflake Computing (Snowflake Computing Gpg key) <snowflake_gpg@snowflake.net>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg: There is no indication that the signature belongs to the owner.
Primary key fingerprint: 8564 510C 6D19 3BB0 4E06 0306 2A31 49C8 2551 A34A
```


## Connecting to Snowflake

1. Open a new terminal window
2. Test your connection:
      ```bash
      snowsql -a <account_name> -u <login_name>
      ```
      Enter your password when prompted. Type `!quit` to exit.
3. Add your connection info to `~/.snowsql/config`:
      ```
      accountname = <account_name>
      username = <login_name>
      password = <password>
      ```
4. Connect to Snowflake:
      ```bash
      snowsql
      ```


## Troubleshooting: snowsql not found

If you get "command not found", your shell can't find the executable. Add this to your `~/.bashrc`:
```bash
export PATH="$PATH:$HOME/bin"
source ~/.bashrc
```
This lets your shell check `~/bin` for snowsql.


## Example Login

Account URL: `https://umgjozl-bt58923.snowflakecomputing.com`
Command:
```bash
snowsql -a umgjozl-bt58923 -u abdul1337
```
After login:
```
user-name#(no warehouse)@(no database).(no schema)>
abdul1337#COMPUTE_WH@(no database).(no schema)>
```


## Creating Objects

Check current database and schema:
```sql
SELECT CURRENT_DATABASE(), CURRENT_SCHEMA();
```

Create an X-Small warehouse:
```sql
CREATE OR REPLACE WAREHOUSE sf_tuts_wh WITH
       WAREHOUSE_SIZE = 'X-SMALL'
       AUTO_SUSPEND = 180
       AUTO_RESUME = TRUE
       INITIALLY_SUSPENDED = TRUE;
SELECT CURRENT_WAREHOUSE();
```

## Staging Data Files

**Stage:** Cloud storage for loading/unloading data from tables.

Types:
- Internal stage (default): Each user/table gets one
- External stage: S3, Azure, etc.

Use `file:///` for local files (URI scheme):
```sql
PUT file:///home/abdulw/Downloads/getting-started/employees0*.csv @sf_tuts.public.%emp_basic;
```

List staged files:
```sql
LIST @sf_tuts.public.%emp_basic;
```

**Operators:**
- `@`: Stage locator
- `%`: Internal stage for this table

| **Stage Type** | **Syntax** | **Purpose** |
|---------------|------------|-------------|
| Table Stage   | `@%table_name` | For a specific table |
| User Stage    | `@~`           | Unique to each user |
| Named Stage   | `@stage_name`  | Explicitly created |

Think of a stage as a waiting area for data.

## Loading Staged Data

```sql
COPY INTO emp_basic
      FROM @%emp_basic
      FILE_FORMAT = (type = csv field_optionally_enclosed_by='"')
      PATTERN = '.*employees0[1-5].csv.gz'
      ON_ERROR = 'skip_file';
```

## Dropping Objects

```sql
DROP DATABASE IF EXISTS sf_tuts;
DROP WAREHOUSE IF EXISTS sf_tuts_wh;
```

## Notes

- Internal staging is used in this tutorial
- `%` operator references table storage (stage), not the table itself