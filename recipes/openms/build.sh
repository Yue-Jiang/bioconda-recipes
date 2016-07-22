#!/bin/sh

curl -L https://api.github.com/repos/OpenMS/contrib/tarball/e8f628db990010ae67fe2c466544b5ce50a846da | tar zx

#sed -i s/1aecb390311a12330c5a1c8d91cb9ac4cd8e1718/da39a3ee5e6b4b0d3255bfef95601890afd80709/ CMakeLists.txt

ls -l

mv OpenMS-contrib-e8f628d contrib
cd contrib

cmake . -DBUILD_TYPE=SEQAN
cmake . -DBUILD_TYPE=LIBSVM
cmake . -DBUILD_TYPE=XERCESC
cmake . -DBUILD_TYPE=GSL
cmake . -DBUILD_TYPE=BOOST -DNUMBER_OF_JOBS=4
cmake . -DBUILD_TYPE=COINOR
cmake . -DBUILD_TYPE=BZIP2
cmake . -DBUILD_TYPE=GLPK
cmake . -DBUILD_TYPE=EIGEN
cmake . -DBUILD_TYPE=WILDMAGIC

cd ..
mkdir build
cd build
ORIGIN='$ORIGIN'
export ORIGIN
LDFLAGS='-Wl,-rpath,$${ORIGIN}/../lib' cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX -DHAS_XSERVER=OFF -DENABLE_TUTORIALS=OFF -DENABLE_STYLE_TESTING=OFF -DENABLE_UNITYBUILD=OFF -DWITH_GUI=OFF
make OpenMS TOPP UTILS
make install
