#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QApplication>
#include <QGLWidget>

int main(int argc, char **argv)
{
    QApplication a(argc, argv);
    QDeclarativeView view;
    QObject::connect(view.engine(), SIGNAL(quit()), &a, SLOT(quit()));
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.showFullScreen();
    view.setAttribute(Qt::WA_OpaquePaintEvent);
    view.setAttribute(Qt::WA_NoSystemBackground);
    view.viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    view.viewport()->setAttribute(Qt::WA_NoSystemBackground);
    return a.exec();
}
