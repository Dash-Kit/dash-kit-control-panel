import 'package:shared_preferences/shared_preferences.dart';

class ProxyManager {
  ProxyManager._();

  static const _proxyIpAddress = 'control_panel.proxy_ip_address';
  static const _isProxyEnabled = 'control_panel.is_proxy_enabled';

  static final shared = ProxyManager._();

  Future<bool> isProxyEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isProxyEnabled) ?? false;
  }

  Future<void> setProxyMode(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_isProxyEnabled, mode);
  }

  Future<String> getProxyIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_proxyIpAddress);
  }

  Future<void> setProxyIpAddress(String ipAddress) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_proxyIpAddress, ipAddress);
  }
}
