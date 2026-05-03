# Báo cáo dự án AppWeek4 
## 1. Giới thiệu dự án

AppWeek4 là một ứng dụng Flutter dùng để thực hành các kiến thức cơ bản về xây dựng giao diện, điều hướng màn hình, hiển thị dữ liệu, lưu trữ cục bộ và xử lý bất đồng bộ.
demo:youtube.com/watch?v=DKaVlCUBSCk&feature=youtu.be
Ứng dụng gồm 4 chức năng chính:

- Hiển thị danh sách liên hệ bằng `ListView`.
- Hiển thị dữ liệu dạng lưới bằng `GridView`.
- Lưu, đọc và xóa dữ liệu cục bộ bằng `SharedPreferences`.
- Mô phỏng quá trình tải dữ liệu bất đồng bộ bằng `Future`.

## 2. Cấu trúc dự án

Cấu trúc chính của dự án:

```text
appweek4/
├── lib/
│   ├── main.dart
│   └── screens/
│       ├── home_screen.dart
│       ├── list_view_screen.dart
│       ├── grid_view_screen.dart
│       ├── shared_preferences_screen.dart
│       └── async_screen.dart
├── test/
│   └── widget_test.dart
├── web/
├── ios/
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
├── README.md
└── .gitignore
```

Trong đó:

- `lib/`: chứa mã nguồn chính của ứng dụng.
- `lib/main.dart`: điểm bắt đầu chạy app.
- `lib/screens/`: chứa các màn hình chức năng.
- `pubspec.yaml`: khai báo thông tin dự án và thư viện phụ thuộc.
- `test/`: chứa file kiểm thử.
- `web/`, `ios/`: thư mục nền tảng được Flutter tạo ra.
- `.gitignore`: cấu hình các file/thư mục không đưa lên Git.

## 3. Các file chính trong dự án

### 3.1. File `main.dart`

File `main.dart` là điểm khởi động của ứng dụng. Hàm `main()` gọi `runApp(const MyApp())` để chạy app.

Trong `MyApp`, ứng dụng sử dụng `MaterialApp` để cấu hình:

- Tên ứng dụng.
- Ẩn banner debug.
- Theme giao diện.
- Màn hình đầu tiên là `HomeScreen`.

Ngoài ra, file này còn cấu hình màu sắc, `AppBar`, `Card`, `InputDecoration` và `ElevatedButton` để giao diện trong toàn app thống nhất.

### 3.2. File `home_screen.dart`

File `home_screen.dart` quản lý màn hình chính của ứng dụng.

Màn hình này sử dụng `StatefulWidget` vì cần thay đổi trạng thái khi người dùng chuyển tab. Biến `selectedIndex` dùng để xác định màn hình đang được chọn.

Danh sách màn hình gồm:

```dart
final List<Widget> screens = const [
  ListViewScreen(),
  GridViewScreen(),
  SharedPreferencesScreen(),
  AsyncScreen(),
];
```

Khi người dùng chọn một tab ở `NavigationBar`, app gọi `setState()` để cập nhật `selectedIndex`, sau đó hiển thị màn hình tương ứng trong phần `body`.

### 3.3. File `list_view_screen.dart`

File này xây dựng màn hình danh bạ.

Dữ liệu liên hệ được khai báo sẵn trong danh sách `contacts`, mỗi phần tử gồm:

- `name`: tên người liên hệ.
- `phone`: số điện thoại.

Màn hình sử dụng `ListView.builder` để hiển thị danh sách liên hệ. Mỗi liên hệ được đặt trong một `Card` và `ListTile`, gồm ảnh đại diện, tên, số điện thoại và nút gọi.

Khi bấm nút gọi, app hiển thị `SnackBar` để thông báo đang gọi liên hệ đó.

### 3.4. File `grid_view_screen.dart`

File này xây dựng màn hình hiển thị dữ liệu dạng lưới.

Màn hình sử dụng hai loại `GridView`:

- `GridView.count`: hiển thị lưới với số cột cố định.
- `GridView.extent`: hiển thị lưới theo kích thước tối đa của mỗi item.

Cả hai phần đều dùng chung danh sách icon và label. Mục đích là so sánh cách bố trí lưới cố định và lưới linh hoạt theo kích thước màn hình.

