## dmarcurator

Imports DMARC report XML into SQLite DB.

- [More info on email authentication](https://jl.ly/Email/authcheat.html)

## install

Install sqlite3 bc it's cool and you need it
`brew install sqlite3`

`gem install dmarcurator`

## usage

- Get some DMARC reports in XML and put them in a directory.
- `dmarcurator --db=./dmarc/reports.sqlite --reports-path=./dmarc/reports`

## how to browse db

[SQLite-web](https://github.com/coleifer/sqlite-web) is a deec interface.
