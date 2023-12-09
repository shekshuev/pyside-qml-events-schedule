# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import rc_resource

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from models.list_event_model import ListEventModel
from models.single_event_model import SingleEventModel

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    list_event_model = ListEventModel()
    engine.rootContext().setContextProperty("listEventModel", list_event_model)
    single_event_model = SingleEventModel()
    engine.rootContext().setContextProperty("singleEventModel", single_event_model)
    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
