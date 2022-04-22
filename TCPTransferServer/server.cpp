#include "server.h"

Server::Server(QObject *parent)
    : QObject{parent}
{
    tcpServer = new QTcpServer(this);
    connect(tcpServer, &QTcpServer::newConnection, this, &Server::connectionReceived);
    imageProvider = new ServerImageProvider();
}

Server::~Server()
{
    delete tcpServer;
    delete imageProvider;
}

void Server::startListening(const QString &address, const QString &port)
{
    QHostAddress hostAddress;
    if (hostAddress.setAddress(address)){
        tcpServer->listen(hostAddress, port.toInt());
        emit waiting();
    } else {
        // TO DO: add error message
    }
}

void Server::stopListening()
{
    if (tcpServer->isListening()){
        tcpServer->close();
        emit stopped();
    } else {
        tcpSocket->disconnectFromHost();
        connect(tcpSocket, &QTcpSocket::disconnected, this, &Server::stopped);
    }
}

void Server::connectionReceived()
{
    tcpSocket = tcpServer->nextPendingConnection();
    connect(tcpSocket, &QTcpSocket::readyRead, this, &Server::readImage);
    emit connected();
}

void Server::readImage()
{
    QDataStream imageStream(tcpSocket);
    imageStream.setVersion(QDataStream::Qt_6_2);

    if ( 0 == imageSize ) {
        if ( tcpSocket->bytesAvailable() < (int)sizeof(qint64) + (int)sizeof(qint32)*3 ){
            return;
        }

        imageStream.readRawData((char*)&imageSize, sizeof(imageSize));
        imageStream.readRawData((char*)&imageFormat, sizeof(imageFormat));
        imageStream.readRawData((char*)&imageWidth, sizeof(imageWidth));
        imageStream.readRawData((char*)&imageHeight, sizeof(imageHeight));
    }

    if ( tcpSocket->bytesAvailable() < imageSize ){
        return;
    }

    image = QImage(imageWidth, imageHeight, static_cast<QImage::Format>(imageFormat));

    imageStream.readRawData((char*)image.bits(), imageSize);
    imageProvider->image = &image;
    imageSize = 0;

    emit imageUpdated();
}
