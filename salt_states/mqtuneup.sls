copy_mqtuneup_config_file:
  file.managed:
    - name: /etc/venv-salt-minion/minion.d/mqtuneup.conf
    - source: salt:///etc/mqtuneup.conf

Restart Salt Minion:
  cmd.run:
{%- if grains['kernel'] == 'Windows' %}
    - name: 'C:\salt\salt-call.bat --local service.restart salt-minion'
{%- else %}
    - name: 'venv-salt-call --local service.restart salt-minion'
{%- endif %}
    - bg: True
