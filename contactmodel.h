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
        ColorRole
    };

    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    bool removeRows(int row, int count, const QModelIndex &parent) override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void changeName(int index);
    Q_INVOKABLE void changePhone(int index);
    Q_INVOKABLE void changeEmail(int index);
    Q_INVOKABLE void changeAvaId(int index);
    Q_INVOKABLE void changeColor(int index);
    Q_INVOKABLE void removeRow(int index);
};

#endif // CONTACTMODEL_H
