import React, { Component } from 'react'
import DominantAssuranceContract from '../build/contracts/DominantAssuranceContract.json'
import getWeb3 from './utils/getWeb3'

import './css/oswald.css'
import './css/open-sans.css'
import './css/pure-min.css'
import './App.css'

class App extends Component {
  constructor(props) {
    super(props)

    this.state = {
      address: '0x0',
      goal: 0,
      active: false,
      refundPercentage: 0,
      pledgeCount: 0,
      timeLeft: 0,
      web3: null,   
      instance: null
    }
  }

  componentWillMount() {
    // Get network provider and web3 instance.
    // See utils/getWeb3 for more info.

    getWeb3
    .then(results => {
      this.setState({
        web3: results.web3
      })

      // Instantiate contract once web3 provided.
      this.instantiateContract()
    })
    .catch(() => {
      console.log('Error finding web3.')
    })
  }

  instantiateContract() {
    const contract = require('truffle-contract')
    const dominantAssurance = contract(DominantAssuranceContract)
    dominantAssurance.setProvider(this.state.web3.currentProvider)

    let dominantAssuranceInstance 

      dominantAssurance.deployed().then((instance) => {
        dominantAssuranceInstance = instance
        this.setState({instance: dominantAssuranceInstance})
        this.setState({address: dominantAssuranceInstance.address})
        
      }).then((result) => {
        // Get the value from the contract to prove it worked.
        return dominantAssuranceInstance.pledgeCountGoal()
      }).then((result2) => {
        // Update state with the result.
        return this.setState({pledgeCount: result2 })
      })
    }
  
  render() {
    return (
      <div className="App">
        <nav className="navbar pure-menu pure-menu-horizontal">
            <a href="#" className="pure-menu-heading pure-menu-link">Provide</a>
        </nav>

        <main className="container">
          <div className="pure-g">
            <div className="pure-u-1-1">
              <h1>Good to Go!</h1>
              <p>Your Truffle Box is installed and ready.</p>
              <h2>Smart Contract Example</h2>
              <p>If your contracts compiled and migrated successfully, below will show a stored value of 5 (by default).</p>
              <p>Try changing the value stored on <strong>line 59</strong> of App.js.</p>
              <p>Is the campaign active?: {this.state.pledgeCount}</p>
              <p>Contract address: {this.state.address}</p>
            </div>
          </div>
        </main>
      </div>
    );
  }
}

export default App