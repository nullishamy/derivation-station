local function f(lang)
  return require(('language.impl.%s'):format(lang))
end

return {
  f('typescript'),
  f('lua'),
  f('null'),
  f('nix'),
  f('json')
}
