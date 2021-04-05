# Rocket.la Prueba técnica

### Pregunta 1

```bash
source pregunta_1.sh <Nombre del deployment>
```

### Pregunta 2

```bash
./pregunta_2.sh
```

### Pregunta 3

```bash
cd pregunta_3
python manage.py runserver 0.0.0.0:8000
curl -F file=@twoslotgroundpokemons.csv http://localhost:8000/pokemons\?filter=sand
```

### Pregunta 4

```bash
docker build -t rocket_test .
docker run -p 8000:8000 rocket_test
curl -F file=@twoslotgroundpokemons.csv http://localhost:8000/pokemons\?filter=sand
```

### Pregunta 5

repo: [siulpolb/rocket_test](https://hub.docker.com/r/siulpolb/rocket_test)
