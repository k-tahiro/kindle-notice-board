#!/bin/bash

git clone https://github.com/xshellinc/image-to-ascii.git

pushd image-to-ascii
for py_file in $(ls | grep converter)
do
  2to3 -w "${py_file}"
done
sed -i 's#/#//#g' converter.py
sed -i 's/print(ascii_image)/return ascii_image/g' converter_cli.py
popd
