function karateConfig() {
  karate.configure('connectTimeout', 50000)
  karate.configure('readTimeout', 50000)
  karate.configure("logPrettyRequest", true)
  karate.configure("logPrettyResponse", true)

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
  }

  return config;
}