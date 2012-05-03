SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :account, t('application.menu.account'), my_account_path
  end
end
