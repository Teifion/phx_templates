import sys
from pathlib import Path
import re

def get_lname(name):
  name = re.sub(r"([a-z])([A-Z])", r"\1_\2", name)
  return name.lower()

def peform_empty(parts):
  (_, _, appname, modulename, classname, classplural) = parts
  lname = get_lname(classname)
  Path(f"output/{lname}").mkdir(parents=True)
  Path(f"output/{lname}/templates").mkdir(parents=True)
  Path(f"output/{lname}/tests").mkdir(parents=True)

  files = [
    "section_getters.ex",
    "cls_controller.ex",
    "cls.ex",
    "cls_view.ex",
    "cls_lib.ex",
    "templates/edit.html.heex",
    "templates/form.html.heex",
    "templates/index.html.heex",
    "templates/new.html.heex",
    "templates/section_menu.html.heex",
    "templates/show.html.heex",
    "templates/search.html.heex",
    "templates/tab_details.html.heex",
    "tests/section_test.exs",
    "tests/cls_controller_test.exs",
  ]

  for fpath in files:
    with open(f"empty object/{fpath}", 'r', encoding="utf8") as f:
      new_text = convert_empty_text(f.read(), parts)

    fpath_new = fpath.replace("cls", lname)
    with open(f"output/{lname}/{fpath_new}", 'w', encoding="utf8") as f:
      f.write(new_text)

def convert_empty_text(text, parts):
  (_, _, appname, modulename, classname, classplural) = parts
  text = text.replace("Appname", appname)
  text = text.replace("appname", get_lname(appname))
  text = text.replace("Modulename", modulename)
  text = text.replace("modulename", get_lname(modulename))
  text = text.replace("Classnames", classplural)
  text = text.replace("classnames", get_lname(classplural))
  text = text.replace("Classname", classname)
  text = text.replace("classname", get_lname(classname))
  return text

def peform_simple(parts):
  (_, _, appname, modulename, classname, classplural) = parts
  lname = get_lname(classname)
  Path(f"output/{lname}").mkdir(parents=True)
  Path(f"output/{lname}/templates").mkdir(parents=True)
  Path(f"output/{lname}/tests").mkdir(parents=True)

  files = [
    "section_getters.ex",
    "cls_controller.ex",
    "cls.ex",
    "cls_view.ex",
    "cls_lib.ex",
    "templates/edit.html.heex",
    "templates/form.html.heex",
    "templates/index.html.heex",
    "templates/new.html.heex",
    "templates/section_menu.html.heex",
    "templates/show.html.heex",
    "templates/tab_details.html.heex",
    "tests/section_test.exs",
    "tests/cls_controller_test.exs",
  ]

  for fpath in files:
    with open(f"simple object/{fpath}", 'r', encoding="utf8") as f:
      new_text = convert_simple_text(f.read(), parts)

    fpath_new = fpath.replace("cls", lname)
    with open(f"output/{lname}/{fpath_new}", 'w', encoding="utf8") as f:
      f.write(new_text)

def convert_simple_text(text, parts):
  (_, _, appname, modulename, classname, classplural) = parts
  text = text.replace("Appname", appname)
  text = text.replace("appname", get_lname(appname))
  text = text.replace("Modulename", modulename)
  text = text.replace("modulename", get_lname(modulename))
  text = text.replace("Classnames", classplural)
  text = text.replace("classnames", get_lname(classplural))
  text = text.replace("Classname", classname)
  text = text.replace("classname", get_lname(classname))
  return text

def peform_grouped(parts):
  (_, _, appname, modulename, classname, classplural) = parts
  lname = get_lname(classname)
  Path(f"output/{lname}").mkdir(parents=True)
  Path(f"output/{lname}/templates").mkdir(parents=True)
  Path(f"output/{lname}/tests").mkdir(parents=True)

  files = [
    "section_getters.ex",
    "cls_controller.ex",
    "cls.ex",
    "cls_view.ex",
    "cls_lib.ex",
    "templates/edit.html.heex",
    "templates/form.html.heex",
    "templates/index.html.heex",
    "templates/new.html.heex",
    "templates/section_menu.html.heex",
    "templates/show.html.heex",
    "templates/tab_details.html.heex",
    "tests/section_test.exs",
    "tests/cls_controller_test.exs",
  ]

  for fpath in files:
    with open(f"grouped object/{fpath}", 'r', encoding="utf8") as f:
      new_text = convert_grouped_text(f.read(), parts)

    fpath_new = fpath.replace("cls", lname)
    with open(f"output/{lname}/{fpath_new}", 'w', encoding="utf8") as f:
      f.write(new_text)

def convert_grouped_text(text, parts):
  (_, _, appname, modulename, classname, classplural) = parts
  text = text.replace("Appname", appname)
  text = text.replace("appname", get_lname(appname))
  text = text.replace("Modulename", modulename)
  text = text.replace("modulename", get_lname(modulename))
  text = text.replace("Classnames", classplural)
  text = text.replace("classnames", get_lname(classplural))
  text = text.replace("Classname", classname)
  text = text.replace("classname", get_lname(classname))
  return text

def peform_connector(parts):
  (_, _, appname, modulename, part1, part2, part2plural) = parts
  lname = get_lname(part1) + "_" + get_lname(part2)
  Path(f"output/{lname}").mkdir(parents=True)

  files = [
    "section_getters.ex",
    "cls_lib.ex",
  ]

  for fpath in files:
    with open(f"connector object/{fpath}", 'r', encoding="utf8") as f:
      new_text = convert_connector_text(f.read(), parts)

    fpath_new = fpath.replace("cls", lname)
    with open(f"output/{lname}/{fpath_new}", 'w', encoding="utf8") as f:
      f.write(new_text)


def convert_connector_text(text, parts):
  (_, _, appname, modulename, part1, part2, part2plural) = parts
  text = text.replace("Appname", appname)
  text = text.replace("appname", get_lname(appname))
  text = text.replace("Modulename", modulename)
  text = text.replace("modulename", get_lname(modulename))
  text = text.replace("Part1", part1)
  text = text.replace("part1", get_lname(part1))
  text = text.replace("Part2s", part2plural)
  text = text.replace("part2s", get_lname(part2plural))
  text = text.replace("Part2", part2)
  text = text.replace("part2", get_lname(part2))
  return text

def show_help():
  print("""
usage:
  python3 main.py Empty Appname Modulename Classname Classplural
  python3 main.py Simple Appname Modulename Classname Classplural
  python3 main.py Grouped Appname Modulename Classname Classplural
  python3 main.py Connector Appname Modulename Part1 Part2 Part2Plural
  
  Empty: an object with just a name, the most basic type
  Simple: an object without a group_id but includes an icon and colour
  Grouped: an object with a group_id and makes use of the group based permission system
  Connector: an object linking two other objects

e.g.:
  python3 main.py Empty Durandal Game Story Stories
  python3 main.py Simple Durandal Game Story Stories
  python3 main.py Grouped Durandal Game Colony Colonies
  python3 main.py Connector Durandal Game Colony Resource Resources
  
Classtype can be: Empty, Simple, Grouped, Connector
  """)

def main():
  if len(sys.argv) == 1:
    show_help()
    return

  mode = sys.argv[1]

  if mode == "Grouped":
    peform_grouped(sys.argv)
  elif mode == "Connector":
    peform_connector(sys.argv)
  elif mode == "Simple":
    peform_simple(sys.argv)
  elif mode == "Empty":
    peform_empty(sys.argv)
  else:
    raise Exception(f"No classtype of {mode}")


if __name__ == '__main__':
  main()
