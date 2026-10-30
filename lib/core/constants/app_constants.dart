class AppConstants {
  // Couple Details from Sanvi & Santosh specification
  static const String brideName = "Sanvi Rao";
  static const String groomName = "Santosh Kumar";
  static const String coupleInitials = "S & S";
  static const String campaignSlug = "sanvi-santosh";
  static const String weddingTagline = "Skip the boxed gifts, Gift a Square Foot!";
  static const String weddingSubtitle = "Build Their First Home, One Square Foot at a Time!";

  // Wedding Date (Nov 15, 2026, 05:45 AM)
  static final DateTime weddingDateTime = DateTime(2026, 11, 15, 5, 45);

  // Property & Fractional Registry Specs
  static const String propertyName = "The 2 BHK Dream Apartment";
  static const String propertyUnit = "Unit 402 • Skyline Meadows";
  static const String propertyLocation = "Silicon Valley, Bangalore";
  static const int totalSqFt = 1200;
  static const double ratePerSqFt = 4500.0; // ₹4,500 per sq.ft.
  static const double totalGoalAmount = totalSqFt * ratePerSqFt; // ₹54,00,000
  static const int defaultFundedSqFt = 420; // 35% funded

  // Statutory Compliance
  static const String reraRegistrationId = "P02400003891";
  static const String escrowBank = "HDFC Bank • RBI Tripartite Escrow";
  static const String escrowIFSC = "HDFC00012";
  static const String taxExemptionSection = "Sec 56(2)(x) of Indian Income Tax Act";

  // Assets
  static const String qrBannerPath = "assets/images/qr_banner.jpg";
  static const String heroBannerPath = "assets/images/hero_banner.jpg";
  static const String apartmentPosterPath = "assets/images/apartment_poster.jpg";
  static const String flatImagePath = "assets/images/apartment_poster.jpg";
  static const String coupleImagePath = "assets/images/couple_portrait.jpg";
  static const String floorPlanImagePath = "assets/images/floor_plan.jpg";
}
