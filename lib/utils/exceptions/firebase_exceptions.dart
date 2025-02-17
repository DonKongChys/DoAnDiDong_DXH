class TFirebaseException implements Exception {
  final String code;
  TFirebaseException(this.code);
  String get message {
    switch (code) {
      case 'unknown':
        return 'Đã xảy ra lỗi Firebase không xác định. Vui lòng thử lại.';
      case 'invalid-custom-token':
        return 'Định dạng mã thông báo tùy chỉnh không chính xác. Vui lòng kiểm tra mã thông báo tùy chỉnh của bạn.';
      case 'custom-token-mismatch':
        return 'Mã thông báo tùy chỉnh tương ứng với một đối tượng khác.';
      case 'user-disabled':
        return 'Tài khoản người dùng đã bị vô hiệu hóa.';
      case 'user-not-found':
        return 'Không tìm thấy người dùng nào cho email hoặc UID đã cho.';
      case 'invalid-email':
        return 'Địa chỉ email được cung cấp không hợp lệ. Vui lòng nhập email hợp lệ.';
      case 'email-already-in-use':
        return 'Địa chỉ email đã được đăng ký. Vui lòng sử dụng một email khác. ';
      case 'wrong-password':
        return 'Mật khẩu không đúng. Vui lòng kiểm tra mật khẩu của bạn và thử lại.';
      case 'weak-password':
        return 'Mật khẩu quá yếu. Vui lòng chọn một mật khẩu mạnh hơn.';
      case 'provider-already-linked':
        return 'Tài khoản đã được liên kết với nhà cung cấp khác.';
      case 'operation-not-alt owed':
        return 'Hoạt động này không được phép. Liên hệ hỗ trợ để được hỗ trợ.';
      case 'invalid-credential':
        return 'Thông tin xác thực được cung cấp không đúng định dạng hoặc đã hết hạn.';
      case 'invalid-verification-code':
        return 'Mã xác minh không hợp lệ. Vui lòng nhập mã hợp lệ.';
      case 'invalid-verification-id':
        return 'Id xác minh không hợp lệ. Vui lòng yêu cầu mã xác minh mới.';
      case 'requires-recent-login':
        return 'Hoạt động này rất nhạy cảm và yêu cầu xác thực gần đây. Xin vui lòng đăng nhập lại.';
      case 'quota-exceeded':
        return 'Đã vượt quá hạn ngạch. Vui lòng thử lại sau.';
      case 'account-exists-with-different-credential':
        return 'Một tài khoản đã tồn tại với cùng một email nhưng thông tin đăng nhập khác nhau.';
      case 'missing-iframe-start':
        return 'Mẫu email thiếu thẻ bắt đầu iframe.';
      case 'missing-iframe-end':
        return 'Mẫu email thiếu thẻ kết thúc iframe.';
      case 'missing-iframe-src':
        return 'Mẫu email thiếu thuộc tính iframe soc.';
      case 'auth-domain-config-required':
        return 'Cấu hình authDomain là bắt buộc đối với liên kết xác minh mã hành động.';
      case 'missing-app-credential':
        return 'Thông tin xác thực ứng dụng bị thiếu. Vui lòng cung cấp thông tin xác thực ứng dụng hợp lệ.';
      case 'session-cookie-expired':
        return 'Cookie phiên Firebase đã hết hạn. Vui lòng đăng nhập lại.';
      case 'uid-already-exists':
        return 'ID người dùng được cung cấp đã được người dùng khác sử dụng.';
      case 'web-storage-unsupported':
        return 'Bộ nhớ web không được hỗ trợ hoặc bị vô hiệu hóa.';
      case 'app-deleted':
        return 'Phiên bản FirebaseApp này đã bị xóa.';
      case 'user-token-mismatch':
        return 'Mã thông báo của người dùng được cung cấp không khớp với ID người dùng của người dùng đã xác thực';
      case 'invalid-message-payload':
        return 'Tải trọng tin nhắn xác minh mẫu email không hợp lệ.';
      case 'invalid-sender':
        return 'Người gửi mẫu email không hợp lệ. Vui lòng xác minh email của người gửi';
      case 'invalid-recipient-email':
        return 'Địa chỉ email người nhận không hợp lệ. Vui lòng cung cấp email người nhận hợp lệ.';
      case 'missing-action-code':
        return 'Mã hành động bị thiếu. Vui lòng cung cấp mã hành động hợp lệ.';
      case 'user-token-expired':
        return 'Mã thông báo của người dùng đã hết hạn và cần phải xác thực. Vui lòng đăng nhập lại.';
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'THÔNG TIN ĐĂNG NHẬP KHÔNG HỢP LỆ.';
      case 'expired-action-code':
        return 'Mã hành động đã hết hạn. Vui lòng yêu cầu mã hành động mới.';
      case 'invalid-action-code':
        return 'Mã hành động không hợp lệ. Vui lòng kiểm tra mã và thử lại. ';
      case 'credential-already-in-use':
        return 'Thông tin xác thực này đã được liên kết với một tài khoản người dùng khác.';
      default:
        // return 'Đã xảy ra lỗi Firebase không mong muốn. Vui lòng thử lại.';
        return code;
    }
  }
}
