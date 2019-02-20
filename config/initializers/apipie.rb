Apipie.configure do |config|
  config.app_name = 'Rails Exercise'
  config.copyright = ''
  config.api_base_url = '/api/v1/'
  config.doc_base_url = '/docs'
  config.default_locale = nil
  config.translate = false
  config.validate = false
  config.app_info['1.0'] = "
    In Header these params required for authentication
      Authorization: ''

    Default Error format.
      {
          'error': 'Error Message'
      }

     Default Success format.
      {
          'message': 'Error Message'
      }
  "
  # where is your API defined?
  config.api_controllers_matcher = File.join(Rails.root, 'app', 'controllers', 'api', '**', '*.rb')
end
