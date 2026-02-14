#ifndef CONTACTMODEL_H
#define CONTACTMODEL_H

#include <QObject>
#include <QAbstractListModel>

class Contact;

class ContactModel : public QAbstractListModel
{
    Q_OBJECT
    QList<Contact*> m_contacts;
public:
    explicit ContactModel(QObject *parent = nullptr);

    enum ContactRole
    {
        NameRole = Qt::UserRole + 1,
        PhoneRole,
        EmailRole,
        AvaIdRole,
        ColorRole,
        CompanyRole
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool removeRows(int row, int count, const QModelIndex &parent) override;
    QHash<int, QByteArray> roleNames() const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;

    Q_INVOKABLE void add();
    Q_INVOKABLE void addItem(QString name, QString phone, QString email, QString Organization, QString avatar);


};

#endif // CONTACTMODEL_H
