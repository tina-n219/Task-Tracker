defmodule TaskTracker.Assignments.Assignment do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assignments" do
    field :user_id, :id
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(assignment, attrs) do
    assignment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
