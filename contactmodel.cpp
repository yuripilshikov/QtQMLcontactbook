#include "contactmodel.h"
#include "contact.h"

ContactModel::ContactModel(QObject *parent) : QAbstractListModel(parent)
{
    m_contacts.append(new Contact("Alpha", "+7123321", "alpha@mail.mail", 0, QColor("#bbbbbb")));
    m_contacts.append(new Contact("Beta", "+7321123", "beta@mail.mail", 0, QColor("#050505")));
    m_contacts.append(new Contact("Gamma", "+7234432", "gamma@mail.mail", 0, QColor("#060606")));
    m_contacts.append(new Contact("Delta", "+7345543", "delta@mail.mail", 0, QColor("#cccccc")));
}


int ContactModel::rowCount(const QModelIndex &parent) const
{
    return m_contacts.count();
}

QVariant ContactModel::data(const QModelIndex &index, int role) const
{
    switch(role)
    {
    case NameRole:
        return m_contacts.at(index.row())->name();
    case PhoneRole:
        return m_contacts.at(index.row())->phone();
    case EmailRole:
        return m_contacts.at(index.row())->email();
    case AvaIdRole:
        return m_contacts.at(index.row())->avaId();
    case ColorRole:
        return m_contacts.at(index.row())->contactColor();
    }
    return QVariant();
}

bool ContactModel::removeRows(int row, int count, const QModelIndex &parent)
{
    // todo
}

QHash<int, QByteArray> ContactModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[NameRole] = "name";
    roles[PhoneRole] = "phone";
    roles[EmailRole] = "email";
    roles[AvaIdRole] = "avatar";
    roles[ColorRole] = "cardColor";

    return roles;
}

void ContactModel::changeName(int index)
{
    // todo
}

void ContactModel::changePhone(int index)
{
    // todo
}

void ContactModel::changeEmail(int index)
{
    // todo
}

void ContactModel::changeAvaId(int index)
{
    // todo
}

void ContactModel::changeColor(int index)
{
    // todo
}

void ContactModel::removeRow(int index)
{
    // todo
}
