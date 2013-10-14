module SidekiqSpy
  module Translatable
    
    def t
      {
        divider: {
          left:  "",
          right: "|",
        },
        program: "Sidekiq Spy #{VERSION}",
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
      }
    end
    
  end
end
