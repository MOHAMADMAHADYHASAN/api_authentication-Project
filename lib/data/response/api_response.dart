import 'package:authenticationfire/data/response/status.dart';

/// eti ui er kache jay BOX ba  CONTAINER hishabe ekhan jekono TYPE(T) er data thakte pare


class ApiResponse<T> {
  // jehetu box e kore data jabe tai datar STATE o pathano lagbe
  Status? status;

  T? data;
  String? message;

  ApiResponse(this.status, this.data, this.message);
//named CONSTRUCTOR
  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;


  @override
  String toString() {
    return "Status : $status \n Message:$message \n Data:$data";
  }
}
