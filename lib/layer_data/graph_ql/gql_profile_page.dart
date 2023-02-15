class GqlProfilePage{

    String getWalletData(){
        return """
            mutation MyMutation2 {
              getWallet {
                balance
              }
            }
        """;
    }

}