### 3.5. File `shared_preferences_screen.dart`

File này xây dựng màn hình lưu trữ dữ liệu cục bộ.

Màn hình gồm 3 ô nhập:

- Tên.
- Tuổi.
- Email.

Các chức năng chính:

- `Save`: lưu dữ liệu vào `SharedPreferences`.
- `Show`: đọc dữ liệu đã lưu.
- `Clear data`: xóa dữ liệu đã lưu.

Dữ liệu được lưu bằng các khóa:

- `name`
- `age`
- `email`
- `timestamp`

Màn hình sử dụng `TextEditingController` để lấy dữ liệu từ ô nhập, `setState()` để cập nhật kết quả hiển thị và `SnackBar` để thông báo cho người dùng.

### 3.6. File `async_screen.dart`

File này xây dựng màn hình mô phỏng xử lý bất đồng bộ.

Màn hình sử dụng hai biến trạng thái:

- `isLoading`: cho biết app đang tải dữ liệu hay đã hoàn thành.
- `message`: nội dung thông báo hiển thị trên màn hình.

Hàm `loadUser()` thực hiện luồng xử lý:

1. Chuyển trạng thái sang đang tải.
2. Hiển thị thông báo đang tải dữ liệu.
3. Chờ 3 giây bằng `Future.delayed`.
4. Chuyển trạng thái sang hoàn thành.
5. Hiển thị thông báo tải dữ liệu thành công.

Hàm `loadUser()` được gọi trong `initState()`, nên khi mở màn hình Async task, app tự động bắt đầu tải dữ liệu.

## 4. Thư viện sử dụng

Trong file `pubspec.yaml`, dự án sử dụng thư viện chính:

```yaml
shared_preferences: ^2.5.5
```

Thư viện `shared_preferences` dùng để lưu dữ liệu dạng key-value trên thiết bị. Trong dự án này, thư viện được dùng ở màn hình Storage để lưu tên, tuổi, email và thời gian lưu gần nhất.

Ngoài ra, dự án sử dụng các thư viện mặc định của Flutter như:

- `flutter/material.dart`: xây dựng giao diện Material Design.
- `flutter_test`: hỗ trợ kiểm thử ứng dụng.

## 5. Luồng xử lý tổng quát

Luồng xử lý chính của ứng dụng:

```text
Người dùng mở app
        ↓
main.dart chạy hàm main()
        ↓
runApp(const MyApp())
        ↓
MaterialApp được tạo
        ↓
HomeScreen được hiển thị
        ↓
Người dùng chọn tab ở NavigationBar
        ↓
selectedIndex được cập nhật bằng setState()
        ↓
Màn hình tương ứng được hiển thị
```

Ứng dụng không dùng route riêng cho từng màn hình. Thay vào đó, app dùng `NavigationBar` và biến `selectedIndex` để thay đổi nội dung trong `body` của `Scaffold`.

## 6. Luồng xử lý từng chức năng

### 6.1. Chức năng ListView

Luồng xử lý:

1. App đọc danh sách `contacts`.
2. Hiển thị tổng số liên hệ.
3. `ListView.builder` tạo từng item.
4. Mỗi item hiển thị tên, số điện thoại và nút gọi.
5. Khi bấm nút gọi, app hiển thị `SnackBar`.

Kết quả: người dùng xem được danh sách liên hệ và nhận phản hồi khi bấm nút gọi.

### 6.2. Chức năng GridView

Luồng xử lý:

1. App đọc danh sách icon và label.
2. Hiển thị phần giới thiệu Gallery.
3. Hiển thị lưới thứ nhất bằng `GridView.count`.
4. Hiển thị lưới thứ hai bằng `GridView.extent`.
5. Người dùng có thể cuộn để xem toàn bộ nội dung.

Kết quả: app minh họa được hai cách xây dựng giao diện dạng lưới trong Flutter.

### 6.3. Chức năng SharedPreferences

Luồng xử lý khi lưu dữ liệu:

