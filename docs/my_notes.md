# Secrets

```bash
#snowflake
ABDUL1337
[abdulwasay@myyahoo.com](mailto:abdulwasay@myyahoo.com)
https://umgjozl-bt58923.snowflakecomputing.com
J3Y6pTGu7Gf7pmx
```



# Using instructor's streamlit app to setup snowflake warehouse



# dbt project setup

- Create a virtual environment
- `dbt debug` will tell us if the whole file system is consistent.
  - If file structure is consistent
  - Forms part of pre-check after `dbt init`. But we used `dbt init --skip-profile=setup <our_prjo_name>`
- `profiles.yml` should be added to `gitignore` or in our case vault.
- `profiles.yml` for this _demo_ purposes is copied into default location`airbnb/profiles.yml`
- There was a blocker that connection error was given but that was because we didn't have `profiles.yml` inside our working directory

```yaml
airbnb:
  outputs:
    dev: #this is the enviro name and only one for now
      type: snowflake 
      account: umgjozl-bt58923 #definitely familiar with this. its unique website in our email
      user: dbt #we saw in snowflake under governance

      role: TRANSFORM #setup in snowflake
      private_key: "-----BEGIN ENCRYPTED PRIVATE KEY-----\nMIIFNTBfBgkqhkiG9w0BBQ0wUjAxBgkqhkiG9w0BBQwwJAQQnTCxkkrRUozTq7J9\n24VUMwICCAAwDAYIKoZIhvcNAgkFADAdBglghkgBZQMEASoEEJSeLQJ4pDTW51nY\nMOVotdgEggTQT4nE4F5CwSPrPdmExlKvPD5z++cKgefEDmY6SSXN4STYcVaHUQqX\nPSGaMc+Y62RYIhU6BE2lALTm6I7Lm53zy1VXEH0u/hWeuBWusG9RGPPwOdmUSbTc\ntI5p1qT31YPm4jyjs1sq6ocCKsdwO10lqOWQtYIOLeZ9aXGE3xQ9e1PljMLrfzPY\nxMHF9zKcd39Aod6cTzsjfk/hDUnEXZhCdfOd2lxe2mCbfcywNXi+HVbJqOdBjzq5\n7zdxrwjTNVNHSJsDX4jBcMIAaCrms+sjfIIg0Uz8ZRR+FX7n8BoRz2ehPnB34+m2\nTnvKitp9+dToRqUE9xRS0BmPNi0RxNdrC0C/3LicUBHJuW2+CfRYOc5QrnaVWppv\nPLuisa2naYDzsuZsMqPj2g5pW4W9rGQrsxp2j5kCJS7OQjRJ/PVS2Tdj+CFpQEqf\n6zVbTrzWM8230acCIfCi4xlzt8G5g5MIY/xnOq8nSzYh7CoaCDhJ65MIGe+jE4t6\nhrbhnCBfLS5lvdtSn9u8TVNQSzhzPlJkULanuRmWPXm9yaOgWIcHk3O7+XTXBawM\nOutdSZI/CMnkXNPd+bqlY6iM1ClepxkLDDIWbaLyl/jSb9wd20ar7wSJJxtLDYDk\n06H7dQiO0ua2+GiY2XkcmJ4HdnPtpEARGdb7mKRbQcG2C3smCIoEV2EgK91NsEF4\nHwS+4SkYgEWAbMCYAfNEExyQCMduo0zdkeYtjVZe3kGJ+BYHnDKyiuK9umonlP8L\nqp+YtI5bRTV932fbBg798pfvu/3ifcOQGLLOAwAMUdKzrIzUJgeKjp7/7IJX7fnS\nqrneF3QTJS6pj0Ri2hQW8bJFXqgf5ws0bZwAn16bf4gS8k47dGq0bz+eYByqhwjt\nhvhoett7WGFfgfkvJp0LGDcfqIln4R7c86WfmPSmMimQ/xWdV3LN8NT0loQQviPY\ns6NlEN8hgrC1nGfqquwVspGsMAVM7LQhMz4vFYbroU4KY+FY0BZwpWggh5MLuIum\n9ajOwk+xjGhQO4uZeFocVh27oHE+5az+8BZNDprzgJS+D7O6oGoyyxLj3B50Deuw\nbDtV8/u0j2TIjOO7ZuJM2tJvxVZodPVONEyJ4sgCYSKJUIWp4I56RdhuvSJCz2Eo\n6D+nVFTwxj8uIePONnWkfM8nLFzIwj6Fp85YivGcDTk5pEDj1mPuxTwolB7K2cqX\nu+sxsMNSpPXB8xVJkJTMm+R7t5wrnd6O91bdgEhb90twY7TZrcGZxz2Ln9QhclsZ\nngCPeSViYDBTc6GD/vVd0I8e1Z3nJxR5iKFYmn0EuUxY/nP6AxrwkXVDtAXvz9gq\n/oNgtAu3Mfl68OP62UJy4TAnAhznxlkRrrHs8NET7psKQY7NItcjbTDhR4FOAxtc\n5NNBDInEQ/1ZDO8gCeGNLpUCJ49mlYWsIbr6fO1FkPYQuO5fUrmm7qqSKon1tQ2y\nau6rF4GOXaGngJaNmaXSvQUPd3vi5gheEFeZ/cEGPc33eI46K5MC0WilHbS7RTp3\nH38rWVrvEMgpRAwGQ8W8OyddehSQ1aJSD6Mgzx+5dIYXv194n54ZP3Cjqk23Y06n\nHV0AHnfJceDhBc9HOPCUoyV+LF0x7vGGONN7/GQjVvWpx2UfcxjF62U=\n-----END ENCRYPTED PRIVATE KEY-----\n"
      private_key_passphrase: q 

      database: AIRBNB #setup airbnb with schema called raw with three tables
      schema: DEV #this is where we want to generate our tables
      threads: 1 #we don't get into parallel execution
      warehouse: COMPUTE_WH #this is the default warehouse
  target: dev # setting this as default target

```

