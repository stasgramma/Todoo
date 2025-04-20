defmodule WorkWeb.LinkLive.Index do
  use WorkWeb, :live_view
  alias Work.Links

  def mount(_params, _session, socket) do
    user_id = socket.assigns.current_user.id

    socket =
      socket
      |> assign(:query, "")
      |> assign(:links, Links.list_links(user_id))

    {:ok, socket}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    link = Work.Links.get_link!(id)
    Work.Links.delete_link(link)

    links = Work.Links.list_links(socket.assigns.current_user.id)
    {:noreply, assign(socket, :links, links)}
  end

  def handle_event("status", %{"id" => id}, socket) do
    # Получаем ссылку по ID
    link = Links.get_link!(id)

    # Инвертируем статус (если был активен - станет неактивным, и наоборот)
    new_status = !link.is_active

    # Пробуем обновить статус
    dbg(new_status)

    case Links.update_link(link, %{is_active: new_status}) do
      # Если обновление прошло успешно
      {:ok, _updated_link} ->
        # Обновляем список ссылок
        links = Links.list_links(socket.assigns.current_user.id)
        # Отправляем обновленный список обратно в сокет
        {:noreply, assign(socket, :links, links)}

      # Если обновление не удалось
      {:error, _changeset} ->
        # Показываем сообщение об ошибке
        {:noreply, put_flash(socket, :error, "Не удалось обновить статус")}
    end
  end

  def handle_event("search", %{"query" => query}, socket) do
    user_id = socket.assigns.current_user.id
    links = Links.search_links(user_id, query)
    {:noreply, assign(socket, query: query, links: links)}
  end
end
