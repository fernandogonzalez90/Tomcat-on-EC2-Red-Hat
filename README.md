# Guía de ejecucion

Este repositorio cuenta con los archivos necesarios para automatizar el despliegue de un servidor Tomcat en RedHat montado en una instancia de EC2 en AWS, y cuenta con dos Archivos principales para esto:

- #### main.tf (Crea la instancia de EC2 en AWS):

  - Par de claves SSH
  - Security Group con los puertos correspondientes
  - Instancia de EC2 con RedHat
  - Output con la IP publica y el puerto para acceder al servicio
  - Local-Exec para configurar hosts.ini y ejecutar Ansible

- #### tomcat_setup.yml (Configura el servidor):
  - Actualiza Red Hat
  - Instala las dependencias necesarias
  - Inicia Tomcat como servicio

Esta guía proporciona instrucciones para instalar Terraform y
Ansible (usando un entorno virtual de Python), configurar la CLI de
AWS y ejecutar Terraform para gestionar tu infraestructura.

### Requisitos Previos

- #### Una cuenta de AWS.

- #### AWS CLI instalado y configurado.

  [Guía de Instalación de AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

  - Ejecuta el siguiente comando para configurar la CLI de AWS:

  - aws configure

  - Necesitarás tu clave de acceso de AWS, clave secreta y región predeterminada.

- #### Un sistema con Linux, macOS o Windows Subsystem for Linux (WSL).

- #### Instalación de Terraform

  - Visita la [Página de Descargas de Terraform](https://developer.hashicorp.com/terraform/downloads).

  - Elige la versión adecuada para tu sistema operativo.

  - Instala Terraform:

  - Extrae el archivo descargado:

    - `unzip terraform_<version>_linux_amd64.zip`

  - Mueve el binario de Terraform a un directorio en el PATH de tu sistema:

    - `sudo mv terraform /usr/local/bin/`

  - Verifica la instalación:

    - `terraform version`

- #### Instalación de Ansible en un Entorno Virtual

  - Instala Python y pip (si no están instalados):

    - `sudo apt update`
    - `sudo apt install python3 python3-pip -y`

  - Crea un entorno virtual para Ansible:

    - `python3 -m venv ansible-env`

  - Activa el entorno virtual:

    - `source ansible-env/bin/activate`

  - Instala Ansible:

    - `pip install ansible`

  - Verifica la instalación de Ansible:

    - `ansible --version`

  - Para desactivar el entorno virtual:

    - `deactivate`

- #### Ejecución de Terraform

  - Inicializa Terraform en el directorio de tu proyecto:

    - `terraform init`

  - Revisa el plan de ejecución:

    - `terraform plan`

  - Aplica los cambios para crear la infraestructura:

    - `terraform apply`

  - Destruye la infraestructura (si es necesario):

    - `terraform destroy`

### Notas

Asegúrate de que la CLI de AWS esté correctamente configurada antes de ejecutar Terraform o Ansible.

Usa el entorno virtual para Ansible para evitar conflictos de dependencias con paquetes de Python instalados globalmente.

Guarda tus credenciales de AWS de manera segura y no las incluyas directamente en scripts o archivos de Terraform.
