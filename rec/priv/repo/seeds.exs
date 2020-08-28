# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rec.Repo.insert!(%Rec.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Rec.Repo.insert!(%Rec.Library.Snippet{
  title: "IT Crowd",
  text: "Did you try turning it off and on again?",
  steps: 3
})

Rec.Repo.insert!(%Rec.Library.Snippet{title: "The Holy Grail", text: "I got better", steps: 4})
