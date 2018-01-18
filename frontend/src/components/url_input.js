import React, { Component } from 'react';
import URLList from './url_list';

class URLInput extends Component {
  constructor(props) {
    super(props);

    this.state = { 
      url: '',
      message: ''
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange(event) {
    this.setState({url: event.target.value});
  }
  
  handleSubmit(event) {
    fetch('/api/url', { 
      method: 'POST', 
      body: JSON.stringify( { url: this.state.url }),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    }).then((response) =>  {
          if (!response.ok) {
            throw Error(response);
          }
          return response.json;
       }).then((response) => {
         this.setState({
           message: 'URL created!', 
           url: ''
         });
       }).catch((error) => {
         this.setState({ message: 'Please provide a valid URL'});
    });
    
    event.preventDefault();
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <p> { this.state.message } </p>
          <label>
            URL: <input value={this.state.url} onChange={this.handleChange} />        
          </label>
          <input type="submit" value="Submit" />
        </form>
        <URLList />
     </div>   
    )
  }
}

export default URLInput;
