// This file tests for the various identities in Rot2

import SwiftFusion

import XCTest

// Boilerplate code for running the test cases
import XCTest

final class Rot2Tests: XCTestCase {

  // checks between function for two identity rotations
  func testBetweenIdentitiesTrivial() {
    let R1 = Rot2(0), R2 = Rot2(0)
    let expected = Rot2(0)
    let actual = between(R1, R2)

    XCTAssertEqual(actual, expected)
  }

  // checks between
  func testBetween() {
    let R1 = Rot2(0), R2 = Rot2(2)
    let expected = Rot2(2)
    let actual = between(R1, R2)

    XCTAssertEqual(actual, expected)
  }

  // Check derivatives for between
  func testBetweenDerivatives() {
    let R1 = Rot2(0), R2 = Rot2(2)
    let (_, 𝛁actual1) = valueWithGradient(at: R1) { R -> Double in
      between(R, R2).theta
    }

    let (_, 𝛁actual2) = valueWithGradient(at: R2) { R -> Double in
      between(R1, R).theta
    }

    XCTAssertEqual(𝛁actual1, Vector1(-1.0))
    XCTAssertEqual(𝛁actual2, Vector1(1.0))
  }

  // Check derivative for theta value.
  func testThetaDerivative() {
    XCTAssertEqual(
      gradient(at: Rot2(1)) { $0.theta },
      Vector1(1)
    )
  }

  // Check derivative for sine value.
  func testSinDerivative() {
    XCTAssertEqual(
      gradient(at: Rot2(1)) { $0.s },
      Vector1(cos(1))
    )
  }

  // Check derivative for cosine value.
  func testCosDerivative() {
    XCTAssertEqual(
      gradient(at: Rot2(1)) { $0.c },
      Vector1(-sin(1))
    )
  }

  // Check derivative for initialization from theta.
  func testThetaInitDerivative() {
    XCTAssertEqual(
      gradient(at: 1) { Rot2($0).theta },
      1
    )
  }

  // Check derivative for initialization from cosine and sine values.
  func testCosSinInitDerivative() {
    let grad1 = gradient(at: 1, 0) { Rot2(c: $0, s: $1).theta }
    XCTAssertEqual(grad1.0, 0)
    XCTAssertEqual(grad1.1, 1)
  }

  // Check gradient descent
  func testGradientDescent() {
    var R1 = Rot2(0), R2 = Rot2(1)
    print("Initial R2: ", R2.theta)

    for _ in 0..<100 {
      var (_, 𝛁loss) = valueWithGradient(at: R1) { R1 -> Double in
        var loss: Double = 0
        let ŷ = between(R1, R2)
        let error = ŷ.theta
        loss = loss + (error * error / 10)

        return loss
      }

      // print("𝛁loss", 𝛁loss)
      𝛁loss = -𝛁loss
      R1.move(along: 𝛁loss)
    }

    print("DONE.")
    print("R1: ", R1.theta, "R2: ", R2.theta)

    XCTAssertEqual(R1.theta, R2.theta, accuracy: 1e-5)
  }

  // Check group action: rotate
  func testRotate() {
    let p = Vector2(4.0, -2.0)
    let R = Rot2(60.0 * .pi / 180.0)

    // Rotation by +60 deg
    let expected = Vector2(2.0 + .sqrt(3.0), 2.0 * .sqrt(3.0) - 1.0)
    let actual1 = R.rotate(p)
    let actual2 = R * p

    assertAllKeyPathEqual(actual1, expected, accuracy: 1e-9)
    assertAllKeyPathEqual(actual2, expected, accuracy: 1e-9)
  }

  // Check group action: unrotate
  func testUnrotate() {
    let p = Vector2(4.0, -2.0)
    let R = Rot2(60.0 * .pi / 180.0)

    // Should be identity
    let actual = R.unrotate(R.rotate(p))

    assertAllKeyPathEqual(actual, p, accuracy: 1e-9)
  }
}
