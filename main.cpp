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
//    view.setViewport(new QGLWidget);
    view.showFullScreen();
    return a.exec();
}
