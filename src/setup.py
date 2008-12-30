#!/usr/bin/python

if __name__ == "__main__":

	from distutils.core import setup
	#from rocket_frontend import RocketWindow

	setup(name='pyrocket',
		description='Dream Cheeky Rocket Launcher Control',
		long_description='''PyGTK control of the Dream Cheeky Rocket Launcher
	 A PyGTK application to operate the Dream Cheeky Rocket Launcher from Linux,
	 with all the functionality of the bundled Windows app and more! The .deb
	 installer will give user-permissions to the USB device. Automatic detection of
	 the launcher device and a joystick is performed at runtime. The device's limit
	 switches are monitored via USB so as not to damage the turret motors. Several
	 firing options are available, including continuous and pre-charge (for
	 sneak attacks).''',
		author='Karl Ostmo',
		author_email='kostmo@gmail.com',
		url='http://pyrocket.googlecode.com/',
		version='0.5',
		py_modules=['rocket_backend', 'rocket_frontend', 'rocket_webcam', 'rocket_joystick'],
		scripts=['pyrocket'],
	#	data_files=[(RocketWindow.img_path, ['joystick.svg', 'pyrocket.png'])]
		data_files=[('share/pyrocket', ['joystick.svg', 'pyrocket.png', 'msnmissile.png'])]
	)

# ====================================================

def make_rules_file():

	from rocket_backend import RocketControl

	filename = "40-rocketlauncher.rules"
	file_handle = open(filename, "w")

	for ids in RocketControl.vendor_product_ids:
		file_handle.write( 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ACTION=="add", SYSFS{idVendor}=="%04x", SYSFS{idProduct}=="%04x", GROUP="plugdev", MODE="0660"\n' % ids )

	file_handle.close()

