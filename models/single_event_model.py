from PySide6.QtCore import QObject, Property, Slot, Signal
from PySide6.QtSql import QSqlQuery
import time

class SingleEventModel(QObject):

    def __init__(self, parent=None):
        super(SingleEventModel, self).__init__(parent)
        self.__clear()

    def __clear(self):
        self.__id = 0
        self.__title = ""
        self.__description = ""
        self.__event_type = "CLASS"
        self.__begin_date = int(time.time())
        self.__end_date = int(time.time())

    @Signal
    def title_changed(self):
        pass

    @Signal
    def description_changed(self):
        pass

    @Signal
    def event_type_changed(self):
        pass

    @Signal
    def edited(self):
        pass

    @Slot()
    def save(self):
        query = QSqlQuery()
        if self.__id > 0:
            query.prepare("update events set title = ?, description = ?, begin_date = ?, end_date = ?, event_type = ? where id = ?")
        else:
            query.prepare("insert into events (title, description, begin_date, end_date, event_type) values (?, ?, ?, ?, ?)")
        query.addBindValue(self.__title)
        query.addBindValue(self.__description)
        query.addBindValue(self.__begin_date)
        query.addBindValue(self.__end_date)
        query.addBindValue(self.__event_type)
        if self.__id > 0:
            query.addBindValue(self.__id)
        if query.exec():
            self.edited.emit()
            self.__clear()
        else:
            print(query.lastError().databaseText())

    @Slot(int)
    def load(self, event_id):
        query = QSqlQuery()
        query.prepare("select * from events where id = ?")
        query.addBindValue(event_id)
        if query.exec() and query.next():
            record = query.record()
            self.__id = event_id
            self.__title = record.field(record.indexOf("title")).value()
            self.__description = record.field(record.indexOf("description")).value()
            self.__event_type = record.field(record.indexOf("event_type")).value()
            self.__begin_date = record.field(record.indexOf("begin_date")).value()
            self.__end_date = record.field(record.indexOf("end_date")).value()
            self.title_changed.emit()
            self.description_changed.emit()
            self.event_type_changed.emit()

    @Property(str, notify=title_changed)
    def title(self):
        return self.__title

    @title.setter
    def title(self, val):
        self.__title = val

    @Property(str, notify=description_changed)
    def description(self):
        return self.__description

    @description.setter
    def description(self, val):
        self.__description = val

    @Property(str, notify=event_type_changed)
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

