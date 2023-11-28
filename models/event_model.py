# This Python file uses the following encoding: utf-8
from PySide6.QtCore import Qt
from PySide6.QtSql import QSqlDatabase, QSqlQuery, QSqlRecord, QSqlTableModel
from models.event_type import EventType
#import time

class EventModel(QSqlTableModel):

    def __init__(self, parent=None):
        super(EventModel, self).__init__(parent)
        self.__conn = QSqlDatabase.addDatabase("QSQLITE")
        self.__conn.setDatabaseName("database.sqlite")
        self.__conn.open()
        QSqlQuery(self.__conn).exec(
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
        self.__model = QSqlTableModel()
        self.__model.setTable("events")
        self.__model.select()
#        query = QSqlQuery(self.__conn)
#        query.prepare("insert into events (title, description, begin_date, end_date, event_type) values (?, ?, ?, ?, ?)")
#        query.addBindValue("title")
#        query.addBindValue("event description here...")
#        query.addBindValue(int(time.time()))
#        query.addBindValue(int(time.time()))
#        query.addBindValue(EventType.CLASS.name)
#        query.exec()


    def data(self, index, role):
        if role < Qt.UserRole:
            return self.__model.data(self, index, role)
        sql_record = self.__model.record()
        sql_record = self.record(index.row())
        return sql_record.value(role - Qt.UserRole)

    def rowCount(self):
        return 1


    def roleMames(self):
        names = {}
        title = "title".encode()
        description = "description".encode()
        begin_date = "begin_date".encode()
        end_date = "end_date".encode()
        event_type = "event_type".encode()

        names[hash(Qt.UserRole)] = title
        names[hash(Qt.UserRole + 1)] = description
        names[hash(Qt.UserRole + 2)] = begin_date
        names[hash(Qt.UserRole + 3)] = end_date
        names[hash(Qt.UserRole + 3)] = event_type

        return names
