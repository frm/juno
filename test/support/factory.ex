defmodule Juno.Factory do
  use ExMachina.Ecto, repo: Juno.Repo

  alias Juno.Accounts.User

  def user_factory do
    %User{
      name: Faker.Person.name(),
      username: Faker.Internet.user_name(),
      email: Faker.Internet.safe_email(),
      avatar_url: Faker.Avatar.image_url(),
      oauth_provider: :google,
      oauth_provider_uid: Faker.String.base64(10),
      deleted_at: nil
    }
  end

  def ueberauth_auth_factory do
    %Ueberauth.Auth{
      uid: Faker.String.base64(10),
      provider: "google",
      info: build(:ueberauth_auth_info)
    }
  end

  def ueberauth_auth_info_factory do
    %{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.safe_email(),
      image: Faker.Avatar.image_url()
    }
  end
end
