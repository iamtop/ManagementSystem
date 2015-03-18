
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<%-- <%@ include file="/common/easyui_inc.jsp"%> --%>

<html>


<meta charset="UTF-8">
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">


<blockquote style="margin: 0 0 0 40px; padding: 0px;">
<div id="3d" style="width: 300px; height: 200px;   float: left;  font-size: 10"></div>
</blockquote>
<div id="mydialog" style="display:none;padding:5px;width:400px;height:200px;" title="EnterTheText"> 
<textarea rows="5" cols="45" name="remark"
		style="margin-top: 5px; margin-bottom: 5px; width: 80%;" id="remark"></textarea>
</div> 
<style type="text/css" media="screen"> 
@font-face { 
font-family:'GoodTimes'; 
src:url("${ctx }/static/js/fontchina/FZSTK.TTF") format('truetype') ;

} 
/* html body .newfont {font-family:'Good Times';} */ 
</style>
<script type="text/javascript" charset="utf-8" >
	parent.$.messager.progress('close');

	
	function decode_utf8(s) { 

		  return decodeURIComponent(escape(s)); 

		}


	var container, stats ,inputtx;
	var camera, scene, renderer;
	var group, text;
	var targetRotation = 0;
	var targetRotationOnMouseDown = 0;
	var mouseX = 0;
	var mouseXOnMouseDown = 0;
	var windowHalfX = window.innerWidth / 2;
	var windowHalfY = window.innerHeight / 2;
	 var weight="normal";
	 var colorchanges='rgb(204, 65, 37)';
	 var fontfamily="GoodTimes";//"fzxiaozhuanti-s13t";
	function init(name,weight,colorchanges,fontfamily) {
		container = document.getElementById("3d");
		var hh = window.innerWidth / window.innerHeight;

		camera = new THREE.PerspectiveCamera(50, window.innerWidth
				/ window.innerHeight, 1, 1000);
		camera.position.set(0, 150, 500);

		scene = new THREE.Scene();

		// Get text from hash

		var theText = name;//= "infotop";
		var hash = document.location.hash.substr(1);

		if (hash.length !== 0) {

			theText = hash;

		}
//alert(theText);
		var text3d = new THREE.TextGeometry(theText, {

		  		size : 80,
				height : 20,
				curveSegments : 3, 
		 		font :"optimer" ,
				weight:weight,
		 		bevelEnabled: true,
		 	    bevelThickness: 3,
		 	    bevelSize: 3,

		});

		text3d.computeBoundingBox();
		/* var colorsval =new THREE.Color( colorchanges);
		alert(colorsval.getHexString()+"L::"+colorchanges); */
		var centerOffset = -0.5
				* (text3d.boundingBox.max.x - text3d.boundingBox.min.x);
		var textMaterial = new THREE.MeshBasicMaterial({
			//color:colorsval,
			overdraw: 0.5
			//shading: THREE.FlatShading, overdraw : true
		});
		textMaterial.color.setStyle(colorchanges );
		text = new THREE.Mesh(text3d, textMaterial);

		text.position.x = centerOffset;
		text.position.y = 100;
		text.position.z = 10;

		text.rotation.x = 0;
		text.rotation.y = Math.PI * 2;
		
		//text.textMaterial.color.setHex( colorchanges );

		group = new THREE.Group();
		group.add(text);
		scene.add(group);

		renderer = new THREE.CanvasRenderer();
		renderer.setClearColor(0xf0f0f0);
		renderer.setPixelRatio(window.devicePixelRatio);
		renderer.setSize(window.innerWidth - 300, window.innerHeight - 150);
		container.appendChild(renderer.domElement);

		/* /* stats = new Stats();
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.width = '5px';
		stats.domElement.style.top = '0px';
		container.appendChild( stats.domElement ); */

		document.addEventListener('mousedown', onDocumentMouseDown, false);
		document.addEventListener('touchstart', onDocumentTouchStart, false);
		document.addEventListener('touchmove', onDocumentTouchMove, false);

		//

		window.addEventListener('resize', onWindowResize, false);

	}

 	function onWindowResize() {

		//windowHalfX = 350 / 2;
		//windowHalfY = 400 / 2;

		windowHalfX = window.innerWidth / 2;
		windowHalfY = window.innerHeight / 2;

		//camera.aspect = 800 / 400;

		/* camera.aspect = window.innerWidth / window.innerHeight;
		camera.updateProjectionMatrix(); */

		/* renderer.setSize(window.innerWidth, window.innerHeight); */

	} 

	//

	function onDocumentMouseDown(event) {

		event.preventDefault();

		document.addEventListener('mousemove', onDocumentMouseMove, false);
		document.addEventListener('mouseup', onDocumentMouseUp, false);
		document.addEventListener('mouseout', onDocumentMouseOut, false);

		mouseXOnMouseDown = event.clientX - windowHalfX;
		targetRotationOnMouseDown = targetRotation;

	}

	function onDocumentMouseMove(event) {

		mouseX = event.clientX - windowHalfX;

		targetRotation = targetRotationOnMouseDown
				+ (mouseX - mouseXOnMouseDown) * 0.02;

	}

	function onDocumentMouseUp(event) {

		document.removeEventListener('mousemove', onDocumentMouseMove, false);
		document.removeEventListener('mouseup', onDocumentMouseUp, false);
		document.removeEventListener('mouseout', onDocumentMouseOut, false);

	}

	function onDocumentMouseOut(event) {

		document.removeEventListener('mousemove', onDocumentMouseMove, false);
		document.removeEventListener('mouseup', onDocumentMouseUp, false);
		document.removeEventListener('mouseout', onDocumentMouseOut, false);

	}

	function onDocumentTouchStart(event) {

		if (event.touches.length == 1) {

			event.preventDefault();

			mouseXOnMouseDown = event.touches[0].pageX - windowHalfX;
			targetRotationOnMouseDown = targetRotation;

		}

	}

	function onDocumentTouchMove(event) {

		if (event.touches.length == 1) {

			event.preventDefault();

			mouseX = event.touches[0].pageX - windowHalfX;
			targetRotation = targetRotationOnMouseDown
					+ (mouseX - mouseXOnMouseDown) * 0.05;

		}

	}

	//

 	function animate() {

		requestAnimationFrame(animate);

		render();
		//stats.update();

	} 

	function render() {

		group.rotation.y += (targetRotation - group.rotation.y) * 0.05;
		renderer.render(scene, camera);

	}

	function opendailogbox() {
		
		Open_Dialog();
		
	 }
