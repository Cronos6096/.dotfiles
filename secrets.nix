{
  age.secrets = {
    envVars = {
      file = ./secrets/env.age;
      owner = "andme";
    };
  };
  age.secrets.password.file = ./secrets/password.age;
  age.secrets.duckdnsToken.file = ./secrets/duckdnsToken.age;
}
