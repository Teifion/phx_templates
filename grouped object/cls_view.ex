defmodule AppnameWeb.Modulename.ClassnameView do
  @moduledoc false
  use AppnameWeb, :view

  @spec view_colour() :: atom
  def view_colour, do: Appname.Modulename.ClassnameLib.colour()

  @spec icon() :: String.t()
  def icon, do: Appname.Modulename.ClassnameLib.icon()
end
