# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
import rc_resource

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from models.repository import EventModel, AddEventModel

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    event_model = EventModel()
    engine.rootContext().setContextProperty("eventModel", event_model)
    add_event_model = AddEventModel()
    engine.rootContext().setContextProperty("addEventModel", add_event_model)
    qml_file = Path(__file__).resolve().parent / "qml/main.qml"
    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
