#!/bin/bash
clave="/home/as/.ssh/id_ed25519"
scp -i "$clave" /home/as/MVAdsis/tests_practicas_AS/practica_4/h.sh as@192.168.56.11:/tmp
ssh -i "$clave" as@192.168.56.11 "bash /tmp/h.sh"
