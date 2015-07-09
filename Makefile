USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
PACKAGE_VERSION=0.0.2
TITLE=msc_dnd
PACKAGE_NAME=${TITLE}
REVERSE_DOMAIN=com.grahamgilbert
PAYLOAD=\
	pack-preflight-submit

build: clean-build
	xcodebuild -configuration Release

clean-build:
	@sudo rm -rf build

l_munki: l_usr_local build
	@sudo mkdir -p ${WORK_D}/usr/local/munki/preflight.d
	@sudo chown root:wheel ${WORK_D}/usr/local/munki/preflight.d

pack-preflight-submit: l_munki l_Applications
	@sudo ${CP} -R "build/Release/Managed Software Center DND.app" ${WORK_D}/Applications/Managed\ Software\ Center\ DND.app
	@sudo chown -R root:wheel ${WORK_D}/Applications/Managed\ Software\ Center\ DND.app
	@sudo ${CP} munki-dnd.py ${WORK_D}/usr/local/munki/preflight.d/munki-dnd.py
	@sudo chown -R root:wheel ${WORK_D}/usr/local/munki/preflight.d/munki-dnd.py
	@sudo chmod -R 755 ${WORK_D}/usr/local/munki/preflight.d/munki-dnd.py
