function() {
  karate.configure('connectTimeout', 25000)
  karate.configure('readTimeout', 25000)
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
	bookingURL: 'http://localhost/'
  }
  if (env == 'dev') {
    config.bookingURL = 'http://restful-booker.herokuapp.com'
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}