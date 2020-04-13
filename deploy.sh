docker build -t andunker/multi-client -f ./client/Dockerfile  ./client
docker build -t andunker/multi-server -f ./server/Dockerfile  ./server
docker build -t andunker/multi-worker -f ./worker/Dockerfile  ./worker

docker push andunker/multi-client
docker push andunker/multi-server
docker push andunker/multi-worker

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=andunker/multi-server