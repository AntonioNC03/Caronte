config_ssh(){
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/datos/id_ed25519.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}

config_sudoers(){
    if [ -f /etc/sudoers ]
    then 
        #comprobar que el ${USUARIO} No existe
        echo "${USUARIO} ALL=(ALL:ALL) ALL" >> /etc/sudoers
    fi
}

newSSH(){
    #gestion de errores y salida a logs
    config_ssh
    config_sudoers
}