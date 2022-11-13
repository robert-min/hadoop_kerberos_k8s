# 쿠버네티스 네트워크
<br></br>


## 쿠버네티스 클러스터 네트워크와 서비스

* 동일한 파드 내에 있는 여러 컨테이너는 동일한 IP 주소를 할당 => localhost
* 다른 파드에 있는 컨테이너와 통신하려면 파드의 IP 주소로 통신 => 파드의 IP 주소

    => 서비스를 사용하면 여러 로드 밸런싱을 자동으로 구성할 수 있음 + 로드 밸런싱의 접속 창구인 앤드포인트도 제공

* 하나의 서비스에 여로 포트 할당 가능

```yaml
apiVersion: v1
kind: Service
metadata:
  name: sample  
spec: 
  type: ClusterIP
  ports:
    - name: "http-port"
      protocal: "TCP"
      port: 8080
      targetPort: 80
    - name: "https-port"
      protocal: "TCP"
      port: 8443
      targetPort: 443
```

* 이름을 사용한 참조
    *  Pod에 포트 이름과 Container 포트를 지정하고
    *  서비스에 targetport를 이름으로 참조

<br></br><br></br>


## 클러스터 내부 DNS와 서비스 디스커버리
* 환경변수를 사용한 서비스 디스커버리
  ```shell
  kubectl exec -it {service.name} --env | grep -i kubernetes
  ```
* DNS A 레코드를 사용한 서비스 디스커버리
* DNS SRV 레코드를 사용한 서비스 디스커버리

=> *namespace 설정? 

=> *target port 설정을 안한듯?
  *  spec.ports[].port : ClusterIP에서 수신할 포트 번호
  *   spec.ports[].targetPort : 목적지 컨테이너 포트 번호

=> NodePort
  * spec.ports[].port : ClusterIP에서 수신할 포트 번호
  * spec.ports[].targetPort : 목적지 컨테이너 포트 번호
  * spec.ports[].nodePort : 모든 쿠버네티스 노드 IP주소에서 수신할 포트 번호
  * NodePort 서비스를 사용하면 ClusterIP도 자동으로 할당 됨

```yaml
# nodeport example
apiVersion: v1
kind: Service
metadata:
  name: sample
spec: 
  type: NodePort
  ports:
    - name: "http-port"
      protocol: "TCP"
      ports: 8080
      targetport: 80
      nodePort: 30080
    selector:
      app: sample-app

```

<br></br><br></br>
