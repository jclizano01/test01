Aplica el archivo:
kubectl apply -f web-basica.yaml


Verifica los componentes:
kubectl get deployments -n mi-app-pro
kubectl get pods -n mi-app-pro
kubectl get svc

Como usamos type: LoadBalancer, K3s le asignará una IP interna.
Si estás en local, puedes usar el túnel rápido para verlo en el navegador:

kubectl port-forward svc/mi-servicio-web 8080:80



Explicación rápida de las partes:
apiVersion y kind: Le dicen a Kubernetes qué tipo de objeto estás creando.
metadata: El nombre que tú le das al recurso.
spec: El "estado deseado" (lo que quieres que pase).
labels: Son como etiquetas adhesivas. El Service usa el selector para encontrar a los Pods que tengan la misma etiqueta. 


borrar todo lo creado
kubectl delete -f web-basica.yaml

cambiar de contexto
kubectl config set-context --current --namespace=mi-app-pro

Borrar un Namespace es la forma más rápida y potente de limpiar tu clúster,
porque Kubernetes se encarga de eliminar absolutamente todo lo que haya dentro (Pods, Services, Deployments, ConfigMaps) de un solo golpe.

kubectl delete namespace mi-app-pro


Mira tus 2 pods actuales:
kubectl get pods -n mi-app-pro


Escala a 5 instancias sin tocar el archivo YAML:
kubectl scale deployment mi-servidor-web --replicas=5 -n mi-app-pro

ver los pdos
kubectl get pods -n mi-app-pro -w
-w: observar 

matar pod
kubectl delete pod [NOMBRE_DEL_POD] -n mi-app-pro


kubectl describe pod [NOMBRE_DEL_POD] -n mi-app-pro

kubectl top pods

kubectl top nodes


docker
sudo docker build -t jclizano/mi-web:v1 .

sudo docker push jclizano/mi-web:v1