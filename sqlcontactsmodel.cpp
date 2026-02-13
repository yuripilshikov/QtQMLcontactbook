#include "sqlcontactsmodel.h"
#include <QSqlRecord>
#include <QDebug>

SQLContactsModel::SQLContactsModel(QObject *parent) : QSqlTableModel(parent)
{

}


QVariant SQLContactsModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid()) return QVariant();
    if(index.row() >= rowCount()) return QVariant();

    if(role < Qt::UserRole) return QSqlTableModel::data(index, role);

    int columnIndex = role - Qt::UserRole - 1;
    QSqlRecord record = QSqlTableModel::record(index.row());
    return record.value(columnIndex);
}

QHash<int, QByteArray> SQLContactsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[PhoneRole] = "phone";
    roles[EmailRole] = "email";
    roles[AvaIdRole] = "avaid";
    roles[ColorRole] = "ccolor";
    roles[CompanyRole] = "company";
    return roles;
}

void SQLContactsModel::init()
{
    qDebug() << "Init contacts model!";
    setTable("contacts");
    setEditStrategy(QSqlTableModel::OnFieldChange);
    select();
}
