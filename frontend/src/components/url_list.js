import React, { Component } from 'react';

class URLList extends Component { 
  constructor(props) {
    super(props);

    this.state = { 
      urls: []
    };
  }
  
  componentDidMount() {
    fetch('/api/urls', { method: 'GET' })
      .then((response) => { return response.json(); })
      .then((data) => { this.setState({urls: data })})
  };
  
     render() {
       console.log(typeof this.state.urls);
       const mappedURLS = Object.entries(this.state.urls).map((url, index) => {
         const shortURL = url[0];
         const URL      = url[1];
         return <li key={index}>URL {URL}  Short URL {shortURL} </li>
      });

      if (Object.keys(this.state.urls).length > 0) {
        return (
          <ul>
            {mappedURLS} 
          </ul>
        )
      } else {
        return <p>No results to show</p>;
      }
  }
}

export default URLList;
