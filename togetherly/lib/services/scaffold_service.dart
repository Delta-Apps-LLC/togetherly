abstract interface class ScaffoldService {
  Future<int> getNavIndex();
  Future<void> setNavIndex(int index);

  Future<String> getAppBarTitle();
  Future<void> setAppBarTitle(String appBarTitle);
}

class ScaffoldServiceImpl implements ScaffoldService {
  int navIndex = 0;
  String appBarTitle = 'Family';

  @override
  Future<int> getNavIndex() async => navIndex;
  @override
  Future<void> setNavIndex(int index) async => navIndex = index;

  @override
  Future<String> getAppBarTitle() async => appBarTitle;

  @override
  Future<void> setAppBarTitle(String title) async => appBarTitle = title;
}
