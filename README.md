# Create Image
- copy content of `pot/flavour` to `/usr/local/etc/pot/flavours`
- run `pot create -p bitwarden -b 12.2 -N public-bridge -t single -f bitwarden -f bitwarden-cmd`
- create a snapshot `pot snap -p bitwarden`
- export the image `pot export -p bitwarden -t 0.1`

The Image should be stored on some webserver. Edit `bitwarden.nomad` and point
the path in `config.image` to the webserver.

# Run Job
`nomad job run bitwarden.nomad` - after that the bitwarden service should be
registered in consul (if its setup), otherwise check the allocation-logs for
the port that got mapped to the task.
