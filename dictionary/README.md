# Dictionary

This is a Dictionary App using an `Agent`. 
When we start the App, the `Agent` reads the word list into memory. Then other processes can ask it for the random words.
This means you can have multiple dictionary `Agent`s. 

The `Agent` is registered with a `:name`, which in this case is the `__MODULE__`.

## Installation

You can use this application as a local dependency adding it like:

```elixir
def deps do
  [
    {:dictionary, path: "../dictionary"}
  ]
end
```
## Things I leaned

The Gnome's teachings can be summarized as follows:
- `lib/dictionary.ex` is the Public API of this app. 
- `lib/impl` has the implementation logic of the app. All the code that can be tested, the *Functional Requirements* are there.
- `lib/runtime` has the runtime loic or the *NonFunctional Requirementes*. This is code that deals with SuperVisors, Genservers, etc. 
- Agents are a subset of GenServers used mostly for GET and UPDATE operations. If you have a GenServer that only has state and updates it (and does not have to deal with events and messages) then an `Agent` is probably the simpler abstraction you can get.
- A previous version used an attribute to store the `word_list`. This would save the words at compile time thus making the app very efficient, but also very inflexible, because a change to the world list would mean a new compile/deployment.