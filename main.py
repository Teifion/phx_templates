import sys
from pathlib import Path
import re

def get_lname(name):
  name = re.sub(r"([a-z])([A-Z])", r"\1_\2", name)
  return name.lower()

def peform_grouped(parts):
  (_, _, appname, modulename, classname, classplural) = parts
  lname = get_lname(classname)
  Path(f"output/{lname}").mkdir(parents=True)
  Path(f"output/{lname}/templates").mkdir(parents=True)

  files = [
    "section_getters.ex",
    "cls_controller.ex",
    "cls.ex",
    "cls_view.ex",
    "cls_lib.ex",
    "templates/edit.html.eex",
    "templates/form.html.eex",
    "templates/index.html.eex",
    "templates/new.html.eex",
    "templates/section_menu.html.eex",
    "templates/show.html.eex",
    "templates/tab_details.html.eex",
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
  python3 main.py Grouped Appname Modulename Classname Classplural
  python3 main.py Connector Appname Modulename Part1 Part2 Part2Plural

e.g.:
  python3 main.py Grouped Durandal Game Colony Colonies
  python3 main.py Connector Durandal Game Colony Resource Resources

Classtype can be: Grouped, Connector
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
  else:
    raise Exception(f"No classtype of {mode}")


if __name__ == '__main__':
  main()
