# Upstox – iOS App

## Problem Statement
## Objective:
- Create a list of holdings (stocks invested) and populate the list as per the below screenshots.
- Create an expanded & collapsed state UI for showing the summary of your portfolio
- Endpoint to fetch data: https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/

- Points to be considered for evaluation:
-- Architecture (preferably Clean or MVVM) that can be scaled and used as a
production codebase.
-- Responsibility segregation in modules
-- Specific to iOS: Clean UI (with no constraint warnings, preferably develop UI through
code)

---
### Note- Ignore tab bar, this is just for reference
-- Red Colour arrow indicates values from the JSON response
-- Green Colour arrow indicates values from the below calculations
---

## Calculation:
- Current value = sum of (Last traded price * quantity of holding ) of all the holdings
- Total investment = sum of (Average Price * quantity of holding ) of all the holdings
- Total PNL = Current value - T otal Investment
- Today’s PNL = sum of ((Close - LTP ) * quantity) of all the holdings.

## Guidelines for iOS
- Acceptance Criteria
-- Your selection chances are higher if
-- You use the latest version of Swift.
-- You create UI Programmatically using UIKit Framework
-- You adhere to Apple’s Human Interface Guidelines and coding conventions.
-- Your app performs well in terms of CPU, memory and energy usage.
-- Your code is loosely coupled, testable and uses an architecture similar to VIPER, MVVM, MVP , etc.
-- You tastefully customise the UI and add animations etc.
-- Your app does not have too many dependencies on third party frameworks.
-- Your app runs smoothly offline.

---
# Note: 
-- We may reject your application if Your project fails to compile or compiled with warnings with the latest version of Xcode.
-- If you use Swift UI Your app does not layout correctly for all iOS devices that can run the current release of iOS.
-- Your app has UI/logical flaws that make it difficult to use.
-- You do not have unit tests in your application with decent code coverage.
-- Your unit tests fail.
-- If auto layout engine throws constraints error during runtime.
---

## Tech Stack

- UIKIT
- Combine
- MVVM + Clean Architecture
- URLSession for API calls

## Requirements

- Xcode 15+
- iOS 17+
- Swift 5.9+

## Author

Soumya Ranjan Mishra

