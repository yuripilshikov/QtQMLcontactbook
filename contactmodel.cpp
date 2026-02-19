#include "contactmodel.h"
#include "contact.h"

ContactModel::ContactModel(QObject *parent) : QAbstractListModel(parent)
{
    m_contacts.append(new Contact("Alpha", "+7123321", "alpha@mail.mail", "BlueSphere", QColor("#bbbbbb"), "ACME"));
    m_contacts.append(new Contact("Beta", "+7321123", "beta@mail.mail", "RedCube", QColor("#050505"), "ABC"));
    m_contacts.append(new Contact("Gamma", "+7234432", "gamma@mail.mail", "GreenThorus", QColor("#060606"), "ARC"));
    m_contacts.append(new Contact("Delta", "+7345543", "delta@mail.mail", "VioletCone", QColor("#cccccc"), "FUSION"));
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
    case CompanyRole:
        return m_contacts.at(index.row())->company();
    }
    return QVariant();
}

bool ContactModel::removeRows(int row, int count, const QModelIndex &parent)
{
    beginRemoveRows(QModelIndex(), row, row + count - 1);
    for(int i = row; i < row + count; ++i)
    {
        m_contacts.removeAt(i);
    }
    endRemoveRows();
    return true;
}

QHash<int, QByteArray> ContactModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[NameRole] = "name";
    roles[PhoneRole] = "phone";
    roles[EmailRole] = "email";
    roles[AvaIdRole] = "avatar";
    roles[ColorRole] = "cardColor";
    roles[CompanyRole] = "company";

    return roles;
}

void ContactModel::add()
{
    beginInsertRows(QModelIndex(), m_contacts.size(), m_contacts.size());
    m_contacts.append(new Contact("Delta", "+7345543", "delta@mail.mail", "RedCube", QColor("#cccccc"), "FUSION"));
    endInsertRows();
}

void ContactModel::addItem(QString name, QString phone, QString email, QString Organization, QString avatar)
{
    beginInsertRows(QModelIndex(), m_contacts.size(), m_contacts.size());
    m_contacts.append(new Contact(name, phone, email, avatar, QColor("#cccccc"), Organization));
    endInsertRows();
}

void ContactModel::removeRow(int index)
{
    removeRows(index, 1, QModelIndex());
}

bool ContactModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if(!index.isValid()) return false;

    switch(role)
    {
    case NameRole:
        m_contacts.at(index.row())->setName(value.toString());
    case PhoneRole:
        m_contacts.at(index.row())->setPhone(value.toString());
    case EmailRole:
        m_contacts.at(index.row())->setEmail(value.toString());
    case AvaIdRole:
        m_contacts.at(index.row())->setAvaId(value.toString());
    case ColorRole:
        m_contacts.at(index.row())->setContactColor(value.toString());
    case CompanyRole:
        m_contacts.at(index.row())->setCompany(value.toString());
    default:
        return false;

    }
}

Qt::ItemFlags ContactModel::flags(const QModelIndex &index) const
{
    if(!index.isValid()) return Qt::ItemIsEnabled;
    return QAbstractListModel::flags(index) | Qt::ItemIsEditable;
}
