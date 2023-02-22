This project was built to demonstrate how we can achieve a Modularized code base that’s completely testable, especially when it comes to the views. Yes, it might be an overkill for a tiny project like this, however it was also fun trying to achieve it.

The main parts of the project are:

./Demo

./Packages/DemoCore/Sources

   - DemoCore
   - DemoNetworking
   - DemoUI
   - HomePageDetails
   - HomePageView

./Packages/DemoCore/Tests

## Dependencies

- https://github.com/pointfreeco/swift-snapshot-testing

This is used to make sure that our UI is properly coded.

- https://github.com/onevcat/Kingfisher

This helps us to handle image caching + downloading

## Whats missing

- Caching