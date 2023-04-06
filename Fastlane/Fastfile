default_platform(:android)

platform :android do
  desc "Deploy Android app to Internal testing track on Google Play Store"
  lane :deploy_internal do
    upload_to_play_store(
      track: 'internal',
      aab: 'android/app/build/app/outputs/bundle/release/app-release.aab',
      json_key_data: ENV['PLAYSTORE_API_KEY'],
      package_name: 'com.instock.android.abc'
    )
  end
end