# Sidekiq Spy Changelog

This changelog documents the main changes between released versions.
For a full list of changes, consult the commit history.
For many of commits by [tiredpixel](http://www.tiredpixel.com), the commit
message provides information and examples.


## 0.1.0

- first release
- `sidekiq-spy` executable providing: `--url`, `--host`, `--port`, `--database`,
  `--namespace`, `--interval`, `--help`, `--version`
- core Redis statistics: redis, namespace, redis version, uptime (d),
  connections, memory, memory peak
- core Sidekiq statistics: busy, retries, processed, enqueued, scheduled, failed


## 0.2.0

- test fixes for Ruby 1.9.3, which is supported along with Ruby 2.0.0
- a plethora of tests; most of the core is now covered
- command-loop to handle key presses
- `<q>` for quit (in addition to existing `<ctrl>+<c>`)
- smaller sleep increments for faster exit
- content overrun fix
- workers panel (like `Sidekiq::Web` Workers tab), reporting who is up to what
