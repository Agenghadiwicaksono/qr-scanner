import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class QrGeneratorScanner extends StatefulWidget {
  const QrGeneratorScanner({super.key});

  @override
  State<QrGeneratorScanner> createState() => _QrGeneratorScannerState();
}

class _QrGeneratorScannerState extends State<QrGeneratorScanner> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true
  );
  String? barcodeValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => CustomSnackbar()
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              _handleQrDetection(capture);
            },
          ),
          Center(
            child: CustomPaint(
              size: Size(150, 150),
              painter: SmoothRoundedPainter(),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Container(
              child: Text(
                textAlign: TextAlign.center,
                'Print the QR Code fuck sdk',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            )
          )
        ],
      ),
    );
  }
  void _handleQrDetection(BarcodeCapture capture) {
    final Uint8List? image = capture.image;
    final List<Barcode> value = capture.barcodes;


    for (final barcode in value) {
      barcodeValue = barcode.rawValue!;
    }
    if (image != null) {
      _controller.stop(); // Hentikan pemindaian sementara
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("QR Code Detected"),
              const SizedBox(height: 10),
              Image.memory(image),
              Text(barcodeValue!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              // Tombol tutup
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Tombol Salin
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: barcodeValue!));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.copy),
                        Text("Copy"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _controller.start(); // Mulai pemindaian kembali
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.close),
                        Text("Close"),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}

// Painter dan Snackbar tetap sama seperti sebelumnya
class SmoothRoundedPainter extends CustomPainter {
 @override
 void paint(Canvas canvas, Size size) {
   final paint = Paint()
     ..color = Colors.white
     ..style = PaintingStyle.stroke
     ..strokeWidth = 4;


   final path = Path();
   const double cornerSize = 20;


   // Sudut kiri atas
   path.moveTo(0, cornerSize);
   path.lineTo(0, 0);
   path.lineTo(cornerSize, 0);


   // Sudut kanan atas
   path.moveTo(size.width - cornerSize, 0);
   path.lineTo(size.width, 0);
   path.lineTo(size.width, cornerSize);


   // Sudut kiri bawah
   path.moveTo(0, size.height - cornerSize);
   path.lineTo(0, size.height);
   path.lineTo(cornerSize, size.height);


   // Sudut kanan bawah
   path.moveTo(size.width - cornerSize, size.height);
   path.lineTo(size.width, size.height);
   path.lineTo(size.width, size.height - cornerSize);


   canvas.drawPath(path, paint);
 }


 @override
 bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// snackbar kustom untuk informasi tambahan.
class CustomSnackbar extends StatelessWidget {
 const CustomSnackbar({super.key});


 @override
 Widget build(BuildContext context) {
   return Container(
     margin: const EdgeInsets.all(16),
     padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(16),
       boxShadow: const [
         BoxShadow(
           color: Colors.black26,
           blurRadius: 10,
           offset: Offset(0, 4),
         ),
       ],
     ),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         const Text(
           "Scan QR Code",
           style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.bold,
             color: Colors.black,
           ),
         ),
         const SizedBox(height: 10),
         const Text(
           "Place QR code inside the frame to scan. Please avoid shake to get results quickly.",
           style: TextStyle(
             fontSize: 14,
             color: Colors.black54,
           ),
           textAlign: TextAlign.center,
         ),
         const SizedBox(height: 20),
         Center(
           child: Image.asset(
             'assets/images/scan-icon.png',
             width: 220,
             height: 220,
           ),
         ),
       ],
     ),
   );
 }
}


