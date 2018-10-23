defmodule TaskTracker.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    belongs_to :manager, TaskTracker.Users.User
    timestamps()
  end

  # regex from https://gist.github.com/mgamini/4f3a8bc55bdcc96be2c6 for email format
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :manager_id])
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
  end
end
