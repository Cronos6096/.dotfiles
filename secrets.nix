{
  age.secrets = {
    envVars = {
      file = ./secrets/env.age;
      owner = "andme";
    };
  };
  age.secrets.password.file = ./secrets/password.age;
  # age.secrets.server.file = ./secrets/server.age;
}
