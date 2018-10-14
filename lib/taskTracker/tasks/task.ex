defmodule TaskTracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :assignedTo, :string
    field :completed, :boolean, default: false
    field :desc, :string
    field :duration, :integer
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :desc, :completed, :duration, :assignedTo])
    |> validate_required([:title, :desc, :completed, :duration, :assignedTo])
  end
end
