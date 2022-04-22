#include "serverimageprovider.h"

ServerImageProvider::ServerImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
{

}

QImage ServerImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);
    Q_UNUSED(size);
    Q_UNUSED(requestedSize);
    if (nullptr != image) {
        return *image;
    } else {
        return QImage();
    }
}
