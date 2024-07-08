/// <#Brief Description#>
///
/// Created by TWINB00591630 on 2024/7/4.
/// Copyright © 2024 Cathay United Bank. All rights reserved.

@testable import tip_calculator
import XCTest
import Combine

final class TipCalculatorTests: XCTestCase {
   
    // sut -> System Under Test
    
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        logoViewTapSubject = .init()
        cancellables = .init()
        audioPlayerService = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        logoViewTapSubject = nil
        cancellables = nil
        audioPlayerService = nil
    }
    
    func testResultWithoutTipFor1Person() {
      // given
      let bill: Double = 100.0
      let tip: Tip = .none
      let split: Int = 1
      let input = buildInput(
        bill: bill,
        tip: tip,
        split: split)
      // when
      let output = sut.transform(input: input)
      // then
      output.updateViewPublisher.sink { result in
        XCTAssertEqual(result.amountPerPerson, 100)
        XCTAssertEqual(result.totalBill, 100)
        XCTAssertEqual(result.totalTip, 0)
      }.store(in: &cancellables)
    }
    
    func testResultWithoutTipFor2Person() {
      // given
      let bill: Double = 100.0
      let tip: Tip = .none
      let split: Int = 2
      let input = buildInput(
        bill: bill,
        tip: tip,
        split: split)
      // when
      let output = sut.transform(input: input)
      // then
      output.updateViewPublisher.sink { result in
        XCTAssertEqual(result.amountPerPerson, 50)
        XCTAssertEqual(result.totalBill, 100)
        XCTAssertEqual(result.totalTip, 0)
      }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
      // given
      let bill: Double = 100.0
      let tip: Tip = .tenPercent
      let split: Int = 2
      let input = buildInput(
        bill: bill,
        tip: tip,
        split: split)
      // when
      let output = sut.transform(input: input)
      // then
      output.updateViewPublisher.sink { result in
        XCTAssertEqual(result.amountPerPerson, 55)
        XCTAssertEqual(result.totalBill, 110)
        XCTAssertEqual(result.totalTip, 10)
      }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
      // given
      let bill: Double = 200.0
      let tip: Tip = .custom(value: 201)
      let split: Int = 4
      let input = buildInput(
        bill: bill,
        tip: tip,
        split: split)
      // when
      let output = sut.transform(input: input)
      // then
      output.updateViewPublisher.sink { result in
        XCTAssertEqual(result.amountPerPerson, 100.25)
        XCTAssertEqual(result.totalBill, 401)
        XCTAssertEqual(result.totalTip, 201)
      }.store(in: &cancellables)
    }
    
    func testSoundPlayedAndCalculatorResetOnLogoViewTap() {
      // given
      let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
      let output = sut.transform(input: input)
      let expectation1 = XCTestExpectation(description: "reset calculator called")
      let expectation2 = audioPlayerService.expectation
      // then
      output.resetCalculatorPublisher.sink { _ in
         expectation1.fulfill()
      }.store(in: &cancellables)
      // when
      logoViewTapSubject.send()
      wait(for: [expectation1, expectation2], timeout: 1.0)
    }
    
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
      return .init(
        billPublisher: Just(bill).eraseToAnyPublisher(),
        tipPublisher: Just(tip).eraseToAnyPublisher(),
        splitPublisher: Just(split).eraseToAnyPublisher(),
        logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
}

class MockAudioPlayerService: AudioPlayerService {
  var expectation = XCTestExpectation(description: "playSound is called")
  func playSound() {
    expectation.fulfill()
  }
}
