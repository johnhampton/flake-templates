{
  description = "John's flake templates";

  outputs = { self, ... }: {
    templates = {
      typescript = {
        path = ./typescript;
        description = "A template for typescript development";
      };
    };
  };
}