1. Người dùng nhập tên, tuổi và email.
2. App lấy dữ liệu từ `TextEditingController`.
3. App kiểm tra tên không được để trống.
4. App gọi `SharedPreferences.getInstance()`.
5. App lưu dữ liệu bằng `setString`.
6. App cập nhật trạng thái và hiển thị thông báo lưu thành công.

Luồng xử lý khi đọc dữ liệu:

1. App gọi `SharedPreferences.getInstance()`.
2. App đọc dữ liệu bằng `getString`.
3. Nếu chưa có dữ liệu, app hiển thị thông báo chưa có dữ liệu.
4. Nếu có dữ liệu, app hiển thị thông tin đã lưu.

Luồng xử lý khi xóa dữ liệu:

1. App gọi `SharedPreferences.getInstance()`.
2. App xóa từng khóa bằng `remove`.
3. App cập nhật trạng thái hiển thị.
4. App thông báo dữ liệu đã được xóa.

Kết quả: người dùng có thể lưu, xem lại và xóa thông tin cá nhân trong bộ nhớ cục bộ.

### 6.4. Chức năng Async task

Luồng xử lý:

1. Khi mở màn hình, `initState()` gọi `loadUser()`.
2. App chuyển sang trạng thái loading.
3. App hiển thị thanh tiến trình.
4. App chờ 3 giây bằng `Future.delayed`.
5. App chuyển sang trạng thái completed.
6. Người dùng có thể bấm `Reload data` để chạy lại tác vụ.

Kết quả: app mô phỏng được quá trình xử lý bất đồng bộ và hiển thị trạng thái tải dữ liệu.

## 7. Giao diện ứng dụng

Ứng dụng sử dụng Material Design với giao diện sáng, bố cục rõ ràng và các thành phần quen thuộc:

- `Scaffold`: khung màn hình chính.
- `AppBar`: tiêu đề của từng chức năng.
- `NavigationBar`: thanh điều hướng dưới cùng.
- `Card`: nhóm nội dung.
- `ListTile`: hiển thị từng dòng liên hệ.
- `TextField`: nhập dữ liệu.
- `SnackBar`: hiển thị thông báo nhanh.
- `AnimatedSwitcher`: tạo hiệu ứng chuyển trạng thái ở màn hình Async.

## 8. Kết quả đạt được

Sau khi hoàn thành dự án, app đã đạt được các kết quả:

- Có cấu trúc thư mục rõ ràng.
- Tách màn hình thành nhiều file riêng, dễ quản lý.
- Có thanh điều hướng giữa 4 chức năng.
- Hiển thị được danh sách bằng `ListView`.
- Hiển thị được lưới bằng `GridView`.
- Lưu trữ được dữ liệu cục bộ bằng `SharedPreferences`.
- Xử lý được tác vụ bất đồng bộ bằng `Future`.
- Có phản hồi giao diện cho người dùng thông qua `SnackBar`, loading state và hiệu ứng chuyển trạng thái.

## 9. Hạn chế và hướng phát triển

Một số hạn chế hiện tại:

- Dữ liệu danh bạ và dữ liệu Gallery vẫn đang khai báo cố định trong code.
- Chức năng gọi điện chỉ mô phỏng bằng `SnackBar`, chưa gọi API điện thoại thật.
- Chức năng Async mới mô phỏng tải dữ liệu, chưa kết nối server thật.
- File test hiện vẫn là file test mặc định, chưa có test riêng cho từng màn hình.

Hướng phát triển:

- Kết nối API để lấy dữ liệu thật.
- Thêm chức năng tìm kiếm danh bạ.
- Cho phép thêm, sửa, xóa liên hệ.
- Bổ sung kiểm thử cho các màn hình chính.
- Cải thiện README để mô tả đầy đủ cách cài đặt và chạy dự án.

## 10. Kết luận

Dự án AppWeek4 giúp thực hành các kiến thức quan trọng trong Flutter như tổ chức cấu trúc dự án, xây dựng giao diện, quản lý trạng thái, điều hướng màn hình, lưu trữ cục bộ và xử lý bất đồng bộ.

Thông qua dự án này, em hiểu rõ hơn cách xây dựng một ứng dụng Flutter gồm nhiều màn hình và cách chia code thành các file riêng để dễ đọc, dễ bảo trì và dễ mở rộng.

