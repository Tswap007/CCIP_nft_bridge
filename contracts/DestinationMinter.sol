// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {WonderlandWanderers} from "./WonderlandWanderers.sol";

contract DestinationMinter is CCIPReceiver {
    WonderlandWanderers nft;

    event MintCallSuccessfull();

    constructor(address router, address nftAddress) CCIPReceiver(router) {
        nft = WonderlandWanderers(nftAddress);
    }

    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        (bool success, ) = address(nft).call(message.data);
        require(success);
        emit MintCallSuccessfull();
    }
}
