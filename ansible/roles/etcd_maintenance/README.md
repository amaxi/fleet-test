Example:

- name: Copy cron to cron.d
  ansible.builtin.copy:
    src: "{{ item }}"
    dest: /etc/cron.d/{{ item }}
    owner: root
    group: root
    mode: 0755
  loop:
    - "etcd_cron2"