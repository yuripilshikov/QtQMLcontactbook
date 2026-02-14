#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "contactmodel.h"
#include "bdhelper.h"
#include "sqlcontactsmodel.h"
#include "myimageprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    ContactModel model;
    SQLContactsModel cmodel;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    engine.rootContext()->setContextProperty("_model", QVariant::fromValue(&model));

    BDHelper bdpelper;
    engine.rootContext()->setContextProperty("_dbhelper", QVariant::fromValue(&bdpelper));
    engine.rootContext()->setContextProperty("_sqlmodel", QVariant::fromValue(&cmodel));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.addImageProvider("myimageprovider", new MyImageProvider());

    engine.load(url);

    return app.exec();
}
