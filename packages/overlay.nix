(final: prev: {
  gpu-screen-recorder = prev.callPackage ./gsr/gpu-screen-recorder.nix {};
  gpu-screen-recorder-notification = prev.callPackage ./gsr/gpu-screen-recorder-notification.nix {};
  gpu-screen-recorder-ui = prev.callPackage ./gsr/gpu-screen-recorder-ui.nix {};
  helium = prev.callPackage ./helium/helium.nix {};
})
