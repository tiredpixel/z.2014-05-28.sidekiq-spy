# Sidekiq Spy

[![Gem Version](https://badge.fury.io/rb/sidekiq-spy.png)](http://badge.fury.io/rb/sidekiq-spy)
[![Build Status](https://travis-ci.org/tiredpixel/sidekiq-spy.png?branch=master,develop)](https://travis-ci.org/tiredpixel/sidekiq-spy)
[![Code Climate](https://codeclimate.com/github/tiredpixel/sidekiq-spy.png)](https://codeclimate.com/github/tiredpixel/sidekiq-spy)

[Sidekiq](https://github.com/mperham/sidekiq) monitoring in the console.
A bit like Sidekiq::Web. But without the web.

So, Sidekiq is a beautiful thing. :) But if you know the sadness of wanting to
see how your workers are doing at-a-glance when SSHed into a remote box with
no web server, this one's for you. <3

This project is so hot out of the oven you might need mitts. But it's already
functional, with the main statistics from the Sidekiq::Web homepage. In time,
it would be nice to add the Workers, Queues, Retries, and Scheduled tabs, too.

More sleep lost by [tiredpixel](http://www.tiredpixel.com).


## Installation

Install using:

    $ gem install sidekiq-spy


## Usage

View the available options:

    $ sidekiq-spy --help

If you're connecting to `redis://127.0.0.1:6379/0` with no namespace you can
simply:

    $ sidekiq-spy

To use a connection string URL:

    $ sidekiq-spy -u redis://da.example.com:237/42

Or, if you prefer your options like your Hi-Fi:

    $ sidekiq-spy -h da.example.com -p 237 -d 42

Maybe you're using [Resque](https://github.com/resque/resque)? Sssh!
We won't tell anyone! ;) (Resque is awesome, too!)

    $ sidekiq-spy -n resque

That's about it.


## ASCII Art (a.k.a. Screenshot)

    Sidekiq Spy 0.0.1                       |                         01:02:58 +0100
    redis:                               127.0.0.1:6379/0|namespace:
    redis version:      2.6.11|uptime (d):              8|connections:             3
    memory:              4.84M|memory peak:        13.52M|

    busy:                    0|retries:                 0|processed:            1304
    enqueued:                0|scheduled:               0|failed:               1236


## Stay Tuned

We have a [Librelist](http://librelist.com) mailing list!
To subscribe, send an email to <sidekiq.spy@librelist.com>.
To unsubscribe, send an email to <sidekiq.spy-unsubscribe@librelist.com>.
There be [archives](http://librelist.com/browser/sidekiq.spy/).
That was easy.


## Growing Like Flowers

Dear Me, Here is a vague wishlist:

- more tests for the display parts
- Workers table on main page
- Queues page
- Retries page
- Scheduled page
- a little control to go with your monitoring, maybe...


## Contributions

Contributions are embraced with much love and affection!
Please fork the repository and wizard your magic, preferably with plenty of
fairy-dust sprinkled over the tests. ;)
Then send me a pull request. Simples!
If you'd like to discuss what you're doing or planning to do, or if you get
stuck on something, then just wave. :)

Do whatever makes you happy. We'll probably still like you. :)

The latest 'edge' is the `develop` branch.
The latest release is the `master` branch.
Releases are from `develop`, merged into `master`, tagged, and pushed as a gem.
`master` periodically gets merged back into `develop`.

Tests are written using [minitest](https://github.com/seattlerb/minitest),
which is included by default in Ruby 1.9 onwards. To run all tests:

    rake test

Or, if you're of that turn of mind, use [TURN](https://github.com/TwP/turn)
(`gem install turn`):

    turn test/sidekiq-spy/


## Blessing

May you find peace, and help others to do likewise.


## Licence

© [tiredpixel](http://www.tiredpixel.com) 2013.
It is free software, released under the MIT License, and may be redistributed
under the terms specified in `LICENSE`.
