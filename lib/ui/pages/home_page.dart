import 'package:atv_final_flutter_mobile/domain/entities/address_entity.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_address_use_case.dart';
import 'package:atv_final_flutter_mobile/domain/usecases/fetch_location_use_case.dart';
import 'package:atv_final_flutter_mobile/ui/widgets/background_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

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
    final position = await widget.fetchLocationUseCase.fetchLocation();
    final address = await widget.fetchAddressUseCase.fetchAddress(
      FetchAddressUseCaseParams(
        latitude: position.latitude,
        longitude: position.longitude,
      ),
    );

    return address;
  }

  Widget _buildErrorMessage(ThemeData theme) {
    return Center(
      child: Text(
        'Houve um erro ao buscar as informações, tente novamente em breve',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildLoading(ThemeData theme) {
    return SpinKitThreeBounce(
      color: theme.colorScheme.primary,
      size: 76,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundWrapper(
          child: Center(
            child: Container(
              width: mediaQuery.size.width,
              constraints: BoxConstraints(
                maxHeight: 400,
                minHeight: 380,
                minWidth: mediaQuery.size.width,
              ),
              child: Card(
                elevation: 50,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: FutureBuilder(
                    future: _getUserAddress(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return _buildErrorMessage(theme);

                      if (snapshot.hasData) {
                        final city = snapshot.data?.city ?? '';
                        final date = DateFormat(DateFormat.YEAR_MONTH).format(
                          DateTime.now(),
                        );

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  city,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }

                      return _buildLoading(theme);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
