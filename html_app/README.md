# HtmlApp

This is a Phoenix Application of a Hangman game. 

## How to play it?

To start a new GameJust go to `/hangman` and press the button!

<p align="center">
  <img height="200" src="./welcome.png">
</p>


To play just put a letter in the input box and make a guess!

<p align="center">
  <img height="300" src="./play_time.png">
</p>

Win or lose, the option is alwaays there!

<p align="center">
  <img height="300" src="./victory.png">
</p>


Each time a new game is started a new `Hangman` server is started, so you can have many Hangman games at the same time!

### See it in action

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/hangman`](http://localhost:4000/hangman) from your browser.
Once started your game will be saved at [`localhost:4000/current`](http://localhost:4000/current). It will remain there until it expires by user inactivity (1 hour default).

## Things I learned

The Gnome's standard is as follows:
 - This app was created with `--no-ecto --no-mailer --no-gettext --no-dashboard`. We don't need them!
 - `lib/html_app` is where the application logic is. Because we have no application logic here, this folder is pretty much empty.
 - `lib/html_app_web` is where all the front end code is. 
 - I deleted `lib/html_app.ex` because it is supposed to hold context for app logic, which we won't have here.
 - `lib/html_app_web/routes.ex` is where the routes are.
 - `lib/html_app_web/controllers` is where that code that gets the requests is. The controller redirects the code to the logic modules, in this case, to the `Hangman` app.
 - To avoid form double posting, I used the Post -> Redirect -> Get methodology for POST and PUT HTTP mehtods (I could also use it for DELETE, but I don't use it in this app). This prevents double posting of data by making a redirection to a status page. It is a security feature and a performance feature. This is why the `new` and `update` functions from `HangmanController` do a redirect at the end.
 - `lib/html_app_web/templates` is where the HTML pages are. These pages also use a templating language that allows for Elixir code to be included. However, it is not a good practice to overwhelm them with Elixir code, in fact, the less the better. Elixir code and helper functions for the templates are stored in `lib/html_app_web/views` folder.
