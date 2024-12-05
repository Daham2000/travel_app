import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/ui/invitation_page/invitation_bloc.dart';
import 'package:travel_app/ui/invitation_page/invitation_view.dart';

class InvitationProvider extends BlocProvider<InvitationBloc> {
  InvitationProvider({Key? key})
      : super(
          key: key,
          create: (context) => InvitationBloc(),
          child: InvitationView(),
        );
}
