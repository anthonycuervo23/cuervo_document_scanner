/*
  API Responce Error - 100 + Server Error code
  UnauthorisedException - 101
  SocketException ClientException with SocketException - 102
  SocketException ClientException with Software - 103
  SocketException General - 104
  Other Exception - 105 - Bad Gateway

   return CommonWidget().dataNotFound(
       context: context,
       heading: TranslationConstants.something_went_wrong.translate(context),
       subHeading: state.errorMessage,
       buttonLabel: TranslationConstants.try_again.translate(context),
       onTap: () {
         homeCubit.myBusinessViewCubit.loadLocalJson();
         if (isBusinessUpdated || (myBusinessList?.isEmpty ?? true)) {
           homeCubit.myBusinessViewCubit.loadBusinessData();
         }
       },
   );

*/