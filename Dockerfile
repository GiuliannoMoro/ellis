# 1. Usar uma imagem base oficial do Python.
# A versão 'slim' é uma boa escolha por ser mais leve que a padrão.
# O readme.md especifica Python 3.10 ou superior.
FROM python:3.13.5-alpine3.22

# 2. Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .

# 4. Instalar as dependências.
# A flag --no-cache-dir reduz o tamanho final da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Expor a porta em que a aplicação será executada.
EXPOSE 8000

# 7. Comando para iniciar a aplicação com Uvicorn.
# Usar 0.0.0.0 como host torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]