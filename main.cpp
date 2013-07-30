#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif

Q_DECL_EXPORT int main(int argc, char **argv)
{
#ifdef HAS_BOOSTER
    QScopedPointer<QGuiApplication> a(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QQuickView> view(MDeclarativeCache::qQuickView());
#else
    QScopedPointer<QGuiApplication> a(new QGuiApplication(argc, argv));
    QScopedPointer<QQuickView> view(new QQuickView);
#endif

    QObject::connect(view->engine(), SIGNAL(quit()), a.data(), SLOT(quit()));


    view->setSource(QUrl("/usr/share/qmlcalc/main.qml"));
    view->showFullScreen();
    return a->exec();
}
