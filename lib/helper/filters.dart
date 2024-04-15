


import 'filters_s.dart';

class Filters {

  List<Filter> list() {
    return <Filter>[
      Filter(
          'No Filter',
          [
            1, 0, 0, 0, 0,
            0, 1, 0, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 0, 1, 0,
          ]
      ),
      Filter(
        'Vivid',
        [
          1.2, 0, 0, 0, 0,
          0, 1.2, 0, 0, 0,
          0, 0, 1.2, 0, 0,
          0, 0, 0, 1, 0,
        ],
      ),


      Filter(
        'Vivid Cool',
        [
          1.2, 0, 0, 0, 0,
          0, 1.2, 0, 0, 0,
          0, 0, 1, 0.1, 0,
          0, 0, 0, 1, 0,
        ],
      ),

      Filter(
        'Dramatic Cool',
        [
          1.2, 0, 0, 0, 0,
          0, 1.1, 0, 0, 0, // Enhance blue tones
          0, 0, 1.2, 0, 0, // Enhance blue tones
          0, 0, 0, 1, 0,
        ],
      ),
      Filter(
        'Dramatic',
        [
          1.3, 0, 0, 0, 0, // Increase contrast
          0, 1.3, 0, 0, 0, // Increase contrast
          0, 0, 1.3, 0, 0, // Increase contrast
          0, 0, 0, 1, 0,
        ],
      ),
      Filter(
        'Dramatic Warm',
        [
          1.2, 0, 0, 0, 0,
          0, 1.1, 0, 0, 0, // Enhance red tones
          0, 0, 1.2, 0, 0, // Enhance red tones
          0, 0, 0, 1, 0,
        ],
      ),
      Filter(
        'Mono',
        [
          0.33, 0.33, 0.33, 0, 0, // Convert to grayscale
          0.33, 0.33, 0.33, 0, 0, // Convert to grayscale
          0.33, 0.33, 0.33, 0, 0, // Convert to grayscale
          0, 0, 0, 1, 0, // Leave alpha channel unchanged
        ],
      ),
      Filter(
        'Silvertone',
        [
          0.3, 0.6, 0.1, 0, 0, // Adjust to desaturate image
          0.3, 0.6, 0.1, 0, 0, // Adjust to desaturate image
          0.3, 0.6, 0.1, 0, 0, // Adjust to desaturate image
          0, 0, 0, 1, 0, // Leave alpha channel unchanged
        ],
      ),
      Filter(
        'Noir',
        [
          0.4, 0.4, 0.4, 0, 0, // Convert to grayscale with reduced brightness
          0.4, 0.4, 0.4, 0, 0, // Convert to grayscale with reduced brightness
          0.4, 0.4, 0.4, 0, 0, // Convert to grayscale with reduced brightness
          0, 0, 0, 1, 0, // Leave alpha channel unchanged
        ],
      ),

      // Filter(
      //     'Purple',
      //     [
      //       1, -0.2, 0, 0, 0,
      //       0, 1, 0, -0.1, 0,
      //       0, 1.2, 1, 0.1, 0,
      //       0, 0, 1.7, 1, 0
      //     ]
      // ),
      // Filter(
      //     'Yellow',
      //     [
      //       1, 0, 0, 0, 0,
      //       -0.2, 1.0, 0.3, 0.1, 0,
      //       -0.1, 0, 1, 0, 0,
      //       0, 0, 0, 1, 0,
      //     ]
      // ),
      // Filter(
      //     'Cyan',
      //     [
      //       1, 0, 0, 1.9, -2.2,
      //       0, 1, 0, 0.0, 0.3,
      //       0, 0, 1, 0, 0.5,
      //       0, 0, 0, 1, 0.2
      //     ]
      // ),
      // Filter(
      //     'B&W',
      //     [
      //       0, 1, 0, 0, 0,
      //       0, 1, 0, 0, 0,
      //       0, 1, 0, 0, 0,
      //       0, 1, 0, 1, 0,
      //     ]
      // ),
      // Filter(
      //     'Old Times',
      //     [
      //       1, 0, 0, 0, 0,
      //       -0.4, 1.3, -0.4, 0.2, -0.1,
      //       0, 0, 1, 0, 0,
      //       0, 0, 0, 1, 0
      //     ]
      // ),
      // Filter(
      //     'Cold Life',
      //     [
      //       1, 0, 0, 0, 0,
      //       0, 1, 0, 0, 0,
      //       -0.2, 0.2, 0.1, 0.4, 0,
      //       0, 0, 0, 1, 0,
      //     ]
      // ),
      // Filter(
      //     'Sepium',
      //     [
      //       1.3, -0.3, 1.1, 0, 0,
      //       0, 1.3, 0.2, 0, 0,
      //       0, 0, 0.8, 0.2, 0,
      //       0, 0, 0, 1, 0
      //     ]
      // ),
      // Filter(
      //     'Milk',
      //     [
      //       0, 1.0, 0, 0, 0,
      //       0, 1.0, 0, 0, 0,
      //       0, 0.6, 1, 0, 0,
      //       0, 0, 0, 1, 0,
      //     ]
      // ),

    ];
  }

}