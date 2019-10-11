default:
	cat makefile

unset:
	. unset_content.sh

testvis:
	. set_visible.sh &&  echo google.com | python extract.py || . unset_content.sh

testful:
	. set_full.sh &&  echo google.com | python extract.py || . unset_content.sh
