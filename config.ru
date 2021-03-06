use Rack::Static,
  :urls => ["/img", "/js", "/css"],
  :root => "public"

compass = fork do
  exec "compass watch public"
end

Process.detach(compass)

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open('public/index.html', File::RDONLY)
  ]
}
