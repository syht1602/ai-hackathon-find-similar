/// Application text constants
class AppTexts {
  AppTexts._();

  // App title
  static const String appTitle = 'CarAdvisor';

  // Navigation labels
  static const String navHome = 'Home';
  static const String navListing = 'Listing';
  static const String navSaves = 'Saves';

  // Home screen
  static const String searchHint = 'Search for cars...';
  static const String recentSearches = 'Recent Searches';
  static const String highMarketShare = 'High Market Share';

  // Detail screen
  static const String carDetail = 'Car Detail';
  static const String findSimilar = 'Find Similar';
  static const String close = 'Close';
  static const String compareAlternatives = 'Compare Alternatives';
  static const String tapToCompare = 'Tap a card to see side-by-side';
  static const String analysisResult = 'Analysis Result';
  static const String selectToCompare = 'Select a car to compare';
  static const String tapAnyCard =
      'Tap any card below to start comparing instantly.';
  static const String tapAnotherCard =
      'Tap another card in the carousel to refresh this insight.';

  // Improve results modal
  static const String improveResults = 'Improve results';
  static const String tellUsWhatToRefine = 'Tell us what to refine';
  static const String improveResultsHint =
      'e.g. "Show more hybrid SUVs under \$35k" or "Include cars with ventilated seats"';
  static const String submitImprovementIdea = 'Submit improvement idea';
  static const String pleaseDescribe =
      'Please describe how to improve the results.';
  static String thanksForFeedback(String input) =>
      'Thanks! We\'ll look for "$input" next.';

  // Analysis modal
  static const String detailedAnalysis = 'Detailed Analysis';
  static const String priceComparison = 'Price Comparison';
  static const String marketShare = 'Market Share';
  static const String mileage = 'Mileage';
  static const String summary = 'Summary';
  static const String better = 'better';
  static const String worse = 'worse';

  // Comparison results
  static const String betterValue =
      'Better value: Lower price with higher market share';
  static const String premiumOption =
      'Premium option: Higher price but stronger market position';
  static const String budgetChoice =
      'Budget choice: Lower price and market share';
  static const String tradeOff =
      'Trade-off: Higher price with lower market share';

  // Car tags
  static const String oneOwner = '1 Owner';
  static const String twoOwners = '2 Owners';
  static const String noAccidents = 'No accidents';
  static const String higherTrim = 'Higher trim';

  // Badge labels
  static const String badgeOld = 'Old';
  static const String badgeNew = 'New';

  // Listing screen
  static const String errorLoading = 'Error loading cars: ';
  static const String noListings = 'No listings available';

  // Saves screen
  static const String favorites = 'Favorites';
  static const String favoritesSubtitle = 'Cars you marked for follow-up.';
  static const String trackedListings = 'Tracked Listings';
  static const String trackedSubtitle = 'Active alerts for watched results.';
  static const String notes = 'Notes';
  static const String notesSubtitle = 'Personal reminders about listings.';

  // Car card
  static const String marketSharePrefix = 'Market Share: ';
  static const String mpgCity = '28 mpg city';
  static const String fuelType = '70% gasoline';

  // Detail normal
  static const String summaryText =
      'This is a concise summary description of the vehicle. It highlights the most important tradeoffs between price, efficiency, and market share. Use this area to help compare cars quickly.';

  // Detail small
  static const String priceLabel = 'Price';
  static const String mileageLabel = 'Mileage';
  static const String marketLabel = 'Market';
  static const String tag = 'Tag';
  static const String selected = 'Selected';
  static const String comparing = 'Comparing';
  static const String selectCar = 'Select a car';

  // Similar car carousel
  static const String compareAlternativesHeader = 'Compare Alternatives';
  static const String tapCardToCompare = 'Tap a card to see side-by-side';
  static const String improveResultsButton = 'Improve results';
  static const String tipsAndUpdates = 'Tell us what to refine';
  static const String submitButton = 'Submit improvement idea';
}
