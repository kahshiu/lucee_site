//************************ 
//utilities ************** 
//************************ 
function capitalise(s) {
  if (typeof s !== 'string') return ''
  return s.charAt(0).toUpperCase() + s.slice(1)
}

function camelise(text) {
    return text.replace(/^([A-Z])|[\s-_]+(\w)/g, function(match, p1, p2, offset) {
        if (p2) return p2.toUpperCase();
        return p1.toLowerCase();        
    });
};

function decamelise(str, separator){
	separator = typeof separator === 'undefined' ? '_' : separator;
	return str
        .replace(/([a-z\d])([A-Z])/g, '$1' + separator + '$2')
        .replace(/([A-Z]+)([A-Z][a-z\d]+)/g, '$1' + separator + '$2')
        .toLowerCase();
};

// rename keys
renameKeys = (keysMap, obj) => Object
  .keys(obj)
  .reduce((acc, key) => ({
      ...acc,
      ...{ [(typeof keysMap[key]==="function"? keysMap[key](key): keysMap[key]) || key]: obj[key] }
  }), {});

//************************ 
//components: select ***** 
//************************ 
class Select extends hyperHTML.Component {
  constructor (init) {
    super()
    this.setState(init);
  } 
  get defaultState() { 
    return {
       label: null
      ,name: null
      ,members: []
      ,fnChange: null
    } 
  }
  setName(v) { this.setState({ name: v });}
  setMembers(v) {  this.setState({ members: v });}
  setFnChange(v) {  this.setState({ fnChange: v });}

  onchange (e) {
    if(this.state.fnChange) {
      this.state.fnChange(e,this);
    }
  }

  render() {
    return this.html`
      <label>
        <span>${this.state.label}:</span>
        <select name='${this.state.name}' onchange=${this}> 

          ${_.map(this.state.members,function(e,i,l){
            var label = [e.name];
            if(e.label) label.push(" (",e.label,")");

            return hyperHTML.wire(e)`<option value=${e.val}>${label.join("")}</option>`;
          })}
        </select> 
      </label>
    `;
  }
}

//************************ 
//components: tabline ****
//************************ 
class Tabline extends hyperHTML.Component {
  constructor(init){
    super();
    this.setState(init);
  }
  get defaultState() {
    return {
       tabs: []
      ,fnTabbed: null 
      ,tabbedIndex : null
    } 
  }
  setTabs (v,idx) { 
    var temp = [];
    for(var k in v) {
      var obj = {
        ...v[k]
        ,isTabbed: false
      }
      temp.push(obj);
    }
    idx = (idx===undefined)? 0: idx;

    this.setState({tabs: temp}); 
    this.setTabIndex(idx);
  }
  setFnClick(v) { this.setState({fnTabbed: v}); }

  setTabIndex (idx,evt) {
    idx = (idx===undefined)? 0: idx;
    var tab = null;
    _.each(this.state.tabs,function(e,i,l){
      var flag = (i==idx);
      if(flag) tab = e;
      e.isTabbed = flag;
    });
    this.setState({tabbedIndex: idx})
    if(this.state.fnTabbed) {
      this.state.fnTabbed(evt,tab,idx);
    }
  }

  onclick (evt) {
    var idx = evt.target.getAttribute("key");
    this.setTabIndex(idx,evt);
  }

  render() {
    return this.html`<div class="row tabline" onclick=${this}>
      ${ _.map(this.state.tabs,function(e,i,l){

        var className = ["col","tab"];
        if(e.isTabbed) className.push('selected');
        var label = [e.name];
        if(e.label) label.push(" (",e.label,")");

        return hyperHTML.wire(e)`<div key=${i} class="${className.join(' ')}">${label.join("")}</div>`
      })}
    </div>`;
  }
}
