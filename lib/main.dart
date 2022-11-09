import 'package:flutter/material.dart';
import 'package:flutter_playground/hexcolor.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UIBuilder.pageFromJsonWithData(
          context: context, uiMeta: uiJsonData, data: listData),
    );
  }
}

class UIBuilder {
  static Widget pageFromJsonWithData({
    required Map<String, dynamic> uiMeta,
    required BuildContext context,
    required List<Map<String, dynamic>> data,
  }) {
    List<Map<String, dynamic>> metaBody =
        List<Map<String, dynamic>>.from(uiMeta['screen']['body']);

    return Scaffold(
      appBar: appBarFromJson(uiMeta, context),
      backgroundColor: HexColor.fromHex(uiMeta['screen']['bg_color']),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: metaBody
              .map((uiElement) => widgetFromJson(
                  uiElement: uiElement, context: context, data: data))
              .toList(),
        ),
      ),
    );
  }

  static Widget widgetFromJson(
      {required Map<String, dynamic> uiElement,
      required BuildContext context,
      required List<Map<String, dynamic>>? data}) {
    switch (uiElement['type']) {
      case 'list':
        return getListView(context, uiData: uiElement, data: data);

      case 'list_item':
        return getListItem(context, uiData: uiElement, data: data![0]);

      case 'sized_box':
        return getSizedBox(
          uiData: uiElement,
        );

      case 'text':
        if (uiElement.containsKey('content')) {
          return getTextWithContent(uiData: uiElement);
        } else {
          return getText(data: data![0], uiData: uiElement);
        }
      default:
        return Container(
          color: Colors.cyan,
          width: 10,
          height: 10,
        );
    }
  }

  static Widget getSizedBox({required Map<String, dynamic> uiData}) {
    return SizedBox(
      height: uiData['height'],
      width: uiData['width'],
    );
  }

  static Widget getListView(BuildContext context,
      {required Map<String, dynamic> uiData,
      required List<Map<String, dynamic>>? data}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data!.length,
      separatorBuilder: (BuildContext context, int index) => widgetFromJson(
          uiElement: uiData['separator'], context: context, data: null),
      itemBuilder: (BuildContext context, int index) {
        return widgetFromJson(
            uiElement: uiData['items'][0],
            context: context,
            data: [data[index]]);
      },
    );
  }

  static Widget getTextWithContent({required Map<String, dynamic> uiData}) {
    return Text(
      uiData['content'],
      style: TextStyle(
        color: HexColor.fromHex(
          uiData['decorations']['text_color'],
        ),
        fontSize: uiData['decorations']['text_font_size'],
      ),
    );
  }

  static Widget getText(
      {required Map<String, dynamic>? data,
      required Map<String, dynamic> uiData}) {
    return Text(
      data![uiData['content_field']],
      style: TextStyle(
        color: HexColor.fromHex(
          uiData['decorations']['text_color'],
        ),
        fontSize: uiData['decorations']['text_font_size'],
      ),
    );
  }

  static AppBar appBarFromJson(
      Map<String, dynamic> json, BuildContext context) {
    return AppBar();
  }

  static Widget bottomFromMeta(metaBoFloatingWidget, context) {
    return Container();
  }

  static Widget getListItem(BuildContext context,
      {required Map<String, dynamic> data,
      required Map<String, dynamic> uiData}) {
    return Ink(
      padding: EdgeInsets.all(uiData['decorations']['padding']),
      decoration: BoxDecoration(
        color: HexColor.fromHex(uiData['decorations']['bg_color']),
        borderRadius: BorderRadius.all(
            Radius.circular(uiData['decorations']['border_radius'])),
      ),
      width: double.infinity,
      child: InkWell(
        borderRadius: BorderRadius.all(
            Radius.circular(uiData['decorations']['border_radius'])),
        child: Column(
          children: (uiData['children'] as List)
              .map((uiElement) => widgetFromJson(
                  uiElement: uiElement, context: context, data: [data]))
              .toList(),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> listData = [
  {
    'title': 'My Title1',
    'desc': 'my desc1',
  },
  {
    'title': 'My Title2',
    'desc': 'my desc2',
  },
  {
    'title': 'My Title3',
    'desc': 'my desc3',
  },
  {
    'title': 'My Title4',
    'desc': 'my desc4',
  },
  {
    'title': 'My Title1',
    'desc': 'my desc1',
  },
  {
    'title': 'My Title2',
    'desc': 'my desc2',
  },
  {
    'title': 'My Title3',
    'desc': 'my desc3',
  },
  {
    'title': 'My Title4',
    'desc': 'my desc4',
  },
  {
    'title': 'My Title1',
    'desc': 'my desc1',
  },
  {
    'title': 'My Title2',
    'desc': 'my desc2',
  },
  {
    'title': 'My Title3',
    'desc': 'my desc3',
  },
  {
    'title': 'My Title4',
    'desc': 'my desc4',
  },
  {
    'title': 'My Title1',
    'desc': 'my desc1',
  },
  {
    'title': 'My Title2',
    'desc': 'my desc2',
  },
  {
    'title': 'My Title3',
    'desc': 'my desc3',
  },
  {
    'title': 'My Title4',
    'desc': 'my desc4',
  },
];

// Map<String, dynamic> uiJsonData = {
//   'screen': {
//     'bg_color': '#FFFFFF',
//     'app_bar': {
//       'title': {
//         'type': 'text',
//         'content': 'Hello, world',
//         'decorations': {
//           'text_color': '#003366',
//           'text_font_weight': 'bold',
//           'text_font_size': 24.0
//         }
//       },
//       'actions': [
//         {
//           'action_button': 'add',
//           'icon': 'icon_add',
//           'method': 'increment',
//         },
//         {
//           'action_button': 'add',
//           'icon': 'icon_add',
//           'method': 'increment',
//         },
//       ],
//     },
//     'body': [
//       {
//         'type': 'text',
//         'content': 'Hello, world',
//         'decorations': {
//           'text_color': '#003366',
//           'text_font_weight': 'bold',
//           'text_font_size': 24.0
//         },
//       },
//       {
//         'type': 'list',
//         'separator': {
//           'type': 'sized_box',
//           'height': 8.0,
//           'width': 0.0,
//         },
//         'items': [
//           {
//             'type': 'list_item',
//             'decorations': {
//               'bg_color': '#32a852',
//               'border_radius': 16.0,
//               'padding': 8.0,
//             },
//             'children': [
//               {
//                 'type': 'text',
//                 'content_field': 'title',
//                 'decorations': {
//                   'text_color': '#003366',
//                   'text_font_weight': 'bold',
//                   'text_font_size': 24.0
//                 }
//               },
//               {
//                 'type': 'text',
//                 'content_field': 'desc',
//                 'decorations': {
//                   'text_color': '#003366',
//                   'text_font_weight': 'bold',
//                   'text_font_size': 24.0
//                 }
//               },
//             ],
//           },
//         ]
//       },
//     ],
//     'bottom': {},
//   }
// };
Map<String, dynamic> uiJsonData = {
  'screen': {
    'bg_color': '#FFFFFF',
    'app_bar': {
      'title': {
        'type': 'text',
        'content': 'Hello, world',
        'decorations': {
          'text_color': '#003366',
          'text_font_weight': 'bold',
          'text_font_size': 24.0
        }
      },
    },
    'body': [
      {
        'type': 'text',
        'content': 'Hello, world',
        'decorations': {
          'text_color': '#003366',
          'text_font_weight': 'bold',
          'text_font_size': 24.0
        },
      },
      {
        'type': 'list',
        'separator': {
          'type': 'sized_box',
          'height': 8.0,
          'width': 0.0,
        },
        'items': [
          {
            'type': 'list_item',
            'decorations': {
              'bg_color': '#32a852',
              'border_radius': 16.0,
              'padding': 8.0,
            },
            'children': [
              {
                'type': 'text',
                'content_field': 'title',
                'decorations': {
                  'text_color': '#003366',
                  'text_font_weight': 'bold',
                  'text_font_size': 24.0
                }
              },
              {
                'type': 'text',
                'content_field': 'desc',
                'decorations': {
                  'text_color': '#003366',
                  'text_font_weight': 'bold',
                  'text_font_size': 24.0
                }
              },
            ],
          },
        ]
      },
    ],
    'bottom': {},
  }
};
