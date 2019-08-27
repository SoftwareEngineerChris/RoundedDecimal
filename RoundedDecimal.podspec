Pod::Spec.new do |s|
  s.name             = 'RoundedDecimal'
  s.version          = '0.1.0'
  s.summary          = 'Decimals where the number of decimal places is explicitly part of the type'

  s.description      = <<-DESC
This library makes the number of decimal places after the point part of the type so that you can guarantee
that you are handling a Decimal type with the exact number of decimal places you expect. Converting between
decimals of differenct decimal places can be done safely and explicitly using the type system.
                       DESC

  s.homepage         = 'https://github.com/SoftwareEngineerChris/RoundedDecimal'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SoftwareEngineerChris' => '4376956+SoftwareEngineerChris@users.noreply.github.com' }
  s.source           = { :git => 'https://github.com/SoftwareEngineerChris/RoundedDecimal.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'RoundedDecimal/implementation/**/*'
end
