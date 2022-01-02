defmodule Dictionary.Runtime.Application do
  use Application

  alias Dictionary.Runtime.Server
  alias Supervisor

  def start(_type, _args) do
    children = [{Server, []}]
    options = [
      name: Dictionary.Runtime.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
