import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :html_app, HtmlAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "R3FHQoD6HvuGaIqK71htBNTRcpoG54fe4xGo7EjLlardYCBOVXHrinmC7MRt2m3E",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
