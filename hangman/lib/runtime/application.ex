defmodule Hangman.Runtime.Application do
  use Application

  alias DynamicSupervisor
  alias Hangman.Runtime.Server
  alias Supervisor

  @name GameStarter

  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    supervisor_spec = [
      {DynamicSupervisor, strategy: :one_for_one, name: @name}
    ]

    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  @spec start_game :: {:error, any} | {:ok, pid}
  def start_game, do: DynamicSupervisor.start_child(@name, {Server, nil})
end
