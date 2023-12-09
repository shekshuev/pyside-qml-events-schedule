from PySide6.QtCore import QObject, Property, Slot
from PySide6.QtSql import QSqlQuery
import time

class SingleEventModel(QObject):

    def __init_data(self):
        self.__title = ""
        self.__description = ""
        self.__event_type = "CLASS"
        self.__begin_date = int(time.time())
        self.__end_date = int(time.time())

    def __init__(self, parent=None):
        super(SingleEventModel, self).__init__(parent)
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

