#!/bin/sh

case "$(xset -q|grep LED| awk '{ print $10 }')" in
  "00000000") KBD="US" ;;
  "00001000") KBD="SV" ;;
  *) KBD="??" ;;
esac

echo $KBD
