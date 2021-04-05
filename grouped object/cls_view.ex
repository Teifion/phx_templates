defmodule AppnameWeb.Modulename.ClassnameView do
  use AppnameWeb, :view

  @spec colours() :: {String.t(), String.t(), String.t()}
  def colours, do: Appname.Modulename.ClassnameLib.colours()

  @spec icon() :: String.t()
  def icon, do: Appname.Modulename.ClassnameLib.icon()
end
