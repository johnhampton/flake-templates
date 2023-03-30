{
  description = "John's flake templates";

  outputs = { ... }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "A template for haskell development";
      };
      nodeml = {
        path = ./nodeml;
        description = "A template for TAN NodeML development";
      };
      typescript = {
        path = ./typescript;
        description = "A template for typescript development";
      };
    };
  };
}
