#!/bin/bash
#############################
### Create by 2018-05-17
### Paramiko Module install
### Author: Damon
### http://www.jb51.net/article/97655.htm
#############################
PYVERSION="Python-2.7.13"
PyCryptoVer="pycrypto-2.6"
EcdsaVer="ecdsa-0.11"
ParamikoVer="paramiko-1.14.0"
VERSION=$(python --version 2>&1 /dev/null | cut -d ' ' -f 2| cut -d '.' -f 1-2)
echo $VERSION
CUR_DIR=$(pwd)
upgrade_py()
{
if [ $VERSION != '2.6' ];then
    echo "current Python version is $VERSION."
    exit 0
else
    yum -y install gcc gcc-c++ zlib zlib-devel
    rm -rf /usr/src/$PYVERSION
    tar xvf $PYVERSION.tgz -C /usr/src
    cd /usr/src/$PYVERSION && echo "tar ok ..."
    ./configure --prefix=/usr/local/python2.7.13
    make && echo "make ok ..."
    make install && echo "make install ok ..."
    if [ $? -ne 0 ];then
        echo "py upgrade failed..." && exit 1
    else
    mv /usr/bin/python /usr/bin/python2.6.6
    ln -s /usr/local/python2.7.13/bin/python2.7  /usr/bin/python
    python --version
    echo "change yum" && sed -i "s@usr/bin/python@usr/bin/python2.6@g" /usr/bin/yum
    fi
    cd -
fi
}
upgrade_py
#cd /usr/local/src/paramiko
PyCrypto()
{
    rm -rf /usr/src/$PyCryptoVer
    tar xfv $PyCryptoVer.tar.gz -C /usr/src
    cd /usr/src/$PyCryptoVer && echo "tar ok ..."
    python setup.py build && python setup.py install
    if [ $? -eq 0 ];then
    echo "PyCrypto install is ok ..."
    else
    echo "PyCrypto install is failed ..." && exit 2
    fi
    cd -
}
PyCrypto
ecdsa()
{
    rm -rf /usr/src/$EcdsaVer
    tar xfv $EcdsaVer.tar.gz -C /usr/src
    cd /usr/src/$EcdsaVer && echo "tar ok ..."
    python setup.py build && python setup.py install
    if [ $? -eq 0 ];then
    echo "Ecdsa install is ok ..."
    else
    echo "Ecdsa install is failed ..." && exit 3
    fi
    cd -
}
ecdsa
paramiko()
{
    rm -rf /usr/src/$ParamikoVer
    tar xfv $ParamikoVer.tar.gz -C /usr/src
    cd /usr/src/$ParamikoVer && echo "tar ok ..."
    python setup.py build && python setup.py install
    if [ $? -eq 0 ];then
    echo "Paramiko install is ok ..."
    else
    echo "Paramiko install is failed ..." && exit 5
    fi
    cd -
}
paramiko
