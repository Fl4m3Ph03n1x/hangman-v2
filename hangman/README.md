# Hangman

This is the Hangman core. It has all the logic of the game, runtime details and a watchdog. 
This application runs a `DynamicSupervisor` that creates and supervises each Hangman game. If a game should crash for some reason,
this nanny will help pick it back up.

Each Hangman game process also `spawn_link`s a watchdog. The watchdog will kill Hangman process if this has not received messages for a long time (we consider the player abandoned the game) to prevent the process from becoming a dangling process.

Overall an very rich app that taught me a lot of things!
## Installation

You can use this application as a local dependency adding it like:

```elixir
def deps do
  [
    {:hangman, path: "../hangman"}
  ]
end
```
## Things I leaned

The Gnome's teachings can be summarized as follows:
- `lib/hangman.ex` is the Public API of this app. 
- `lib/type.ex` is where the types shared amongts the various places of the app are. If a type needs to be used in more than 1 file, it should be there.
- `lib/impl` has the implementation logic of the app. All the code that can be tested, the *Functional Requirements* are there.
- `lib/runtime` has the runtime loic or the *NonFunctional Requirementes*. This is code that deals with SuperVisors, Genservers, etc. 
- The Public API returns an opaque value, the `Hangman.game`. This value is to be passed to the client, but not used by it. This is a hallmark of how functional programming usually works. Think of it as a token that must be passed to every call.
- The `tally` is the information the client can actually relly on and use. 