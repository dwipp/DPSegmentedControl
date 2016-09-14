Pod::Spec.new do |s|
  s.name                      = "DPSegmentedControl"
  s.version                   = "0.1.0"
  s.source                    = { :git => "https://github.com/dwipp/DPSegmentedControl.git",
                                  :tag => s.version.to_s }

  s.summary                   = "Segmented control with image and title."
  s.description               = "This is a custom Segmented Control with icon and text on every segment."
  s.homepage                  = "https://github.com/dwipp/DPSegmentedControl"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = 'dwipp'

  s.ios.deployment_target     = "8.0"
  s.source_files              = "DPSegmentedControl/**/*.swift"
  s.requires_arc              = true
end
