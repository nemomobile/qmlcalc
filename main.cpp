#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QApplication>

#ifdef HAS_BOOSTER
#include <MDeclarativeCache>
#endif
#include <QtDeclarative>

#include "calcengine.h"

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

    CalcEngine* calcEng = new CalcEngine();
    QDeclarativeContext* rootContext = view->rootContext();
    rootContext->setContextProperty("calcOpEngine", calcEng);

    return a->exec();
}
