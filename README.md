# Overtime App

## Key requirement: company needs documentation that salaried employees did or did not get overtime each week

## Models
- X Post -> date:date rationale:text
- X User -> Devise
- X AdminUser -> STI
- X AuditLog

## Features:
- X Approval Workflow
- SMS Sending -> link to approval or overtime input - Integrate with Heroku scheduler
- X Administrate admin dashboard
- X Block non admin and guest users
- X Email summary to managers for approval
- X Needs to be documented if employee did not log overtime
- Create audit log for each text message
- Need to update end_date when confirmed

## TODOs:

- Set up Application Mailer email along with an email server (currently set up for sparkpost [setup_mail.rb])