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


# 영구 볼륨 클레임

<br></br>

## Container Storage Interface(CSI Driver)
* 컨테이너 오케스트레이션 엔진과 스토리지 시스템을 연결하는 인터페이스

### 영구볼륨 생성

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: sample
  labels: # 레이블
    type: gce-pv
    environment: stg
  spec:
    capacity: # 용량
      storage: 10Gi
    accessModes: # 접근 모드
    - ReadWriteOnce
    persistentVolumeReclaimPolicy: Retain # Reclaim Policy
    storageClassName: manual # StorageClass
    # Persisitent Volume 플레그인별 설정
    gcePersistentDisk:
      pdName: sample-gce-pv
      fsType: ext4
```

* 접근모드
  * ReadWriteOnce : 단일 노드에서 Read/Write 가능
  * ReadOnlyMany : 여러 노드에서 Read 가능
  * ReadWriteMany : 여러 노드에서 Read/Write 가능
  
  => 단일 파드라 생각하고 개발 필요


* Reclaim Policy
  * 영구 볼륨을 사용한 후 처리 방법을 제어하는 정책
  * Delete : 영구 볼륨 자체가 삭제
  * Retain : 영구볼륨 자체를 삭제하지 않고 유지
  * Recycle : 영구 볼륨 데이터를 삭제하고 재사용 가능한 상태로 만듬.


### 영구 볼륨 클레임 조정을 사용한 볼륨 확장
* aws 기준 awsElasticBlockStore

```yaml
apiversion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: sample-storageclass
parameters:
  type: pd-ssd
provisioner: kubernetes.io/gce-pd
reclaimPolicy: Delete
allowVolumeExpansion: true # 영구 볼륨 크기 조절 옵션
```


