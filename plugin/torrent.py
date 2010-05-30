#!/usr/bin/env python
# -*- coding: utf-8 -*-
import vim
try:
  from hunnyb import encode as benc
  from hunnyb import decode as bdec
except ImportError:
  from BTL.bencode import bencode as benc
  from BTL.bencode import bdecode as bdec
import ConfigParser
try:
  from cStringIO import StringIO
except ImportError:
  from StringIO import StringIO

def ReadTorrentIntoBuffer():
  global bencode
  buffer = vim.current.buffer
  
  torrent = open(buffer.name,'Ur')
  bencode = bdec(torrent.read())
  torrent.close()

  config_file=StringIO()
  config = ConfigParser.RawConfigParser()
  config.add_section('torrent')
  if bencode.has_key('announce-list'):
    config.set('torrent', 'trackers', '\n'+'\n'.join([tracker[0] for tracker in bencode['announce-list']]))
  else:
    config.set('torrent', 'trackers', '\n'+bencode['announce'][0])
  config.write(config_file)
  config_file.seek(0)

  buffer.append(config_file.readlines())
  config_file.close()
  vim.command(':retab')
  if not buffer[0]:
    del buffer[0]
def WriteBufferToTorrent():
  global bencode
  buffer = vim.current.buffer
  config_file=StringIO()

  for line in buffer:
    config_file.write(line + '\n')
  config_file.seek(0)
  config = ConfigParser.ConfigParser()
  config.readfp(config_file)
  config_file.close()
  trackers = config.get('torrent','trackers').split('\n')
  
  bencode['announce-list']=[[tracker] for tracker in trackers if tracker]
  bencode['announce']=bencode['announce-list'][0][0]
  
  torrent = open(buffer.name,'w')
  torrent.write(benc(bencode))
  torrent.close()
