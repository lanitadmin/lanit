#!/bin/sh
find -name *.rptdesign -type f -exec sed -i 's/org\.comsoft/org\.cp/g' {} \;
find -name *.rptdesign -type f -exec sed -i 's/org\.lanit\.samara/org\.cp/g' {} \;
find -name *.rptdesign -type f -exec sed -i 's/ru\.lanit\.samara/org\.cp/g' {} \;
find -name *.rptdesign -type f -exec sed -i 's/org\.lanit/org\.cp/g' {} \;