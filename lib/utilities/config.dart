class Config {
  static const topicUrl =
      'https://api.unsplash.com/topics/?client_id=BI9EsWb8tvg_s0o5i0JzEaFWDSRzorFbdmMj2Nj0rrQ&per_page=50';

  static String getAllPhotos(String photoUrl) {
    return photoUrl + '?client_id=BI9EsWb8tvg_s0o5i0JzEaFWDSRzorFbdmMj2Nj0rrQ&per_page=50';
  }
}
