<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
 <meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta content="utf-8" http-equiv="encoding">
 
<%@ include file="/common/taglibs.jsp"%>
<style>


</style>


<!-- <button id="Bindeds">Show Color Picker</button><br>
 <input id="Binded" type="text" value="e2ddcf" /> -->
<!-- <div id="target" style="min-height: 617px;" >
<p><input type="text" maxlength="6" size="6" id="colorpickerField1" value="00ff00" /></p>


<blockquote style="margin: 0 0 0 40px; padding: 0px;">

  Rotate me!
  
  </blockquote>
</div> -->




<table>

<tr>
<td>
<div id="target" style="width: 250px;  padding: 155px 40px 155px 354px; ">
<textarea  id="tt" value="" type="text"></textarea>  
</div>

<tr>

<input id ="bold" class='selector' type="checkbox" value="bold"/>&nbsp;<label for="bold">Bold</label><br/>
<input id="italic" class='selector' type="checkbox" value="italic"/>&nbsp;<label for="italic">Italic</label><br/>
<input id="underline" class='selector' type="checkbox" value="underline"/>&nbsp;<label for="underline">Underline</label><br/>
<br>
<!-- <input id="box" type="text" value=""> -->
<br>
<div id="bt" class="fontSelect">					
<div class="arrow-down"></div>
		</div>
	</tr>
</td>


</tr>
</table>
<!--dialog  -->

<div id="dd" class="easyui-dialog" style="padding:5px;width:400px;height:200px; "
        title="My Dialog" iconCls="icon-ok"
        toolbar="#dlg-toolbar" buttons="#dlg-buttons">
    Dialog Content.
</div>

<div id="dlg-toolbar">
   <!--  <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="javascript:alert('Add')">Add</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="javascript:alert('Save')">Save</a>
     -->
   <textarea rows="5" cols="45" name="remark" style="margin-top: 5px; margin-bottom: 5px; width: 80%;" id="remark"></textarea>
</div>
<div id="dlg-buttons">
    <a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="javascript:addT().diaog('#dd')">Ok</a>
    <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dd').dialog('close')">Cancel</a>
</div>


<script>
parent.$.messager.progress('close');

/* 
 * 
 
$('#Bindeds').colpick({
		layout:'hex',
		submit:0,
		colorScheme:'dark',
		onChange:function(hsb,hex,rgb,el,bySetColor) {
			$(el).css('border-color','#'+hex);
			// Fill the text box just if the color was set using the picker, and not the colpickSetColor function.
			if(!bySetColor) $(el).val(hex);
		}
	}).keyup(function(){
		$(this).colpickSetColor(this.value);
	});
		 

//$('#Binded').jPicker({});
//$('#Binded').jPicker({window:{title:'Binded Example'},color:{active:new $.jPicker.Color({ahex:'993300ff'})}});
/* 
 

$( "#colorpickerField1" ).bind({
	  click: function() {
$('#colorpickerField1').ColorPicker({
	onSubmit: function(hsb, hex, rgb, el) {
		$(el).val(hex);
		$(el).ColorPickerHide();
		alert("jj");
	},
	onBeforeShow: function () {
		$(this).ColorPickerSetColor(this.value);
	}
});
	 

	  }  });
	  
	  
$('#colorpickerField1').ColorPicker({
	onSubmit: function(hsb, hex, rgb, el) {
		$(el).val(hex);
		$(el).ColorPickerHide();
		alert("jj");
	},
	onBeforeShow: function () {
		$(this).ColorPickerSetColor(this.value);
	}
});
 */
/* 
$( "#target" ).bind({
	  click: function() {
	    // Do something on click
		//alert("dfdf");
		$('#target').transition({ skewY: '30deg' });
	  },
	  mouseenter: function() {
	    // Do something on mouseenter
		$('#target').transition({
	  rotate: '+=30deg',
	  x: '+=10'
	});
	  }
	});
$('#target').draggable(); */



var section ;
var factor = 0.8;

function getFontSize(el)
{
    var fs = $(el).css('font-size');    
    if(!el.originalFontSize)el.originalFontSize =fs; //set dynamic property for later reset  
    return  parseFloat(fs);  
}

function setFontSize(fact){
    if(section==null)
       section = $('#target').find('*')       
       .filter(
         function(){return  $(this).clone()
            .children()
            .remove()
            .end()
            .text().trim().length > 0;
            }); //filter -> exclude all elements without text
            
      
    section.each(function(){  
      var newsize = fact ? getFontSize(this) * fact : this.originalFontSize;
      if(newsize) $(this).css('font-size', newsize );      
    }); 
}

function resetFont(){
    setFontSize();
}
function increaseFont() {
    setFontSize(1 / factor);
}
function decreaseFont(){
    setFontSize(factor);
}

//color 
function colorpicker(){
	


}

//add

$('#bt').fontSelector({
			
			'hide_fallbacks' : true,
			'initial' : 'Courier New,Courier New,Courier,monospace',
			'selected' : function(style) { /* alert("S1: " + style); */
			$("#tt").css("font-family",""+style+"");
			
			},
			'fonts' : [
				'Arial,Arial,Helvetica,sans-serif',
				'Arial Black,Arial Black,Gadget,sans-serif',
				'Comic Sans MS,Comic Sans MS,cursive',
				'Courier New,Courier New,Courier,monospace',
				'Georgia,Georgia,serif',
				'Impact,Charcoal,sans-serif',
				'Lucida Console,Monaco,monospace',
				'Lucida Sans Unicode,Lucida Grande,sans-serif',
				'Palatino Linotype,Book Antiqua,Palatino,serif',
				'Tahoma,Geneva,sans-serif',
				'Times New Roman,Times,serif',
				'Trebuchet MS,Helvetica,sans-serif',
				'Verdana,Geneva,sans-serif',
				'Gill Sans,Geneva,sans-serif'
				]
		});
		
		
$('.selector').click(function() {
    var checked = $(this).is(':checked');
    var value = $(this).attr('value');
    if (checked) {
        $('#tt').addClass(value);
    } else {
        $('#tt').removeClass(value);
    }

});
//color



 
 
 
 $('#coloidval').spectrum({
	 flat: false,
	 showInput: true,
	    cancelText: "",
	    showInitial: true,
	    showPalette: true,
	    showSelectionPalette: true,
	    color: "#f00",
	    change: function(color) {
	    	var stylesToAdd = { color:color.toHexString() };
	    		    $('#remark').css(stylesToAdd);
	    	
	    },
	    
	    palette: [
	        ["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
	        "rgb(204, 204, 204)", "rgb(217, 217, 217)","rgb(255, 255, 255)"],
	        ["rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
	        "rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)"], 
	        ["rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)", 
	        "rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)", 
	        "rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)", 
	        "rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)", 
	        "rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)", 
	        "rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
	        "rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
	        "rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
	        "rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)", 
	        "rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"]
	    ]
 });



</script>


