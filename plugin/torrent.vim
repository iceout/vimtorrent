" Description:  Edit torrents using vim <torrent.vim>
" Maintainer:   Kazuo Teramoto <kaz.rag@gmail.com>
" Date:         05/10/2010
" Version:      0.5.5
"
" Needed: hunnyb (python module [http://pypi.python.org/pypi/HunnyB/])
"
" Copyright:    Copyright (C) 2010 Kazuo Teramoto {{{1
"               This program is free software: you can redistribute it and/or
"               modify it under the terms of the GNU General Public License as
"               published by the Free Software Foundation, either version 3 of
"               the License, or (at your option) any later version.
"               
"               This program is distributed in the hope that it will be
"               useful, but WITHOUT ANY WARRANTY; without even the implied
"               warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
"               PURPOSE.  See the GNU General Public License for more details.
"               
"               You should have received a copy of the GNU General Public
"               License along with this program.  If not, see
"               <http://www.gnu.org/licenses/>.
"
" Usage: {{{1
" The human readable format is a config file that can be read by the
" ConfigParser module.
"
" Trackers are listed one per line after a 'trackers:' line. A trailing
" space before the tracker URL is *obligatory*.
"
"1}}}
exec 'pyfile '.expand('<sfile>:p:h').'/torrent.py'
augroup torrent
  autocmd!
  autocmd BufReadCmd *.torrent python ReadTorrentIntoBuffer()
  autocmd BufWriteCmd *.torrent python WriteBufferToTorrent()
  autocmd BufWriteCmd *.torrent set nomod
augroup END
" ------------------------------------------------------------------------------
" vim: fdm=marker
