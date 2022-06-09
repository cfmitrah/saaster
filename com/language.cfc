
component displayname="language" output="false" {

    // Change browsers language to locale
    public string function toLocale(string language) {

        if (structKeyExists(arguments, "language")) {

            switch(arguments.language) {

                case "nl_BE":
                    local.locale = "Dutch (Belgian)";
                    break;

                case value="nl_NK":
                    local.locale = "Dutch (Standard)";
                    break;

                case value="en_AU":
                    local.locale = "English (Australian)";
                    break;

                case value="en_CA":
                    local.locale = "English (Canadian)";
                    break;

                case value="en_GB":
                    local.locale = "English (UK)";
                    break;

                case value="en_NZ":
                    local.locale = "English (New Zealand)";
                    break;

                case value="en":
                    local.locale = "English (US)";
                    break;

                case value="en_US":
                    local.locale = "English (US)";
                    break;

                case value="fr_BE":
                    local.locale = "French (Belgian)";
                    break;

                case value="fr_CA":
                    local.locale = "French (Canadian)";
                    break;

                case value="fr":
                    local.locale = "French (Standard)";
                    break;

                case value="fr_CH":
                    local.locale = "French (Swiss)";
                    break;

                case value="de_AT":
                    local.locale = "German (Austrian)";
                    break;

                case value="de_DE":
                    local.locale = "German (Germany)";
                    break;

                case value="de":
                    local.locale = "German (Standard)";
                    break;

                case value="de_CH":
                    local.locale = "German (Swiss)";
                    break;

                case value="it_IT":
                    local.locale = "Italian (Standard)";
                    break;

                case value="it_CH":
                    local.locale = "Italian (Swiss)";
                    break;

                case value="no_NO":
                    local.locale = "Norwegian (Bokmal)";
                    break;

                case value="no_NO@nynorsk":
                    local.locale = "Norwegian (Nynorsk)";
                    break;

                case value="pl_PL":
                    local.locale = "Polish (Poland)";
                    break;

                case value="pt_BR":
                    local.locale = "Portuguese (Brazilian)";
                    break;

                case value="pt_PT":
                    local.locale = "Portuguese (Standard)";
                    break;

                case value="es_MX":
                    local.locale = "Spanish (Mexican)";
                    break;

                case value="es_ES":
                    local.locale = "Spanish (Standard)";
                    break;

                case value="ru":
                    local.locale = "ru_RU";
                    break;

                case value="ru_RU":
                    local.locale = "ru_RU";
                    break;

                case value="sv_SE":
                    local.locale = "Swedish";
                    break;

                case value="ja_JP":
                    local.locale = "Japanese";
                    break;

                case value="ko_KR":
                    local.locale = "Korean";
                    break;

                case value="zh":
                    local.locale = "Chinese (China)";
                    break;

                case value="zh_HK":
                    local.locale = "Chinese (Hong Kong)";
                    break;

                case value="zh_TW":
                    local.locale = "Chinese (Taiwan)";
                    break;

                default:
                   local.locale = "English (US)";
                   break;
            }


        } else {

            local.locale = "English (US)";

        }

        return local.locale;

    }

}

