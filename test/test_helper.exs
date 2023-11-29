ExUnit.start()
Faker.start()

Juno.Mock.copy()

Ecto.Adapters.SQL.Sandbox.mode(Juno.Repo, :manual)
