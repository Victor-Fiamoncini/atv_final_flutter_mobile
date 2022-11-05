import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  final FetchLocationUseCase fetchLocationUseCase;
  final FetchAddressUseCase fetchAddressUseCase;

  const HomePage({
    required this.fetchLocationUseCase,
    required this.fetchAddressUseCase,
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<AddressEntity> _getUserAddress() async {
    try {
      final position = await widget.fetchLocationUseCase.fetchLocation();
      final address = await widget.fetchAddressUseCase.fetchAddress(
        FetchAddressUseCaseParams(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );

      return address;
    } catch (e) {
      print('ERRRRRRRRRRRRRRRRRROU');
      print(e);
      throw Exception('');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/main-background.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.primary.withOpacity(0.68),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Center(
            child: FutureBuilder(
              future: _getUserAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error');
                }

                if (snapshot.hasData) {
                  print(snapshot.data?.country);

                  return Text(snapshot.data?.city as String);
                }

                return SpinKitThreeBounce(
                  color: theme.colorScheme.primary,
                  size: 82,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
