defmodule AppnameWeb.Modulename.ClassnameController do
  use CentralWeb, :controller

  alias Appname.Modulename
  alias Appname.Modulename.Classname
  alias Appname.Modulename.ClassnameLib
  
  plug Bodyguard.Plug.Authorize,
    policy: Appname.Modulename.Classname,
    action: {Phoenix.Controller, :action_name},
    user: {Central.Account.AuthLib, :current_user}

  plug :add_breadcrumb, name: 'Modulename', url: '/appname'
  plug :add_breadcrumb, name: 'Classnames', url: '/appname/classnames'

  def index(conn, params) do
    classnames = Modulename.list_classnames(
      search: [
        membership: conn,
        simple_search: Map.get(params, "s", "") |> String.trim,
      ],
      order: "Name (A-Z)"
    )

    conn
    |> assign(:classnames, classnames)
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id, [
      joins: [:activities, :users],
    ])

    if GroupLib.access?(conn, classname) do
      classname
      |> ClassnameLib.make_favourite
      |> insert_recently(conn)
      
      conn
      |> assign(:classname, classname)
      |> add_breadcrumb(name: "Show: #{classname.name}", url: conn.request_path)
      |> render("show.html")
    else
      conn
      |> put_flash(:warning, "Could not find that classname.")
      |> redirect(to: Routes.appname_classname_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Modulename.change_classname(%Classname{
      icon: "fas fa-" <> StylingHelper.random_icon(),
      colour: StylingHelper.random_colour()
    })

    conn
    |> assign(:changeset, changeset)
    |> assign(:groups, GroupLib.extended_dropdown(conn))
    |> add_breadcrumb(name: "New classname", url: conn.request_path)
    |> render("new.html")
  end

  def create(conn, %{"classname" => classname_params}) do
    group_id = GroupLib.access_or_default(conn, classname_params)
    classname_params = Map.put(classname_params, "group_id", group_id)
    
    case Modulename.create_classname(classname_params) do
      {:ok, _classname} ->
        conn
        |> put_flash(:info, "Classname created successfully.")
        |> redirect(to: Routes.appname_classname_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id)

    if GroupLib.access?(conn, classname) do
      changeset = Modulename.change_classname(classname)

      conn
      |> assign(:classname, classname)
      |> assign(:changeset, changeset)
      |> assign(:groups, GroupLib.extended_dropdown(conn))
      |> add_breadcrumb(name: "Edit: #{classname.name}", url: conn.request_path)
      |> render("edit.html")
    else
      conn
      |> put_flash(:warning, "Could not find that classname.")
      |> redirect(to: Routes.appname_classname_path(conn, :index))
    end
  end

  def update(conn, %{"id" => id, "classname" => classname_params}) do
    classname = Modulename.get_classname!(id)
    
    if GroupLib.access?(conn, classname) do
      group_id = GroupLib.access_or_default(conn, classname_params)
      classname_params = Map.put(classname_params, "group_id", group_id)

      case Modulename.update_classname(classname, classname_params) do
        {:ok, _classname} ->
          conn
          |> put_flash(:info, "Classname updated successfully.")
          |> redirect(to: Routes.appname_classname_path(conn, :index))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "edit.html", classname: classname, changeset: changeset)
      end
    else
      conn
      |> put_flash(:warning, "Could not find that classname.")
      |> redirect(to: Routes.appname_classname_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    classname = Modulename.get_classname!(id)

    if GroupLib.access?(conn, classname) do
      classname
      |> ClassnameLib.make_favourite
      |> remove_recently(conn)

      {:ok, _classname} = Modulename.delete_classname(classname)

      conn
      |> put_flash(:info, "Classname deleted successfully.")
      |> redirect(to: Routes.appname_classname_path(conn, :index))
    else
      conn
      |> put_flash(:warning, "Could not find that classname.")
      |> redirect(to: Routes.appname_classname_path(conn, :index))
    end
  end
end
