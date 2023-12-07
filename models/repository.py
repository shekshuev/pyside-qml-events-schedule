from PySide6.QtCore import Qt, QObject, Property, Slot
from PySide6.QtSql import QSqlDatabase, QSqlQuery, QSqlQueryModel
import time

def init():
    conn = QSqlDatabase.addDatabase("QSQLITE")
    conn.setDatabaseName("database.sqlite")
    conn.open()
    QSqlQuery().exec(
        """
        create table if not exists events (
            id integer primary key autoincrement,
            title text not null,
            description text,
            begin_date integer not null,
            end_date integer,
            event_type text not null
        )
        """
    )

class EventModel(QSqlQueryModel):

    def __init__(self, parent=None):
        super(EventModel, self).__init__(parent)
        init()
        self.setQuery("SELECT * FROM events")

    def data(self, index, role=Qt.DisplayRole):
        value = None
        if index.isValid():
            if role < Qt.UserRole:
                value = super(EventModel, self).data(index, role)
            else:
                column_idx = role - Qt.UserRole;
                model_idx = self.index(index.row(), column_idx)
                value = super(EventModel, self).data(model_idx, Qt.DisplayRole)
        return value

    @Slot()
    def refresh(self):
        self.setQuery("SELECT * FROM events")
        self.query().exec()

    def roleNames(self):
        names = {}
        names[hash(Qt.UserRole)] = "id".encode()
        names[hash(Qt.UserRole + 1)] = "title".encode()
        names[hash(Qt.UserRole + 2)] = "description".encode()
        names[hash(Qt.UserRole + 3)] = "begin_date".encode()
        names[hash(Qt.UserRole + 4)] = "end_date".encode()
        names[hash(Qt.UserRole + 5)] = "event_type".encode()
        return names


class AddEventModel(QObject):

    def __init_data(self):
        self.__title = ""
        self.__description = ""
        self.__event_type = "CLASS"
        self.__begin_date = int(time.time())
        self.__end_date = int(time.time())

    def __init__(self, parent=None):
        super(AddEventModel, self).__init__(parent)
        self.__init_data()

    @Slot()
    def save(self):
        query = QSqlQuery()
        query.prepare("insert into events (title, description, begin_date, end_date, event_type) values (?, ?, ?, ?, ?)")
        query.addBindValue(self.__title)
        query.addBindValue(self.__description)
        query.addBindValue(self.__begin_date)
        query.addBindValue(self.__end_date)
        query.addBindValue(self.__event_type)
        query.exec()
        self.__init_data()

    @Property(str)
    def title(self):
        return self.__title

    @title.setter
    def title(self, val):
        self.__title = val

    @Property(str)
    def description(self):
        return self.__description

    @description.setter
    def description(self, val):
        self.__description = val

    @Property(str)
    def event_type(self):
        return self.__event_type

    @event_type.setter
    def event_type(self, val):
        self.__event_type = val

    @Property(str)
    def begin_date(self):
        return self.__begin_date

    @begin_date.setter
    def begin_date(self, val):
        self.__begin_date = val

    @Property(str)
    def end_date(self):
        return self.__end_date

    @end_date.setter
    def end_date(self, val):
        self.__end_date = val

