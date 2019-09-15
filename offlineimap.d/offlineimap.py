import subprocess

def imap_passwd(account):
	secret_file = "/home/just22/.offlineimaprc.d/%s.imap_passwd.gpg" % account
	return subprocess.check_output(["gpg2", "--quiet", "--no-tty", "--batch", "--decrypt", secret_file]).strip()
