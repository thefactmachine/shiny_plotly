library(sass)
variable <- "$variable_name: blue;"
rule <- "h1 {color: $variable_name;}"

sass(input = list(variable, rule))

sass(
  input = list(variable, rule),
  # following I guess coverts the scss into css
  # sass_file("style.scss"),
  output = "style.css"
)
