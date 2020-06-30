# JenkinsMavenDocker

Instalação do Jenkins utilizando Docker com volume, para garantir persistência (Montagem de um Dockerfile com uma instalação de Jenkins que contemple o Docker e Maven);

# Comandos úteis
Seguem alguns comandos úteis e simples abaixo:

Remover todos os containers sem uso
docker container prune
Parar todos os containers
docker stop $(docker ps -q)
Remover todas as imagens locais
docker image prune
Remove volumes "órfãos"
docker volume prune
Mostra uso de recursos dos containers rodando
docker stats $(docker ps --format {{.Names}})
Listar containers parados
docker ps -f "status=exited"
Acessar terminal do container
docker exec -it container bash
Salvar uma imagem
docker save -o imagem.docker imagem
Carregar imagem
docker load -i imagem.docker
