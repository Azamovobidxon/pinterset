import '../common/utils/load_into_cheak_memory.dart';
import '../common/utils/network_image_download.dart';
import 'package:flutter/material.dart';
import '../common/utils/snack_bar.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    super.key,
    required this.images,
    required this.downloadLinks,
  });

  final List<String> images;
  final List<String> downloadLinks;

  @override
  State<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem> {
  int downloadPercent = 0;
  double? _progress;

  @override
  Widget build(BuildContext context) => PageView(
    scrollDirection: Axis.vertical,
    children: List.generate(
      widget.images.length,
          (index) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: buildImageWidget(widget.images[index]),
            ),
            _progress != null
                ? const CircularProgressIndicator()
                : Padding(
              padding: const EdgeInsets.only(
                bottom: 70,
                right: 15,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton.filled(
                  onPressed: () {
                    _progress = downloadImage(
                        widget.downloadLinks[index], context);
                    showSnackBar(
                      context: context,
                      color: Colors.blue,
                      text: "Downloading...",
                    );
                  },
                  icon: const Icon(Icons.download),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blueAccent,
                    ),
                    minimumSize: MaterialStateProperty.all(
                      const Size(70, 70),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
