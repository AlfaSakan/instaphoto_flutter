import '../models/models.dart';

class PostPageArguments {
  final Post post;
  final User user;
  final String imagePost;
  final String imageProfile;

  PostPageArguments(this.post, this.user, this.imagePost, this.imageProfile);
}
