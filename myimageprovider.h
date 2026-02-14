#ifndef MYIMAGEPROVIDER_H
#define MYIMAGEPROVIDER_H
#include <QQuickImageProvider>

class MyImageProvider : public QQuickImageProvider
{
public:
    MyImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;
};

#endif // MYIMAGEPROVIDER_H
