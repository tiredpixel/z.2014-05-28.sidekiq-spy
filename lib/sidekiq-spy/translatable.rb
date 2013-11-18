module SidekiqSpy
  module Translatable
    
    def t
      {
        program: "Sidekiq Spy #{VERSION}",
        menu: {
          inactive: {
            workers: "Workers",
            queues: "qUeues",
          },
          active: {
            workers: "WORKERS",
            queues: "QUEUES",
          },
        },
        redis: {
          connection: "redis:",
          namespace: "namespace:",
          version: "redis version:",
          uptime: "uptime (d):",
          connections: "connections:",
          memory: "memory:",
          memory_peak: "memory peak:",
        },
        sidekiq: {
          busy: "busy:",
          retries: "retries:",
          processed: "processed:",
          enqueued: "enqueued:",
          scheduled: "scheduled:",
          failed: "failed:",
        },
        heading: {
          worker: "WORKER",
          queue: "QUEUE",
          class: "CLASS",
          args: "ARGUMENTS",
          started_at: "STARTED",
        }
      }
    end
    
  end
end
