#ifndef BDHELPER_H
#define BDHELPER_H

#include <QObject>
#include <QDebug>
#include <QUrl>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>

class BDHelper : public QObject
{
    Q_OBJECT
public:
    explicit BDHelper(QObject *parent = nullptr);

    Q_INVOKABLE QString connectEmptyDatabase(QString fileurl)
    {
        connectDatabase(fileurl.remove(0, 8) + "/mycontacts.sqlite");
        createTable();
        populateTestData();

        return "ok";
    }

    Q_INVOKABLE QString connectExistingDatabase(QString fileUrl)
    {
        connectDatabase(fileUrl.remove(0, 8));

        return "ok";
    }

    Q_INVOKABLE void printDatabase()
    {
        QSqlDatabase db = QSqlDatabase::database("db");
        QString qstr = "SELECT id, name, phone, email, avaid, color, company FROM contacts;";
        QSqlQuery query(db);
        if(!query.prepare(qstr))
        {
            qDebug() << "Print table query prepare failed: " << db.lastError();
            return;
        }
        if(!query.exec())
        {
            qDebug() << "Print table query execution failed: " << db.lastError();
            return;
        }
        qDebug() << "\n\nPrinting database:";
        qDebug() << "===========================";
        while(query.next())
        {
            qDebug() << QString("%1 %2 %3 %4 %5 %6 %7")
                        .arg(query.value(0).toString())
                        .arg(query.value(1).toString())
                        .arg(query.value(2).toString())
                        .arg(query.value(3).toString())
                        .arg(query.value(4).toString())
                        .arg(query.value(5).toString())
                        .arg(query.value(6).toString());
        }
        qDebug() << "=========================";
    }

private:

    bool connectDatabase(QString fileUrl)
    {
        QSqlDatabase db = QSqlDatabase::database("db");
        db.setDatabaseName(fileUrl);
        if(!db.isValid())
        {
            qDebug() << "Connection is not valid: " << db.lastError();
            return false;
        }
        if(!db.open())
        {
            qDebug() << "Cannot open database: " << db.lastError();
            return false;
        }
        return true;
    }

    bool createTable()
    {
        QSqlDatabase db = QSqlDatabase::database("db");
        QString qstr = "CREATE TABLE IF NOT EXISTS contacts("
                       "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                       "name VARCHAR,"
                       "phone VARCHAR,"
                       "email VARCHAR,"
                       "avaid INTEGER,"
                       "color VARCHAR,"
                       "company VARCHAR);";
        QSqlQuery query(db);
        if(!query.prepare(qstr))
        {
            qDebug() << "Create table query prepare failed: " << db.lastError();
            return false;
        }
        if(!query.exec())
        {
            qDebug() << "Create table query execution failed: " << db.lastError();
            return false;
        }
        return true;
    }

    bool populateTestData()
    {
        QSqlDatabase db = QSqlDatabase::database("db");
        QString qstr = "INSERT INTO contacts(name, phone, email, avaid, color, company)"
                       "VALUES ('SomeName', '8-123-3210', 'somename@factory.ru', 1, '#001000', 'NPO VEKTOR');";
        QSqlQuery query(db);
        if(!query.prepare(qstr))
        {
            qDebug() << "Populate test data query prepare failed: " << db.lastError();
            return false;
        }
        if(!query.exec())
        {
            qDebug() << "Populate test data query execution failed: " << db.lastError();
            return false;
        }
        return true;
    }

public:
    Q_INVOKABLE void helloWorld()
    {
        qDebug() << "Hello from C++!";
    }

    Q_INVOKABLE QString echo(QString value)
    {
        qDebug() << "Echoing: " << value;
        return "Returned " + value;
    }

signals:

};

#endif // BDHELPER_H
