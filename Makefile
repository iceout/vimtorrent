OBJS = plugin/torrent.vim plugin/torrent.py
.SUFFIXES: .vba

build: torrent.vba

distro: torrent.tar.gz

install: torrent.vba
	vim --noplugins -u NONE -U NONE --cmd ':set nocp | :runtime \
		plugin/vimballPlugin.vim' $^ -c ":UseVimball $(shell readlink -f ${DESTDIR} 2>/dev/null)" -c ":q" > /dev/null 2>&1

clean:
	rm -rf torrent.vba torrent.tar.gz

torrent.vba: ${OBJS}
	mkvimball $* $^

torrent.tar.gz: ${OBJS}
	tar cfz $@ $^
