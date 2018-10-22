defmodule TaskTracker.Repo.Migrations.AlterUser do
    use Ecto.Migration

    def change do
        alter table(:users) do
            add :manager, references(:users, on_delete: :nilify_all)
        end
    end
end
