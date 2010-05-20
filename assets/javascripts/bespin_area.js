/* 
  A SproutCore object designed to bridge text areas and bespin editors.
  
  On creation it requires the ID of a text area which will be hidden, replaced
  with a bespin area of approximately the same size and the value will be kept in sync as 
  the contents of the editor changes
*/

BespinArea = SC.Object.extend({
  textAreaInput: null, // The DOM object of the text area input
  bespinOptions: null, // The options passed to the bespin editor
  bespinEditor: null, // The Bespin object tied to the text editor
  // A delegate that Bespin calls internally when the text changes.  We use it to make sure the value of the
  // text area is always in sync
  textStorageEdited: function(sender, oldRange, newRange) {
    this.textAreaInput.value = sender.value();
  },
  init: function() {
    this.sc_super();
    var editingDiv = document.getElementById(this.textAreaInputId + "_editor");
    var inputArea = document.getElementById(this.textAreaInputId);
                    	
  	var width = inputArea.style.width;
  	var height = inputArea.style.height;
  	
  	if (tiki.require("bespin:util/util").isString(width) === false || width == "") {
  	  width = (inputArea.cols * 8.14) + "px"; //Approximately the col width in pixels under testing w/ Firefox
  	}
  	
  	if (tiki.require("bespin:util/util").isString(height) === false || height == "") {
  	  height = (inputArea.rows * 17.5) + "px"; //Approximately the row height in pixels under testing w/ Firefox
  	}
  	
  	//editingDiv.innerHTML = inputArea.value;
  	editingDiv.style.visibility="visible";
  	editingDiv.style.height = height;
  	editingDiv.style.width = width;
  	
  	inputArea.style.display="none";
  	window.editingDiv = editingDiv;
  	
  	var bespinEditor = tiki.require("embedded").useBespin(editingDiv, this.bespinOptions);
  	bespinEditor.setValue(this.initialContent);
  	
  	// The key part, the text storage engine calls textStorageEdited when the contents change.
  	// It'd be nice if we could use text areas directly but that's not working w/ this version of Bespin
    //bespinEditor.addEventListener('textChange', function(){this.textAreaInput.value = this.bespinEditor.getValue();});
    bespinEditor.getPath("_editorView.layoutManager.textStorage").addDelegate(this);
    this.set('bespinEditor', bespinEditor);
    this.set('textAreaInput', inputArea);
  }
});