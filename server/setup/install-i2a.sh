#!/bin/bash

readonly SCRIPT_DIR=$(dirname "$0")

pushd "${SCRIPT_DIR}/../src" > /dev/null 2>&1
git clone https://github.com/xshellinc/image-to-ascii.git > /dev/null 2>&1

pushd image-to-ascii > /dev/null 2>&1
for py_file in $(ls | grep .py)
do
  2to3 -w "${py_file}" > /dev/null 2>&1
done
sed -i 's#/2#//2#g' converter.py
sed -i 's#pixel_value/color_range#pixel_value//color_range#g' converter.py
sed -i 's/print(ascii_image)/return ascii_image/g' converter_cli.py

popd > /dev/null 2>&1
popd > /dev/null 2>&1
