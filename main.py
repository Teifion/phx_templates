import sys
from pathlib import Path

def peform_grouped(parts):
  (appname, modulename, classname, classplural) = parts
  lname = classname.lower()
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
      new_text = convert_text(f.read(), parts)

    fpath_new = fpath.replace("cls", lname)
    with open(f"output/{lname}/{fpath_new}", 'w', encoding="utf8") as f:
      f.write(new_text)

def peform_connector(parts):
  pass


def convert_text(text, parts):
  (appname, modulename, classname, classplural) = parts
  text = text.replace("Appname", appname)
  text = text.replace("appname", appname.lower())
  text = text.replace("Modulename", modulename)
  text = text.replace("modulename", modulename.lower())
  text = text.replace("Classnames", classplural)
  text = text.replace("classnames", classplural.lower())
  text = text.replace("Classname", classname)
  text = text.replace("classname", classname.lower())
  return text

def perform(appname, modulename, classname, classplural, classtype):
  # create output folder tree
  try:
    Path(f"output/{classname.lower()}").mkdir(parents=True)
  except FileExistsError:
    print("Output folder already exists, please remove before recreating")
    exit()

  if classtype == "Grouped":
    peform_grouped((appname, modulename, classname, classplural))
  elif classtype == "Connector":
    peform_connector((appname, modulename, classname, classplural))
  else:
    raise Exception(f"No classtype of {classtype}")

def show_help():
  print("""
usage: python3 main.py Appname Modulename Classname Classplural, Classtype

e.g.: python3 main.py Durandal Game Colony Colonies Grouped

Classtype can be: Grouped, Connector
  """)

def main():
  try:
    (_, appname, modulename, classname, classplural, classtype) = sys.argv
  except ValueError:
    show_help()
    exit()

  perform(appname, modulename, classname, classplural, classtype)

if __name__ == '__main__':
  main()
