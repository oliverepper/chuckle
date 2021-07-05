//
// Created by Oliver Epper on 05.07.21.
//

#include "chuckle/chuckle.h"
#include <cpr/cpr.h>
#include <nlohmann/json.hpp>

using namespace std;
using namespace cpr;
using json = nlohmann::json;

std::string joke() {
    Response r = Get(Url("https://api.chucknorris.io/jokes/random"));
    json j = json::parse(r.text);

    return j["value"];
}