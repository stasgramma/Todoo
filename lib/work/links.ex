defmodule Work.Links do
  @moduledoc """
  The Links context.
  """

  import Ecto.Query, warn: false
  alias Work.Repo

  alias Work.Links.Link

  @doc """
  Returns the list of links.

  ## Examples

      iex> list_links()
      [%Link{}, ...]

  """

  def get_link(user_id, id) do
    Repo.get_by(Link, id: id, user_id: user_id)
  end

  def list_links(user_id) do
    Repo.all(
      from l in Link,
        where: l.user_id == ^user_id
    )
  end

  defmodule MyApp.Links do
    # ... другие функции

    def update_link(%Link{} = link, attrs) do
      link
      |> Link.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
   Gets a single link.

   Raises `Ecto.NoResultsError` if the Link does not exist.

   ## Examples

       iex> get_link!(123)
       %Link{}

       iex> get_link!(456)
       ** (Ecto.NoResultsError)




  """
  def get_link!(id), do: Repo.get!(Link, id)

  @doc """
  Creates a link.

  ## Examples

      iex> create_link(%{field: value})
      {:ok, %Link{}}

      iex> create_link(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_link(attrs \\ %{}) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a link.

  ## Examples

      iex> update_link(link, %{field: new_value})
      {:ok, %Link{}}

      iex> update_link(link, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_link(%Link{} = link, attrs) do
    link
    |> Link.changeset(attrs)
    |> Repo.update()
  end

  def search_links(user_id, query) do
    from(l in Work.Links.Link,
      where: l.user_id == ^user_id and ilike(l.url, ^"%#{query}%")
    )
    |> Work.Repo.all()
  end

  @doc """
  Deletes a link.

  ## Examples

      iex> delete_link(link)
      {:ok, %Link{}}

      iex> delete_link(link)
      {:error, %Ecto.Changeset{}}

  """
  def delete_link(%Link{} = link) do
    Repo.delete(link)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking link changes.

  ## Examples

      iex> change_link(link)
      %Ecto.Changeset{data: %Link{}}

  """
  def change_link(%Link{} = link, attrs \\ %{}) do
    Link.changeset(link, attrs)
  end
end
