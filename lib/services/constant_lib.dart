class ConstLib {
  static const String appName = 'Dapur Lestari';
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'PlayfairDisplay';
  static const String monospaceFont = 'monospace';

  // API Structure Keys
  static const String id = 'id';
  static const String schema = 'schema';
  static const String attributes = 'attributes';
  static const int defaultPageSize = 10;

  /* API - Sorts */
  static const String sortLatest = 'id:desc';
  static const String sortOldest = 'id:asc';
  static const String sortNameAtoZ = 'name:asc';
  static const String sortNameZtoA = 'name:desc';
  static const String sortTitleAtoZ = 'title:asc';
  static const String sortTitleZtoA = 'title:desc';

  /* API - Filters */
  static const String filtersMediaImage = 'mime:contains:image/';

  /* SEO */
  static const String metaFacebook = 'Facebook';
  static const String metaTwitter = 'Twitter';

  /* API Route - Collection */
  static const String bundle = 'bundle';
  static const String category = 'category';
  static const String experience = 'experience';
  static const String faq = 'faq';
  static const String product = 'product';
  static const String socialMedia = 'social-media';
  static const String team = 'team';
  static const String testimonial = 'testimonial';

/* API Route - Single Type */
  static const String aboutPage = 'about-page';
  static const String faqPage = 'faq-page';
  static const String galleryPage = 'gallery';
  static const String homePage = 'homepage';
  static const String productPage = 'product-page';
  static const String configPage = 'config';
  static const String privacyPolicyPage = 'privacy-policy-page';
  static const String termsServicePage = 'terms-of-service-page';

  /* Internationalization */
  static const String localeID = 'id-ID';

  /* External Link */
  static const String markdownStackEdit = 'https://stackedit.io/app';

  /* Notification Messages */
  static const String urlLauncherFailed = 'Failed to open link!';
  static const String appExitGesture = 'Double tap to exit app!';
}