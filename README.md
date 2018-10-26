# TaskTracker

The Task Tracker, an app to track tasks....

Don't have an account? You can register as a new user, assign yourself a manager and then gain access to the tracker.

As a user, you can create, view, delete, and mark tasks as complete. You may only track your time on a task if you are the user the given task has been assigned to.

Design choices:
- When logged in, you immediately see all the current tasks. The information presented is just the task title and assigned user.
- When creating a task, I chose to only make the task title, description, and assigned user inputs available at this time.
- When viewing a task, you can see all the information regarding that task. 
- When editing, can you see the task title, description, completed, and assigned user fields. If you are the same user that the task is assigned to will you, and only you, be able to see and track the amoun of time it takes to complete a task.

- When choosing to assign a user to a task, I put in a drop down select menu which shows only the registered users because I want the task to only be assigned to an exisiting user.  

- NEW FEATURE WOW: you can now see your user profile! It shows you who you are, who you report to, as well as a table of your udnerlings, their respective tasks (with a link to the task), and the status of the task.
- NEW FEATURE WOAH: you can press a button which will begin tracking your time and you can end that with the press of another button. This is only allowed in the edit button, as you need a task_id to reference for the timeblock resource and the task_id does not exist when creating a task. You can edit the time block if you wish, and delete it or edit it. 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
