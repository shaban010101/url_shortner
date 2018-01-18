import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import URLInput from './components/url_input';
import URLList from './components/url_list';

class App extends Component {
  render() {
    return (
      <div className="App">
        <URLInput />
      </div>
    );
  }
}

export default App;
