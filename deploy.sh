docker build -t alexdedmon/multi-client:latest -t alexdedmon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexdedmon/multi-server:latest -t alexdedmon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexdedmon/multi-worker:latest -t alexdedmon/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alexdedmon/multi-client:latest
docker push alexdedmon/multi-server:latest
docker push alexdedmon/multi-worker:latest

docker push alexdedmon/multi-client:$SHA
docker push alexdedmon/multi-server:$SHA
docker push alexdedmon/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=alexdedmon/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexdedmon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexdedmon/multi-worker:$SHA