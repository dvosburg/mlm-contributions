copy_mqtuneup_config_file:
  file.managed:
    - name: /etc/venv-salt-minion/minion.d/mqtuneup.conf
    - source: salt:///etc/mqtuneup.conf

Restart Salt Minion:
  cmd.run:
    - name: 'venv-salt-call --local service.restart salt-minion'
    - bg: True
