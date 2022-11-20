docker build -t sarah19990/multi-client:latest -t sarah19990/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sarah19990/multi-server:latest -t sarah19990/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sarah19990/multi-worker:latest -t sarah19990/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sarah19990/multi-client:latest
docker push sarah19990/multi-server:latest
docker push sarah19990/multi-worker:latest

docker push sarah19990/multi-client:$SHA
docker push sarah19990/multi-server:$SHA
docker push sarah19990/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sarah19990/multi-server:$SHA
kubectl set image deployments/client-deployment client=sarah19990/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sarah19990/multi-worker:$SHA