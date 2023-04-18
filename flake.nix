{
  description = "John's flake templates";

  outputs = { ... }: {
    templates = {
      haskell = {
        path = ./haskell;
        description = "A template for haskell development";
      };
      javascript = {
        path = ./javascript;
        description = "A template for javascript development";
      };
      nodeml = {
        path = ./nodeml;
        description = "A template for TAN NodeML development";
      };
      terraform = {
        path = ./terraform;
        description = "A template for terraform development";
      };
      typescript = {
        path = ./typescript;
        description = "A template for typescript development";
      };
    };
  };
}
