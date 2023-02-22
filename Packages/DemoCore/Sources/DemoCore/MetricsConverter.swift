import Foundation

public final class MetricsConverter {

  private let local: DemoLocal

  private lazy var measurementFormatter: MeasurementFormatter = {
    let formatter = MeasurementFormatter()
    formatter.locale = local.local
    return formatter
  }()

  public init(local: DemoLocal = LocalWrapper()) {
    self.local = local
  }

  public func convert(measurement: Measurement<Unit>) -> String? {
    measurementFormatter.string(from: measurement)
  }

}
