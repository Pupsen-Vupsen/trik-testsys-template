# TRIK Testing System deployment guide.

## Introduction

This guide will provide you with the necessary steps to successfully deploy the _TRIK Testing System_ on your server.

## Prerequisites

On your server must be installed next tools:

- `docker`
- `docker-compose`
- `git`

## Deployment steps

- Navigate to the home directory: `cd`.
- Clone the repository: `git clone https://github.com/Pupsen-Vupsen/trik-testsys-template.git`.
- Rename directory with application: `mv trik-testsys-template application`.
- Remove guide directories: `rm -r ./data/submissions/submission1-MUST_BE_REMOVED_BEFORE_START ./data/submissions/submission2-MUST_BE_REMOVED_BEFORE_START`.
- Add important info for application runtime using the [section](#guide) below.
- Start docker daemon.
- Run `run_app.sh` script.

## Guide

This section contains info about Testing System structure and on how you can set up yours.

### Structure

Testing System structure is organized in the next way:

```
application
├── data
│   ├── admins.txt
│   ├── submissions
│   │   ├── 1
│   │   │   ├── hash_pin.txt
│   │   │   ├── pin.txt
│   │   │   ├── results
│   │   │   │   ├── result_test1_1.info
│   │   │   │   └── result_test1_2.info
│   │   │   ├── statement.txt
│   │   │   └── submission.qrs
│   │   └── 2
│   │       ├── hash_pin.txt
│   │       ├── pin.txt
│   │       ├── results
│   │       │   ├── result_test1_1.info
│   │       │   └── result_test1_2.info
│   │       ├── statement.txt
│   │       └── submission.qrs
│   ├── submission.mv.db
│   ├── submit.sqlite
│   ├── tasks
│   │   ├── 1.1:Task
│   │   │   ├── pin.txt
│   │   │   ├── statement.txt
│   │   │   └── tests
│   │   │       ├── test1_1.xml
│   │   │       └── test1_2.xml
│   │   └── 2:Task
│   │       ├── pin.txt
│   │       ├── statement.txt
│   │       └── tests
│   │           └── test2_1.xml
│   └── user.sqlite
├── docker-compose.yml
├── logs
│   ├── bot.txt
│   └── server.log
├── scripts
│   ├── clear_qrs.sh
│   ├── refresh_db.sh
│   ├── refresh_logs.sh
│   ├── run_app.sh
│   └── stop_app.sh
└── secrets
    └── bot_key.txt
```

### Subdirectories

Testing System directory contains the following subdirectories:
- `data`: This directory contains data which is used while application running (databases, tasks files, submissions files etc.).
  - `submissions`: This directory contains info about saved submissions (testing info, submission files).
  - `tasks`: This directory contains info about tasks.
- `logs`: This directory contains telegram-bot and grading-system logs.
- `scripts`: This directory contains scripts for application start/stop and helpful to them.
- `secrets`: This directory contains file with telegram token for bot working.

### Important files

Testing System contains the following important files:
- `docker-compose.yml`: This file is used to run your application via docker-compose (see section [Docker-compose](#docker-compose)).
- `bot-key.txt`: This file contains telegram bot token for bot working.

### Tasks 

```
tasks
├── 1.1:Task
│   ├── pin.txt
│   ├── statement.txt
│   └── tests
│       ├── test1_1.xml
│       └── test1_2.xml
└── 2:Task
    ├── pin.txt
    ├── statement.txt
    └── tests
        └── test2_1.xml
```

Every `tasks` subdirectory must be named like `<Number>:<Name>` where
1. `<Number>` is a string contains only numbers and `.`, starts and ends with number and mustn't have two `.` in a row.
2. `<Name>` is string contains only letters, numbers and delimiters `,`, ` `, `.`, starts and ends with letter.

Also, they must contain 
1. `pin.txt`: The file which contains keys for hash and pin generators. The first number means count of pins, the second – first possible pin. 
For example, this equals to pin range `123–1022`: 
```
900
123
```
2. `statement.txt`: File with simple task statement.
3. `tests`: Subdirectory with `.xml` test files.

### Submissions
```
submissions
├── 1
│   ├── hash_pin.txt
│   ├── pin.txt
│   ├── results
│   │   ├── result_test1_1.info
│   │   └── result_test1_2.info
│   ├── statement.txt
│   └── submission.qrs
└── 2
    ├── hash_pin.txt
    ├── pin.txt
    ├── results
    │   ├── result_test1_1.info
    │   └── result_test1_2.info
    ├── statement.txt
    └── submission.qrs
```

Every submission after saving in Testing System gets its own directory which name is the submission ID, and contains
the next files and directories:
1. `hash_pin.txt`: File with generated hash (first line) and pin (second line).
2. `pin.txt`: Copied pin file.
3. `results`: Directory with result files for each test. For example:
```
[
    {
        "level": "info",
        "message": "Задание выполнено за 16.81 сек!"
    }
]
```
4. `statement.txt`: Copied statement file.
5. `submissions.qrs`: Original submission file.

### Docker-compose

This is the base-version of `docker-compose.yml` for deploying Testing System:

```yaml
version: '3'

services:

  bot:
    restart: always
    image: karasss/trik-testsys-telegram-client:0.4.2
    ports:
      - "6000:6000"
    command: python bot/main.py
    volumes:
      - ~/application/logs:/logs
      - ~/application/data:/data
      - ~/application/data/tasks:/tasks
      - ~/application/secrets:/secrets
    links:
      - testsys:testsys

  testsys:
    restart: always
    image: 5h15h4k1n9/trik-testsys-grading-system:lektorium-v1.1.0 # or your custom grading-system version
    ports:
      - "8080:8080"
    volumes:
      - ~/application/logs:/logs
      - ~/application/data:/data
      - ~/application/data/tasks:/tasks
      - ~/application/data/submissions:/submissions
```

If you want to update TRIK Studio version, downgrade it or anything else you 
can clone [TRIK Testing System Grading System repository](https://github.com/Pupsen-Vupsen/trik-testsys-grading-system/tree/lektorium-v1),
refactor for your needs, build docker-image using Dockerfile, push to Docker Hub and change image in `docker-compose.yml` to your own.


## Additional Resources

- [TRIK Testing System Grading System repository](https://github.com/Pupsen-Vupsen/trik-testsys-grading-system/tree/lektorium-v1)
- [TRIK Testing System Telegram Client repository](https://github.com/Pupsen-Vupsen/trik-testsys-telegram-client)