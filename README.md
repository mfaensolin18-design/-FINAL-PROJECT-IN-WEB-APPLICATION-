# Bayanihan Family Clinic: Appointment and Record System

Final project in Web Development (field: Health and Wellness).

A web system that lets a small clinic book appointments without double-booking, keep patient records with visit notes, and view doctor schedules. Front-desk staff and doctors log in with separate roles.

## Folder structure
| Folder | Contents |
| --- | --- |
| `php-version/` | Full system: PHP, MySQL, role-based login (runs on XAMPP) |
| `demo/` | Browser-only demo (HTML, CSS, JavaScript). Open `index.html` directly |
| `docs/` | Documentation (Word), presentation (PowerPoint), ERD image |

## Features
- Login with front-desk and doctor roles
- Dashboard with today's schedule and key counts
- Appointment booking with free and taken time slots; days off are blocked
- Appointment list with status filter; complete or cancel visits
- Patient search, registration, visit notes and printable records
- Doctor weekly schedules and workload

## Run the PHP/MySQL version (XAMPP)
1. Start **Apache** and **MySQL** in the XAMPP Control Panel.
2. Copy the `php-version` folder to `C:\xampp\htdocs\` and rename it `clinic`.
3. Open http://localhost/phpmyadmin, choose **Import**, select `database.sql`, and click Import.
4. Open http://localhost/clinic/install.php once to create the demo users, then delete `install.php`.
5. Open http://localhost/clinic/login.php

| Role | Username | Password |
| --- | --- | --- |
| Front desk | `staff` | `staff123` |
| Doctor | `drsantos` | `doctor123` |

If your MySQL root user has a password, set it in `config.php`.

## Run the browser demo
Open `demo/index.html` in a browser. Data is saved in your browser only. The demo logins are the same as above and are for demonstration only.

## Technologies
HTML5, CSS3, JavaScript, PHP 8 (PDO), MySQL/MariaDB, XAMPP, Git and GitHub.

## Database
Tables: `patients`, `doctors`, `users`, `appointments`, `visit_notes`. A unique rule on doctor, date and time blocks double-booking. See `docs/erd.png`.

## Security notes
Prepared statements, hashed passwords, form tokens and escaped output are used in the PHP version. Change the demo passwords before any real use.
