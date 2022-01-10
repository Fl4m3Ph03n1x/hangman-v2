import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_app, LiveAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JZ9y+7tVLsPvmNpqyA8OPzz6e3YfwuyVSeiJlwTRLYTD4k51P5veQmu0j/GXIrjk",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
