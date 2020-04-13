docker build -t andunker/multi-client:latest -t andunker/multi-client:$SHA -f ./client/Dockerfile  ./client
docker build -t andunker/multi-server:latest -t andunker/multi-server:$SHA -f ./server/Dockerfile  ./server
docker build -t andunker/multi-worker:latest -t andunker/multi-worker:$SHA -f ./worker/Dockerfile  ./worker

docker push andunker/multi-client:latest
docker push andunker/multi-server:latest
docker push andunker/multi-worker:latest

docker push andunker/multi-client:$SHA
docker push andunker/multi-server:$SHA
docker push andunker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=andunker/multi-client:$SHA
kubectl set image deployments/server-deployment server=andunker/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=andunker/multi-worker:$SHA