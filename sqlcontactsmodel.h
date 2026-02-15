#ifndef SQLCONTACTSMODEL_H
#define SQLCONTACTSMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <qqml.h>

class SQLContactsModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum ContactRole
    {
        idRole = Qt::UserRole + 1,
        NameRole,
        PhoneRole,
        EmailRole,
        AvaIdRole,
        ColorRole,
        CompanyRole
    };

    explicit SQLContactsModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void init();
    Q_INVOKABLE void add();
    Q_INVOKABLE void addItem(QString name, QString phone, QString email, QString Organization, QString avatar);

signals:



};

#endif // SQLCONTACTSMODEL_H
