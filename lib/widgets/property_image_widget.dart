import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jidetaiwoapp/model/property_image_model.dart';
import 'package:jidetaiwoapp/provider/property_image_provider.dart';
import 'package:provider/provider.dart';

class PropertyImageWidget extends StatefulWidget {
  final String id;
  const PropertyImageWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<PropertyImageWidget> createState() => _PropertyImageWidgetState();
}

class _PropertyImageWidgetState extends State<PropertyImageWidget> {
  late Future<String?> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _getPropertyImages(context, widget.id);
  }

  Future<String?> _getPropertyImages(BuildContext context, String id) async {
    final Map<String, PropertyImage> properyImages =
        Provider.of<PropertyImageProvider>(context, listen: false)
            .getpropertyimages;
    if (properyImages[id] == null) {
        return await Provider.of<PropertyImageProvider>(context, listen: false)
            .fetchpropertyimages(id);
    } else {
      return properyImages[id]!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureData,
        builder: (context, data) {
          if (data.hasData) {
            return SizedBox(
                width: double.infinity,
                height: 200,
                child: CachedNetworkImage(
                    imageUrl:
                        'http://jidetaiwoandco.com/crmportal/app/webroot/img/propertiesphotos/${data.data.toString()}',
                    fit: BoxFit.cover,
                    key: ValueKey(data.data.toString()),
                    cacheKey: data.data.toString(),
                    placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: 35,
                            width: 35,
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor))),
                    errorWidget: (context, url, error) {
                      return Icon(Icons.error);
                    }));
          } else if (data.hasError) {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(child: Icon(Icons.error)),
            );
          } else {
            return SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                  child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              )),
            );
          }
        });
  }
}
