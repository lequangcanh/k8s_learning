# Xây dựng 1 web app cơ bản kết nối với MySQL DB

- Dùng docker-composer build 1 web app trên local
- Cài đặt `kompose` - nó sẽ convert docker-compose.yml thành các file deployment config theo service
  - [app-deployment.yaml](/.short_notes/ymls/app-deployment.yaml)
  - [app-service.yaml](/.short_notes/ymls/app-service.yaml)
  - [db-data-persistentvolumeclaim.yaml](.short_notes/ymls/db-data-persistentvolumeclaim.yaml)
  - [db-deployment.yaml](/.short_notes/ymls/db-deployment.yaml)
  - [db-service.yaml](/.short_notes/ymls/db-service.yaml)

## Persistent Volume

- Google Cloud cung cấp 1 Block Storage gọi là GCE Persistent Disks (GCEPD)
- Trong K8s clusters, khi nói về storage tức là chúng ta đang nói về volume. Bất kỳ storage nào mà chúng ta request cho K8s clusters thì gọi là volume
- Persistent Volume là định nghĩa mà chúng ta  map storage của GCE với K8s Cluster
- Các thành phần trong cluster (pod, deployment) sử dụng PV thông qua Persistent Volume Claim (PVC)
- Tóm lại:
  - Volume là 1 cái Storage
  - Khi muốn sử dụng Volume trong K8s Cluster thì chúng ta cần PV. PV nó sẽ yêu cầu truy cập disk cho K8s clusters
  - PV có thể được share trong 1 cluster
  - Pod, Deployment muốn access vào PV thì phải thông qua PVC

### Config Map

- ConfigMap là nơi để lưu trữ tập trung những giá trị config
- ConfigMap là 1 phần của Cluster, nó không liên quan đến Deployment hay Pod
- Tạo 1 ConfigMap

  `kubectl create configmap <configmap-name> --from-literal=<key>=<value>`
- Update configmap

  `kubectl edit configmap <configmap-name>`

## Secret

- Secret tương tự như configmap, tuy nhiên các value sẽ được mã hóa và bảo mật hơn, thường thì dùng lưu password, các key private
- Create secret

  `kubectl create secret <type> <secret-name> --from-literal=<key>=<value>`

  `type` là cách mã hóa, bình thường thì dùng `generic`
