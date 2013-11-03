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
