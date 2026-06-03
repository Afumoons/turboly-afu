# Turboly Tasks

A simple Rails task-management web application built for the Turboly coding challenge. Users can register, log in, manage personal tasks, sort the task list, mark tasks as complete, and see a clear alert for tasks due today.

## Tech Stack

- Ruby 3.3.x
- Ruby on Rails 7.2.2.2
- MySQL 8
- Tailwind CSS
- Rails Minitest

## Features

- User registration with secure password hashing (`has_secure_password` + bcrypt)
- Login and logout using Rails sessions
- Per-user task ownership and access control
- Create, view, edit, complete, and delete tasks
- Task fields: description, due date, priority, completion status
- Sorting by due date, description, or priority
- Due-today alert section for actionable tasks
- Responsive Apple-inspired interface for mobile, tablet, and desktop
- Automated model and integration tests
- Brakeman security scan with no warnings

## Setup

### Requirements

- Ruby 3.3.x
- Bundler
- MySQL 8.x
- Node.js, if using Rails/Tailwind development tooling

### Installation

```bash
git clone https://github.com/Afumoons/turboly-afu.git
cd turboly-afu
bundle install
```

### Database

Make sure MySQL is running, then create and migrate the database:

```bash
bin/rails db:create
bin/rails db:migrate
```

The application uses the standard Rails `config/database.yml` MySQL configuration. Adjust local database username/password through your development environment as needed.

### Run Locally

```bash
bin/dev
```

Open the app at:

```text
http://localhost:3000
```

You can register a new account from the landing page, then start adding tasks.

## Test and Quality Checks

Run the automated tests:

```bash
bin/rails test
```

Run Ruby style checks:

```bash
bundle exec rubocop
```

Run the security scan:

```bash
bundle exec brakeman -q
```

Current verified result on the development machine:

- `bin/rails test`: 9 runs, 44 assertions, 0 failures, 0 errors
- `bundle exec rubocop`: 37 files inspected, no offenses detected
- `bundle exec brakeman -q`: 0 security warnings

## Screenshots

UI screenshots are stored in `docs/screenshots/`.

## Challenge Notes

This project is intentionally small and maintainable. It uses Rails conventions, server-rendered views, strong parameters, password hashing, session reset on logout, scoped task queries per user, and tests for the main user flows requested in the challenge.
