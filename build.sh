#!/bin/bash

ARCH=$(uname -m)
branch="mikrobusv2"

if [ -f .builddir ] ; then
	if [ -d ./src ] ; then
		rm -rf ./src || true
	fi

	git clone -b ${branch} https://github.com/vaishnav98/mikrobus ./src --depth=1
	#cd ./src/
	#patch -p1 < ../../0001-bits-to-bitops.patch
	#cd -

	if [ "x${ARCH}" = "xarmv7l" ] ; then
		make_options="CROSS_COMPILE= KDIR=/build/buildd/linux-src release"
	else
		x86_dir="`pwd`/../../normal"
		if [ -f `pwd`/../../normal/.CC ] ; then
			. `pwd`/../../normal/.CC
			make_options="CROSS_COMPILE=${CC} KDIR=${x86_dir}/KERNEL all"
		fi
	fi

	cd ./src/

	make ARCH=arm ${make_options} clean
	echo "make ARCH=arm ${make_options}"
	make ARCH=arm ${make_options}
fi
#
