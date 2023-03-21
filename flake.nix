{
  description = "John's flake templates";

  outputs = { self, ... }: {
    templates = {
      typescript = {
        path = ./typescript;
        description = "A template for typescript development";
      };
      nodeml = {
        path = ./nodeml;
        description = "A template for TAN NodeML development";
      };
    };
  };
}
