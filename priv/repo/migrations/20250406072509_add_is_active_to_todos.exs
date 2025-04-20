defmodule MyApp.Repo.Migrations.AddIsActiveToTodos do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :is_active, :boolean, default: true
    end
  end
end

