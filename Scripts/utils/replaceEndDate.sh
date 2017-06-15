#!/bin/sh
find -name *.rptdesign -type f -exec sed -i 's/конца периода/конца периода, не включительно/g' {} \;
find -name *.rptdesign -type f -exec sed -i 's/Дата окончания/Дата окончания, не включительно/g' {} \;