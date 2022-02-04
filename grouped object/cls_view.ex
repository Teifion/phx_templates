defmodule AppnameWeb.Modulename.ClassnameView do
  use AppnameWeb, :view

  @spec view_colour() :: atom
  def view_colour, do: Appname.Modulename.ClassnameLib.colours()

  @spec icon() :: String.t()
  def icon, do: Appname.Modulename.ClassnameLib.icon()
end