# Project structure

## dbt_project.yml

```yaml

name: 'airbnb' #looks into the profiles.yml
version: '1.0.0' #doesn't matter too much?
profile: 'airbnb'

#these correlate to folders in your dbt project
#can have multiple folders here
model-paths: ["models"] 
analysis-paths: ["analyses"] #sql that needs to be executed manually
test-paths: ["tests"] 
seed-paths: ["seeds"]
macro-paths: ["macros"] #reusable snippets. can extend this array for your own personal macros or for compartmentilization e.g. mymacros, sharedmacros
snapshot-paths: ["snapshots"] #sc2 dimension tables

#execute dbt > creates these folders like target or dbt_packages
#to be removed by `dbt clean` whatever dbt generated
clean-targets:   
  - "target"
  - "dbt_packages"

models:
  airbnb: #corresponds to name of this project
  
  #don't really need this below but kept here for reference
  #this is the example folder actually under "models/example"/my_first_dbt_model.sql; my_second_dbt_model.sql
  #models/exmaples is therefore safe to delete
    example:
      +materialized: view

```

# Understanding the raw tables

## raw_hosts

| column       | meaning                           |
| ------------ | --------------------------------- |
| is_superhost | hosts that have very high reviews |
|              |                                   |

## raw_reviews

| column        | meaning                                                      |
| ------------- | ------------------------------------------------------------ |
| reviewer_name | who is reviewing this listing                                |
| sentiment     | sentiment analytics of the customer who left the review that airbnb listing |



## raw_listings

| column         | meaning                                        |
| -------------- | ---------------------------------------------- |
| minimum_nights | how many nights needed to reserve this listing |
| room_type      | what kind of room is being rented?             |
| host_id        | who is hosting this place?                     |



# Understand the data flow

## what we are building?

* three input tables
* src is source layer. These are prefixed with `src`
* dimension and fact tables
* external tables to <u>be sent to snowflake with dbt</u>
* we will create a bunch of tests which you can see in the lineage as well
* finally all of this feeds to the executive dashboard

# # Models overview

* sql definitions which materialize as tables or views but much more to them
* stored as sql files
* reference other models
* different scripts and macros as well

# Data flow progress

1. Raw layer
2. Staging layer which as src models e.g. renaming columns. This is where are basic checks performed
3. <u>Make sure select works well in snowflake</u>. This is very similar to postgres so idea is to start from sql query idea first in snowflake or postgres.
4. Make column names into business friendly

## # Creating our first model

* cte is standard practice for our for input sources
* models can be organised as you like
* by default all our models will be views
* `dbt run` will check and apply changes automatically. This is the proof

```bash
02:18:51  
02:18:54  1 of 1 START sql view model DEV.src_listings ................................... [RUN]
02:18:54  1 of 1 OK created sql view model DEV.src_listings .............................. [SUCCESS 1 in 0.25s]
```

* We literally created our first src_listing model in snowflake just like that!
* The real point of referring to table itself? 
  * Signifies a transformation step
  * Only need to change in CTE definition if source table changes instead of hunting every occurrence of source name. That would indeed be a big pain.

# Materializations

* View
  * Lightweight
  * Don't want to recreate table at every execution
  * View is just a select which is executed behind the hood
* Table
  * Every time dbt flow is executed the table is recreated
  * Transformed data is there
* Incremental:
  * Still table but for event data e.g. reviews
  * Avoids recreating new table but ingests new data
* Ephemeral (CTE)
  * Converted to CTE in downstream model
  * It won't be in data warehouse per say
  * This is intermediate > not published or public to warehouse

# Core layer

