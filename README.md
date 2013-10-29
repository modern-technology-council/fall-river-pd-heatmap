fall-river-pd-heatmap
=====================

Fall River Police Department Heatmap

Takes input in the form of semi-structured PDFs containing police call logs for a day. Creates an interactive map from this data showing nuisance properties in order to prioritize enforcement efforts.

The project requires Ruby 2.0 and Rails 4

install-postgres.sh will help set up the Postgres database on Ubuntu.

To create the database user, run `sudo -u postgres createuser -sDr fall-river-heatmap-api`

redis is used to remove document parsing from the request-response cycle, to install redis simply use `apt-get install redis-server`

In order to manage the server and workers we use foreman, to install foreman use `gem install foreman`

To start the application run `foreman start`

Contributors:
- Matthew Madonna
- Vanessa Soares
- Joshua Rumbut
