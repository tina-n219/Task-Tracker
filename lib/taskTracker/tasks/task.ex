defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :assigned, :string
    field :complete, :boolean, default: false
    field :desc, :string
    field :duration, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :complete, :duration, :assigned])
    |> validate_required([:title, :desc, :complete, :duration, :assigned])
  end
end
