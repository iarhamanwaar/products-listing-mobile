import 'package:product_listing_app/products/data/models/product_model.dart';
import 'package:product_listing_app/products/domain/entities/product.dart';
import 'package:product_listing_app/products/domain/repositories/product_repository.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return [
      const ProductModel(
        id: '1',
        name: 'Premium Wireless Headphones',
        price: 299.99,
        imageUrl: 'https://picsum.photos/200?random=1',
        description:
            'High-end wireless headphones with active noise cancellation, 30-hour battery life, and premium sound quality',
      ),
      const ProductModel(
        id: '2',
        name: 'Smart Watch Pro',
        price: 399.99,
        imageUrl: 'https://picsum.photos/200?random=2',
        description:
            'Advanced smartwatch with ECG monitoring, sleep tracking, and 5-day battery life',
      ),
      const ProductModel(
        id: '3',
        name: 'Travel Laptop Backpack',
        price: 89.99,
        imageUrl: 'https://picsum.photos/200?random=3',
        description:
            'Water-resistant backpack with anti-theft design, USB charging port, and 15 compartments',
      ),
      const ProductModel(
        id: '4',
        name: 'Premium Bluetooth Speaker',
        price: 179.99,
        imageUrl: 'https://picsum.photos/200?random=4',
        description:
            'Waterproof speaker with 360° sound, 24-hour battery life, and deep bass',
      ),
      const ProductModel(
        id: '5',
        name: 'Ergonomic Gaming Mouse',
        price: 79.99,
        imageUrl: 'https://picsum.photos/200?random=5',
        description:
            '16000 DPI gaming mouse with RGB lighting and programmable buttons',
      ),
      const ProductModel(
        id: '6',
        name: 'USB-C Docking Station',
        price: 199.99,
        imageUrl: 'https://picsum.photos/200?random=6',
        description:
            '12-in-1 docking station with dual 4K display support and 100W power delivery',
      ),
      const ProductModel(
        id: '7',
        name: 'Mechanical Keyboard',
        price: 149.99,
        imageUrl: 'https://picsum.photos/200?random=7',
        description:
            'RGB mechanical keyboard with hot-swappable switches and premium PBT keycaps',
      ),
      const ProductModel(
        id: '8',
        name: '4K Webcam',
        price: 199.99,
        imageUrl: 'https://picsum.photos/200?random=8',
        description:
            'Professional 4K webcam with AI-powered auto-focus and low-light correction',
      ),
      const ProductModel(
        id: '9',
        name: 'Portable SSD',
        price: 159.99,
        imageUrl: 'https://picsum.photos/200?random=9',
        description:
            '1TB portable SSD with 1050MB/s read speeds and military-grade encryption',
      ),
      const ProductModel(
        id: '10',
        name: 'Wireless Charging Pad',
        price: 39.99,
        imageUrl: 'https://picsum.photos/200?random=10',
        description:
            '15W fast wireless charger with multi-device support and sleek design',
      ),
      const ProductModel(
        id: '11',
        name: 'Smart Home Hub',
        price: 129.99,
        imageUrl: 'https://picsum.photos/200?random=11',
        description:
            'Central smart home controller with voice control and automation support',
      ),
      const ProductModel(
        id: '12',
        name: 'Noise-Canceling Earbuds',
        price: 249.99,
        imageUrl: 'https://picsum.photos/200?random=12',
        description:
            'True wireless earbuds with adaptive noise cancellation and spatial audio',
      ),
      const ProductModel(
        id: '13',
        name: 'Ultra-Wide Monitor',
        price: 699.99,
        imageUrl: 'https://picsum.photos/200?random=13',
        description:
            '34" curved ultra-wide monitor with 165Hz refresh rate and HDR support',
      ),
      const ProductModel(
        id: '14',
        name: 'Streaming Microphone',
        price: 129.99,
        imageUrl: 'https://picsum.photos/200?random=14',
        description:
            'Professional USB microphone with real-time voice effects and RGB lighting',
      ),
      const ProductModel(
        id: '15',
        name: 'Graphics Tablet',
        price: 299.99,
        imageUrl: 'https://picsum.photos/200?random=15',
        description:
            'Professional drawing tablet with 8192 pressure levels and tilt support',
      ),
      const ProductModel(
        id: '16',
        name: 'Smart Light Strip',
        price: 49.99,
        imageUrl: 'https://picsum.photos/200?random=16',
        description:
            'RGBIC light strip with music sync and smart home integration',
      ),
      const ProductModel(
        id: '17',
        name: 'Laptop Stand',
        price: 59.99,
        imageUrl: 'https://picsum.photos/200?random=17',
        description:
            'Adjustable aluminum laptop stand with built-in cooling fans',
      ),
      const ProductModel(
        id: '18',
        name: 'Cable Management Kit',
        price: 29.99,
        imageUrl: 'https://picsum.photos/200?random=18',
        description:
            'Complete cable management solution with sleeves, clips, and ties',
      ),
      const ProductModel(
        id: '19',
        name: 'Wireless Presenter',
        price: 45.99,
        imageUrl: 'https://picsum.photos/200?random=19',
        description:
            'Professional presentation remote with laser pointer and timer',
      ),
      const ProductModel(
        id: '20',
        name: 'Power Bank',
        price: 69.99,
        imageUrl: 'https://picsum.photos/200?random=20',
        description: '26800mAh power bank with 65W USB-C PD fast charging',
      ),
    ];
  }
}
