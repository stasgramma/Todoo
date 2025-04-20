defmodule Work.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :url, :string
    field :is_active, :boolean
    belongs_to :user, Work.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs \\ %{}) do
    link
    |> cast(attrs, [:url, :user_id, :is_active])
    |> validate_required([:url, :user_id])
  end
end
