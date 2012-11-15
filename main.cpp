#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QApplication>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif

Q_DECL_EXPORT int main(int argc, char **argv)
{
#ifdef HAS_BOOSTER
    QScopedPointer<QApplication> a(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(MDeclarativeCache::qDeclarativeView());
#else
    QScopedPointer<QApplication> a(new QApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(new QDeclarativeView);
#endif

    QObject::connect(view->engine(), SIGNAL(quit()), a.data(), SLOT(quit()));
    view->setAttribute(Qt::WA_OpaquePaintEvent);
    view->setAttribute(Qt::WA_NoSystemBackground);
    view->viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    view->viewport()->setAttribute(Qt::WA_NoSystemBackground);

    view->setSource(QUrl("qrc:/qml/main.qml"));
    view->showFullScreen();
    return a->exec();
}
