#include "client.h"

Client::Client(QObject *parent)
    : QObject{parent}
{
    tcpSocket = new QTcpSocket();
    image = new QImage();
}

void Client::connectToServer(const QString &address, const QString &port)
{
    QHostAddress hostAddress;
    if (hostAddress.setAddress(address)){
        tcpSocket->connectToHost(hostAddress, port.toInt());
        emit connected();
    } else {
        // TO DO: add error message
    }
}

void Client::sendImage(const QUrl& url)
{
    image->load(url.toLocalFile());
    QDataStream imageStream(tcpSocket);
    imageStream.setVersion(QDataStream::Qt_6_2);

    QByteArray arr = QByteArray::fromRawData((const char*)image->bits(), image->sizeInBytes());
    qint64 arrSize = static_cast<qint64>(arr.size());

    qint32 formatInt = QVariant::fromValue(image->format()).toInt();
    qint32 widthInt = image->width();
    qint32 heightInt = image->height();

    tcpSocket->write((const char*)&arrSize, sizeof(arrSize));
    tcpSocket->write((const char*)&formatInt, sizeof(formatInt));
    tcpSocket->write((const char*)&widthInt, sizeof(widthInt));
    tcpSocket->write((const char*)&heightInt, sizeof(heightInt));

    tcpSocket->write(arr);
}

void Client::disconnect()
{
    if (tcpSocket->state() == QTcpSocket::ConnectedState) {
        tcpSocket->disconnect();
        emit disconnected();
    }
}
