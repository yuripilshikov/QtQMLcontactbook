#ifndef CONTACT_H
#define CONTACT_H

#include <QObject>
#include <QColor>

class Contact : public QObject
{
    Q_OBJECT

    QString m_name;
    QString m_phone;
    QString m_email;
    int m_avaId;
    QColor m_contactColor;

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString phone READ phone WRITE setPhone NOTIFY phoneChanged)
    Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
    Q_PROPERTY(int avaId READ avaId WRITE setAvaId NOTIFY avaIdChanged)
    Q_PROPERTY(QColor contactColor READ contactColor WRITE setContactColor NOTIFY contactColorChanged)

public:
    explicit Contact(QObject *parent = nullptr);
    Contact(QString const& name, QString const& phone, QString const& email, int avaId, QColor const& color)
        : m_name(name), m_phone(phone), m_email(email), m_avaId(avaId), m_contactColor(color) {}

    QString name() const
    {
        return m_name;
    }

    QString phone() const
    {
        return m_phone;
    }

    QString email() const
    {
        return m_email;
    }

    int avaId() const
    {
        return m_avaId;
    }

    QColor contactColor() const
    {
        return m_contactColor;
    }

public slots:
    void setName(QString name)
    {
        if (m_name == name)
            return;

        m_name = name;
        emit nameChanged(m_name);
    }

    void setPhone(QString phone)
    {
        if (m_phone == phone)
            return;

        m_phone = phone;
        emit phoneChanged(m_phone);
    }

    void setEmail(QString email)
    {
        if (m_email == email)
            return;

        m_email = email;
        emit emailChanged(m_email);
    }

    void setAvaId(int avaId)
    {
        if (m_avaId == avaId)
            return;

        m_avaId = avaId;
        emit avaIdChanged(m_avaId);
    }

    void setContactColor(QColor contactColor)
    {
        if (m_contactColor == contactColor)
            return;

        m_contactColor = contactColor;
        emit contactColorChanged(m_contactColor);
    }

signals:

    void nameChanged(QString name);
    void phoneChanged(QString phone);
    void emailChanged(QString email);
    void avaIdChanged(int avaId);
    void contactColorChanged(QColor contactColor);
};

#endif // CONTACT_H
