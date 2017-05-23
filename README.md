# README

The Ruby gem Æternitas can be found [here](https://github.com/FHG-IMW/aeternitas).

## Set up the project

1. Clone the project to your computer.
1. Open the project.
1. Run `db:setup` which creates the database.

## Manage websites

Regarding the forthcoming election campaign in Germany, the app measures the prominence of two chancellor candidates by counting how often they are mentioned on different websites.

1. Start the rails server, `rails s`.
1. Go to [localhost](http://localhost:3000) to view the app.
1. Since there are no websites in the database yet, create a new website.
1. After creation, you should see some information of the website, especially `last polling: --, next polling: 1970-01-01 00:58:00, state: waiting` tells you that the website has not been polled before. Thus, the next polling date is set to an early default value. The state _waiting_ means that the website is ready to be processed by Sidekiq.

## Process Sidekiq jobs

1. Now open the rails console (`rails c`) and enter `Aeternitas.enqueue_due_pollables` there.
1. You should see that the state of your website changed from _waiting_ to _enqueued_, i.e., it is added to Sidekiq.
1. Start Sidekiq (`sidekiq -q polling -q default`).
1. The website change again. It has been counted how often the lastnames of two candidates occur on the website. Furthermore, The current time is assigend to the attribute _last_polling_ whereby the time of next polling is set to the next day -- as it is specified by `polling_frequency :daily` in `app/models/website.rb`.
1. The dashboard lists the Sidekiq jobs regarding their state.
