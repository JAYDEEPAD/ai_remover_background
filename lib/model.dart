class RemoveBackgroundRequest {
  final String imageUrl;

  RemoveBackgroundRequest(this.imageUrl);

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
    };
  }
}
