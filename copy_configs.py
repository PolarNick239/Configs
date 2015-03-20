import shutil
import os

home_path = '/home/polarnick/'

repo_path = home_path + 'configs/'

configs = {'/etc/systemd/logind.conf',

		   home_path + '.bashrc',

		   home_path + '.i3/config',
		   home_path + '.i3pystatus.py',
		   home_path + '.i3status.conf'}

for path in configs:
	shutil.copyfile(path, repo_path + path[1:])