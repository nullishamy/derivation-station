local function f(lang)
  return require(('language.impl.%s'):format(lang))
end

return {
  f('bash'),
  f('cpp'),
  f('csharp'),
  f('css'),
  f('docker'),
  f('go'),
  f('json'),
  f('lua'),
  f('nim'),
  f('nix'),
  f('null'),
  f('php'),
  f('python'),
  f('rust'),
  f('typescript'),
}
