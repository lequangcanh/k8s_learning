# Deploy bằng file YML

## Deployment và Service

- File config cơ bản [/.short_notes/ymls/deployment.yml](/.short_notes/ymls/deployment.yml)
- Gồm 4 thành phần cơ bản: apiVersion, kind, metadata, spec
- Apply file config `kubectl apply -f <file>`
- Khi pod ready thì application vẫn có thể cần thêm 1 khoảng thời gian để start, lúc này request có thể bị lỗi. Để fix nhanh thì có thể thêm `minReadySeconds` trong spec của deployment: Giá trị này định nghĩa số giây để pod thực sự ready

## ReplicaSet và Service

- Thử sửa kind Deployment của file trên thành ReplicaSet [/.short_notes/ymls/replicas.yml](/.short_notes/ymls/replicas.yml)
- Xóa tất cả những thứ liên quan hiện tại `kubectl delete all -l <label-name>`
- Apply file config và ta thấy application vẫn chạy được. Vì bản chất chỉ cần pod run application và service để kết nối với bên ngoài là application của chúng ta đã chạy được rồi
- Tuy nhiên, Replicas nó chỉ quan tâm tới số pod đang chạy. Change image trong file config và thử apply lại, ta thấy không có gì thay đổi. Bởi vì lúc đó, số pod đang chạy vẫn đảm bảo đúng với số replicas nên replicas sẽ không làm gì. Khi kill 1 pod đi, replicas sẽ tự động create 1 pod mới mà nó sẽ apply container mới => Đó là những gì Replicas thực sự làm và là lí do chúng ta phải cần đến Deployment

## Config nhiều deployment với 1 Service

- [/.short_notes/ymls/multi_deployment.yml](/.short_notes/ymls/multi_deployment.yml)
