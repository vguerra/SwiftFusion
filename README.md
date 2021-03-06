# SwiftFusion

Differentiable Swift based sensor fusion library. 

Think factor graphs a la [GTSAM](https://gtsam.org/) coupled with deep learning, [Jax](https://github.com/google/jax)/[TensorFlow](https://www.tensorflow.org/) style. Based on [Swift for TensorFlow](https://www.tensorflow.org/swift).

Still very early, but feel free to explore! Subject to *massive* change :-)

## Run tests

```
swift test
```

## Run benchmarks

```
swift run -c release -Xswiftc -cross-module-optimization SwiftFusionBenchmarks
```

## Update dependency versions

```
swift package update
```

# LICENSE


Copyright 2020 The SwiftFusion Team

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
