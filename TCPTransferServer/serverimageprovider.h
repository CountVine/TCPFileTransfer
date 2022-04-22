#ifndef SERVERIMAGEPROVIDER_H
#define SERVERIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QObject>
#include <QImage>

class ServerImageProvider : public QQuickImageProvider
{
public:
    ServerImageProvider();

    QImage *image = nullptr;

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);
};

#endif // SERVERIMAGEPROVIDER_H
