#ifndef BDHELPER_H
#define BDHELPER_H

#include <QObject>
#include <QDebug>
#include <QUrl>

#include "databasemethods.h"

class BDHelper : public QObject
{
    Q_OBJECT
public:
    explicit BDHelper(QObject *parent = nullptr);

    Q_INVOKABLE QString connectEmptyDatabase(QString fileurl)
    {
        //if(performConnection(fileurl.remove(0, 8))) // хак :(
        QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE", "db");
        db.setDatabaseName(fileurl.remove(0, 8));
        if(!db.isValid())
        {
            qDebug() << "Connection is not valid: " << db.lastError();
            return "fail";
        }
        if(!db.open())
        {
            qDebug() << "Cannot open database: " << db.lastError();
            return "fail";
        }

        createTable();
        populateTestData();

        return "ok";
    }

private:

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
