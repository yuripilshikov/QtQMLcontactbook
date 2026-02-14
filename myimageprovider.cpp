#include "myimageprovider.h"
#include <QDebug>

MyImageProvider::MyImageProvider() : QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage MyImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    qDebug() << "id: " << id;
    QString str = QString(":/images/images/%1.png").arg(id);

    return QImage(str);
}
