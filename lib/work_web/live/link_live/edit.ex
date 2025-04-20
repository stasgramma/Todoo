defmodule WorkWeb.LinkLive.Edit do
  use WorkWeb, :live_view
  alias Work.Links

  def mount(%{"id" => id}, _session, socket) do
    user_id = socket.assigns.current_user.id

    case Links.get_link(user_id, id) do
      nil ->
        {:ok, push_navigate(socket, to: "/links")}

      link ->
        changeset = Links.change_link(link)

        socket =
          socket
          |> assign(:form, to_form(changeset))
          |> assign(:link, link)

        {:ok, socket}
    end
  end

  def handle_event("submit", %{"link" => link_params}, socket) do
    link = socket.assigns.link

    case Links.update_link(link, link_params) do
      {:ok, _link} ->
        socket =
          socket
          |> put_flash(:info, "Link updated successfully.")
          |> push_navigate(to: "/links")

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
