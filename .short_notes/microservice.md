## Automatic Service Discovery

- Khi 1 pod start up, nó lấy được những biến môi trường dựa vào những service đang running

  `<SERVICE_NAME>_SERVICE_HOST`: Cluster IP
  `<SERVICE_NAME>_PORT`

- Trường hợp service chưa startup thì những biến môi trường trên chưa được load. Có thể sử dụng `http://service-name`

## Ingress

- Cho phép ta có 1 cái LoadBalancer, từ đó có thể route các request đến từng microservices
- Bởi vì mỗi microservice mà config 1 LB thì sẽ rất đắt
- Ingress có region là Global

## Auto scale

- `kubectl autoscale deployment <deployment-name> --min=<min-pod> --max=<max-pod> --cpu-percent=<ngưỡng cpu>`

## StackDriver

- Cung cấp option giúp xem log và điều tra request qua nhiều Service

## Istio

- 1 pod nên chưa 1 container của service
- Mỗi service deploy trong pod sẽ cần những function liên quan như: service discovery, logging, tracing, release stragery, ...

  => Tạo thêm container trong mỗi pod để xử lý những việc này. Đây chính là Service mash. Istio là 1 implementation của Service mash

  istio Gateway (LB) ---- istio Vitual Service (Route) ---- Services
