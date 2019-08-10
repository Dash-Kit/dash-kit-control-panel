import 'package:shared_preferences/shared_preferences.dart';

class ProxyManager {
  static const _PROXY_IP_ADDRESS = 'debug_panel.proxy_ip_address';
  static const _IS_PROXY_ENABLED = 'debug_panel.is_proxy_enabled';

  static final shared = ProxyManager._();

  ProxyManager._();

  Future<bool> isProxyEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_IS_PROXY_ENABLED) ?? false;
  }

  Future<void> setProxyMode(bool mode) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_IS_PROXY_ENABLED, mode);
  }

  Future<String> getProxyIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PROXY_IP_ADDRESS);
  }

  Future<void> setProxyIpAddress(String ipAddress) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_PROXY_IP_ADDRESS, ipAddress);
  }
}
