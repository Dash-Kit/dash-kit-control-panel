import 'package:shared_preferences/shared_preferences.dart';

class ProxyManager {
  ProxyManager._();

  static const _proxyIpAddress = 'control_panel.proxy_ip_address';
  static const _isProxyEnabled = 'control_panel.is_proxy_enabled';

  static final shared = ProxyManager._();

  /// Returns `true` if proxy enabled.
  Future<bool> isProxyEnabled() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isProxyEnabled) ?? false;
  }

  /// Set the `ProxyEnabled` value to [isProxyEnabled] value.
  // ignore: avoid_positional_boolean_parameters
  Future<void> setProxyMode(bool isProxyEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isProxyEnabled, isProxyEnabled);
  }

  /// Returns the `ProxyIpAddress`.
  Future<String> getProxyIpAddress() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_proxyIpAddress) ?? '';
  }

  /// Set the `ProxyIpAddress` to [ipAddress] value.
  Future<void> setProxyIpAddress(String ipAddress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_proxyIpAddress, ipAddress);
  }
}
