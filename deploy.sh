# docker and kubectl have been signed into at this pooint

docker build -t tomweidner103/complex-kube-client:latest -t tomweidner103/complex-kube-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomweidner103/complex-kube-server:latest -t tomweidner103/complex-kube-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomweidner103/complex-kube-worker:latest -t tomweidner103/complex-kube-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tomweidner103/complex-kube-client:latest
docker push tomweidner103/complex-kube-server:latest
docker push tomweidner103/complex-kube-worker:latest

docker push tomweidner103/complex-kube-client:$SHA
docker push tomweidner103/complex-kube-server:$SHA
docker push tomweidner103/complex-kube-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment api=tomweidner103/complex-kube-server:$SHA
kubectl set image deployments/client-deployment client=tomweidner103/complex-kube-client:$SHA
kubectl set image deployments/worker-deployment worker=tomweidner103/complex-kube-worker:$SHA