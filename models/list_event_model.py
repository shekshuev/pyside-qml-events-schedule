from PySide6.QtCore import Qt, Slot
from PySide6.QtSql import QSqlDatabase, QSqlQuery, QSqlQueryModel

class ListEventModel(QSqlQueryModel):

    def __init__(self, parent=None):
        super(ListEventModel, self).__init__(parent)
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
        self.setQuery("SELECT * FROM events")

    def data(self, index, role=Qt.DisplayRole):
        value = None
        if index.isValid():
            if role < Qt.UserRole:
                value = super(ListEventModel, self).data(index, role)
            else:
                column_idx = role - Qt.UserRole;
                model_idx = self.index(index.row(), column_idx)
                value = super(ListEventModel, self).data(model_idx, Qt.DisplayRole)
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
