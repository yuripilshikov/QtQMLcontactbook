#include "sqlcontactsmodel.h"
#include <QSqlRecord>
#include <QDebug>
#include <QSqlError>

SQLContactsModel::SQLContactsModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
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
    roles[idRole] = "id";
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
    //setEditStrategy(QSqlTableModel::OnFieldChange);
    setEditStrategy(QSqlTableModel::OnManualSubmit);
    select();
    qDebug() << "Current row count: " << rowCount(); // выводим количество строк
}

void SQLContactsModel::add()
{
//    int currentRows = rowCount();
//    insertRows(currentRows, 1);
//    submitAll();
}

void SQLContactsModel::addItem(QString name, QString phone, QString email, QString Organization, QString avatar)
{
    qDebug() << "C++: Adding row!";
    int row = rowCount();
    if(insertRow(row))
    {
        setData(index(row, 1), name);
        setData(index(row, 2), phone);
        setData(index(row, 3), email);
        setData(index(row, 4), avatar);
        setData(index(row, 5), "#00ffff");
        setData(index(row, 6), Organization);
    }
    if(!submitAll())
    {
        qDebug() << "Error occured: " << lastError().text();
    }
}
