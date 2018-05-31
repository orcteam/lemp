#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://blog.linuxeye.cn
#
# Notes: OneinStack for CentOS/RadHat 6+ Debian 6+ and Ubuntu 12+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/lj2007331/oneinstack

Install_openSSL102() {
  if [ ! -e "${openssl_install_dir}/lib/libcrypto.a" ]; then
    pushd ${oneinstack_dir}/src > /dev/null
    tar xzf openssl-${openssl_ver}.tar.gz
    pushd openssl-${openssl_ver}
    make clean
    ./config -fPIC --prefix=${openssl_install_dir} --openssldir=${openssl_install_dir}
    make depend
    make -j ${THREAD} && make install
    popd
    if [ -f "${openssl_install_dir}/lib/libcrypto.a" ]; then
      echo "${CSUCCESS}openssl-1.0.2 module installed successfully! ${CEND}"
      /bin/cp cacert.pem ${openssl_install_dir}/cert.pem
      rm -rf openssl-${openssl_ver}
    else
      echo "${CFAILURE}openssl-1.0.2 install failed, Please contact the author! ${CEND}"
      kill -9 $$
    fi
    popd
  fi
}
