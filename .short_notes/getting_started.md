# Getting Started

## Clusters

- Máy ảo của GCP gọi là Compute Engine
- Máy ảo của K8s gọi là Nodes
- Cluster là tập hợp của các nodes và master node
  * Node để chạy các ứng dụng gọi là worker nodes hoặc nodes
  * Node để quản lý là Master node
- Khi tạo các node, K8s sẽ cần 1 khoảng không gian nhỏ để quản lý các node, chính vì vậy dung lượng avaiable sẽ nhỏ hơn lúc đăng ký node
- Resize số node của cluster về 0 khi không dùng để tránh mất tiền

  `gcloud container clusters resize --zone <zone-name> <cluster-name> --num-nodes=0`

- Tạo deployment

  `kubectl create deployment <deploy-name> --image=<image-name>`

- Expose deployment

  `kubectl expose deployment <deploy-name> --type=LoadBalancer --port=<port-number>`

- Xem log events

  `kubectl get events --sort-by=.metadata.creationTimestamp`

## Pod

- Pod là đơn vị deploy nhỏ nhất
- Mỗi pod có 1 IP duy nhất
- Mỗi pod có thể chứa nhiều Container
- Mỗi node có thể chứa nhiều pod

## Replicaset

- Replicaset định nghĩa số pods chắc chắn đang chạy
- Replicaset theo dõi pods, nếu số pods đang chạy ít hơn thì sẽ bật pod mới lên
- Set replicaset

  `kubectl scale deployment <deploy-name> --replicas=<num-of-replicas>`

## Deployment

- Deployment đảm bảo có thể update new release với zero downtime
- Deployment sẽ update từng pod 1, khi 1 pod v2 running thì mới down 1 pod v1
- Set new release cho deployment (container-name mặc định sẽ là tên của deploy-name)

  `kubectl set image deployment <deploy-name> <container-name>=<image>`

## Service

- Service cung cấp 1 cái gọi là giao diện ra bên ngoài của application đang chạy trong pod. Vì pod không cố định có thể create, down liên tục
- Service cho phép application nhận traffic thông qua 1 IP Address dài hạn
- Service được tạo ra khi expose deployment thông qua LoadBalancer của GCP Network
- K8s cũng là 1 Service có type là ClusterIP. Type này chỉ cho phép access từ bên trong cluster, không thể access từ bên ngoài cluster

## Nodes

- Master node sẽ có 4 thành phần chính
  * Distribute Database (etcd) - Đây là component quan trọng nhất, nó lưu tất cả các config, event, ... thường thì nó sẽ được tạo thêm bản sao chứ không lưu trên 1 Database duy nhất
  * API Server (kube-apiserver) - Xử lý các request gửi tới, như lệnh kubectl
  * Scheduler (kube-scheduler) - Lên kế hoạch, kiểm tra độ khả dụng, độ cân bằng của các nodes và quyết định pod sẽ chạy trên node nào
  * Controller Manager (kube-controller-manager) - Quản lý healthy của cluster

- Điều quan trong là application sẽ chắc chắn không chạy trên master node
- Worker nodes cũng có 4 thành phần:
  * Pods
  * Node Agent (kubelet) - Theo dõi những gì xảy ra trên node và giao tiếp với Master node
  * Network Component (kube-proxy) - Tạo deployment, expose deployment như 1 Service
  * Container Runtime - Trình quản lý các container, mặc định là Docker

- Khi master node down thì app vẫn chạy bình thường, vì cơ bản khi ta request vào URL thì sẽ làm việc với worker nodes chứ master node không liên quan gì cả. Vậy bên trong 1 cluster thì có 1 master node và các worker nodes.

## Rollout

- Xem lịch sử phát hành

  `kubectl rollout history deployment <deploy-name>`

- Status của bản phát hành hiện tại

  `kubectl rollout status deployment <deploy-name>`

- Undo lại bản phát hành trước

  `kubectl rollout undo deployment <deploy-name> --to-revision=<revision-number>`

- Xem log application trong pod

  `kubectl logs <pod-id> [-f]`
