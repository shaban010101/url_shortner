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
      .then((data) => { this.setState({urls: data})})
  };
  
     render() {
       console.log(typeof this.state.urls);
       const mappedUrls = Object.entries(this.state.urls).map((url, index) => {
         return <li key={index}> URL: {url[1]}   Short URL: {url[0]}</li>
      });

      if (Object.keys(this.state.urls).length > 0) {
        return (
          <ul>
            {mappedUrls} 
          </ul>
        )
      } else {
        return <p>No results to show</p>;
      }
  }
}

export default URLList;