function boldFont() {
		
		
	 $( "#3d" ).empty();
		
	    weight="bold";
		init(inputtx,weight,colorchanges,fontfamily);
		animate();
	 }
	
	function Open_Dialog() { 
		
		$('#mydialog').show(); 
		$('#mydialog').dialog({ 
		collapsible: true, 
		minimizable: true, 
		maximizable: true, 
		
		buttons: [{ 
		text: '3D Maker', 
		iconCls: 'icon-ok', 
		handler: function() {
		$( "#3d" ).empty();	
		$('#tt').click(); 
		inputtx= $('#remark').val();
		init(inputtx,weight,colorchanges,fontfamily);
		animate();
		
		$('#mydialog').dialog('close'); 
		} 
		}, { 
		text: 'cancel', 
		handler: function() { 
		$('#mydialog').dialog('close'); 
		} 
		}] 
		});
		var test=document.getElementById("remark");
		test.focus();
		} 
	
	function  selectFunction(familname)
	{
		$( "#3d" ).empty();
		fontfamily=familname;
		init(inputtx,weight,colorchanges,fontfamily);
		animate();
		
	}
	  
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
	       section = $('#3d').find('*')       
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
		alert("");
	    setFontSize(1 / factor);
	}
	function decreaseFont(){
	    setFontSize(factor);
	}

	
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
		    		    //colorchanges='0x'+colors.replace(/[^a-zA-Z 0-9]+/g,'');
		    		   colorchanges= color;
		    		    $( "#3d" ).empty();
		    		    init(inputtx,weight,colorchanges,fontfamily);
		    			animate();
		    	
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
