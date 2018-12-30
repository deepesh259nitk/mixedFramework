#!/bin/sh

#  universal-script.sh
#  Foo
#
#  Created by Deepesh Kumar Vasthimal on 2018-29-12.
#  Copyright © 2018 objc.io. All rights reserved.

UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal

echo "---------"
echo "Path : ${UNIVERSAL_OUTPUTFOLDER}"
echo "---------"

#!/bin/sh

# iOS universal library build script supporting swift modules inclusive simulator slices

# prevention from running xcodebuild in a recusive way
if [ "true" == ${ALREADYINVOKED:-false} ]; then
echo "RECURSION: Detected, stopping"
else
export ALREADYINVOKED="true"

# output directory for universal framework
UNIVERSAL_OUTPUTFOLDER=${BUILD_DIR}/${CONFIGURATION}-universal
mkdir -p "${UNIVERSAL_OUTPUTFOLDER}/iOS"

# build both device and simulator versions for iOS
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${PROJECT_NAME}"  -sdk iphonesimulator -destination 'platform=iOS Simulator' clean build -UseModernBuildSystem=NO
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${PROJECT_NAME}" -sdk iphoneos clean build -UseModernBuildSystem=NO

# copy the framework structure from iphoneos build to the universal folder
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework" "${UNIVERSAL_OUTPUTFOLDER}/iOS"

# copy existing Swift modules from iphonesimulator build to the universal framework directory
SIMULATOR_SWIFT_MODULES_DIR="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule/"
if [ -d "${SIMULATOR_SWIFT_MODULES_DIR}" ]; then
cp -R "${SIMULATOR_SWIFT_MODULES_DIR}" "${UNIVERSAL_OUTPUTFOLDER}/iOS/${PROJECT_NAME}.framework/Modules/${PROJECT_NAME}.swiftmodule"
fi

# create universal binary file using lipo and place the combined executable in the universal framework directory
lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/iOS/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework/${PROJECT_NAME}"

# intermediate step for copying the framework to the project's directory
mkdir -p "${TMPDIR}/${PROJECT_NAME}/Frameworks/iOS"
cp -R "${UNIVERSAL_OUTPUTFOLDER}/iOS/${PROJECT_NAME}.framework" "${TMPDIR}/${PROJECT_NAME}/Frameworks/iOS"

# create a zip file and move it to the project's directory
cd "${TMPDIR}/${PROJECT_NAME}/Frameworks/iOS"
#zip -r "${PROJECT_NAME}.framework.zip" "${PROJECT_NAME}.framework"
mkdir -p "${PROJECT_DIR}/universal-framework"
mv "${PROJECT_NAME}.framework" "${PROJECT_DIR}/universal-framework"

# optional: show the project's directory in Finder
#open "${PROJECT_DIR}/universal-framework"
fi

