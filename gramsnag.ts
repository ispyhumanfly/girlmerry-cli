import Instagram from 'node-instagram';

// Create a new instance.
const instagram = new Instagram({
  clientId: '7f9f89f43e9640d7b4709d16e5360271',
  clientSecret: '874ed658d661481791ffdb23218fcb8d'
})

// Get information about the owner of the access_token.
instagram.get('users/self').then((data) => {
  console.log(data);
})
