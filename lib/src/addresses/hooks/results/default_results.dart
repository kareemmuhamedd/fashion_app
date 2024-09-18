import 'dart:ui';
import 'package:fashion_app/src/addresses/models/address_model.dart';

class FetchDefaultAddress{
  final AddressModel?  address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;
  FetchDefaultAddress({
    required this.address,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}