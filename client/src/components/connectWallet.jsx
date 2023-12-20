import React, { useState } from "react";
import { ethers } from "ethers";
import FirstPage from "./firstPage";

const SetUpWallet = () => {
  // for accounts
  const [account, setAccount] = useState("Not Connected");

  // Connect To metaMask

  const requestAccounts = async () => {
    if (window.ethereum) {
      console.log("MetaMask Present");

      try {
        const { ethereum } = window;
        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        console.log("addreses are : ", accounts);
        setAccount(accounts[0]);
        window.ethereum.on("accountsChanged", function (accounts) {
          setAccount(accounts[0]);
        });
      } catch (error) {
        console.log(err);
      }
    } else {
      console.log("No MetaMask Installed");
    }
  };

  const walletConnect = async () => {
    if (typeof window.ethereum !== "undefined") {
      requestAccounts();
    }

    //For Smart Contract Interaction
    const provider = new ethers.BrowserProvider(window.ethereum);
  };
  return (
    <div>
      <FirstPage account={account} walletConnect={walletConnect} />
    </div>
  );
};

export default SetUpWallet;
