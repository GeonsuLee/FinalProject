function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			document.getElementById('signup-post').value = data.zonecode;
			document.getElementById('signup-address').value = data.address;
		}
	}).open();
}

function checks() {
	if ($.trim($("#signin-email").val()) == "") {
		alert("아이디를 입력해주세요.");
		$("#signin-email").val("").focus();
		return false;
	}
	if ($.trim($("#signin-password").val()) == "") {
		alert("비밀번호를 입력해주세요.");
		$("#signin-password").val("").focus();
		return false;
	}
}

function pwFind() {
	window.open("pwFind", "비밀번호 찾기", "width=450, height=500");
}

$(function() {
	$("#mailtoken").hide();
});

function pwFindCheck() {
	if ($.trim($("#pwfind-id").val()) == "") {
		alert("아이디를 입력해주세요.");
		$("#pwfind-id").val("").focus();
		return false;
	}
	if ($.trim($("#pwfind-name").val()) == "") {
		alert("이름을 입력해주세요.");
		$("#pwfind-name").val("").focus();
		return false;
	}
}

var result;
function send() {
	$("#mailtoken").show();

	var email = $("#signup-email").val();
	var pattern = new RegExp(
			/^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/);

	if (email == '') {
		alert("이메일 주소를 입력해주세요.");
		$("#signup-email").val("").focus();
		return false;
	}

	if (email.match(pattern) == null) {
		alert("이메일 주소 형식이 맞지 않습니다.");
		$("#signup-email").val("").focus();
		return false;
	}

	$.post("sendmail", {
		"mail" : email
	}, function(data) {
		alert("인증번호가 발송되었습니다. 메일함을 확인해주세요.");
		result = data;
	});
}

function mailcheck() {
	var emailtoken = $("#signup-emailtoken").val();

	if (result == emailtoken) {
		alert("인증 성공");
		$("#mailtoken").hide();
		$("#signup-tel").focus();

		return false;
	} else {
		alert("인증 실패");
		$("#signup-emailtoken").val("").focus();

		return false;
	}
}

var idchecks = false;

function check() {
	if ($.trim($("#signup-id").val()) == "") {
		alert("아이디를 입력해주세요.");
		$("#signup-id").val("").focus();
		return false;
	}
	if ($.trim($("#signup-password").val()) == "") {
		alert("비밀번호를 입력해주세요.");
		$("#signup-password").val("").focus();
		return false;
	}
	if ($.trim($("#signup-password-confirm").val()) == "") {
		alert("비밀번호 확인을 입력해주세요.");
		$("#signup-password-confirm").val("").focus();
		return false;
	}
	if ($.trim($("#signup-password").val()) != $.trim($(
			"#signup-password-confirm").val())) {
		alert("비밀번호가 일치하지 않습니다.");
		$("#signup-password").val("");
		$("#signup-password-confirm").val("");
		$("#signup-password").focus();
		return false;
	}
	if ($.trim($("#signup-name").val()) == "") {
		alert("이름을 입력해주세요.");
		$("#signup-name").val("").focus();
		return false;
	}
	if ($.trim($("#signup-email").val()) == "") {
		alert("이메일을 입력해주세요.");
		$("#signup-email").val("").focus();
		return false;
	}
	if ($.trim($("#signup-emailtoken").val()) == "") {
		alert("인증번호를 입력해주세요.");
		$("#signup-emailtoken").val("").focus();
		return false;
	}
	if ($.trim($("#signup-tel").val()) == "") {
		alert("연락처를 입력해주세요.");
		$("#signup-tel").val("").focus();
		return false;
	}
	if ($.trim($("#signup-post").val()) == "") {
		alert("우편번호를 입력해주세요.");
		$("#signup-post").val("").focus();
		return false;
	}
	if ($.trim($("#signup-address").val()) == "") {
		alert("주소를 입력해주세요.");
		$("#signup-address").val("").focus();
		return false;
	}
	if ($.trim($("#signup-address-detail").val()) == "") {
		alert("상세주소를 입력해주세요.");
		$("#signup-address-detail").val("").focus();
		return false;
	}
	if (!idchecks) {
		alert("ID중복 버튼을 클릭해주세요.");
		$("#signup-id").focus();
		idchecks = false;
		return false;
	}
}

function postSearch() {
	alert("우편번호 검색 버튼을 클릭해주세요.");
}

function postcheck() {
	window.open("postFind", "우편번호 검색",
			"width=420,height=200,scrollbars=yes");
}

//아이디 중복 체크
function idcheck() {
	$("#idcheck").hide();
	var memid = $("#signup-id").val();

	if ($.trim($("#signup-id").val()).length < 4) {
		var newtext = '<font color="red">아이디는 4자 이상이어야 합니다.</font>';
		$("#idcheck").text('');
		$("#idcheck").show();
		$("#idcheck").append(newtext);
		$("#signup-id").val("").focus();
		return false;
	};
	
	if ($.trim($("#signup-id").val()).length > 12) {
		var newtext = '<font color="red">아이디는 12자 이하이어야 합니다.</font>';
		$("#idcheck").text('');
		$("#idcheck").show();
		$("#idcheck").append(newtext);
		$("#signup-id").val("").focus();
		return false;
	};
	
	// 입력 아이디 유효성 검사
	if (!(validateUserid(memid))) {
		var newtext = '<font color="red">아이디는 영문 소문자, 숫자만 가능합니다.</font>';
		$("#idcheck").text('');
		$("#idcheck").show();
		$("#idcheck").append(newtext);
		$("#signup-id").val("").focus();
		return false;
	};

	// 아이디 중복확인
	$.ajax({
		type : "POST",
		url : "idcheck",
		data : {
			"memid" : memid
		},
		success : function(data) {
			if (data == 1) {
				var newtext = '<font color="red">중복 아이디입니다.</font>';
				$("#idcheck").text('');
				$("#idcheck").show();
				$("#idcheck").append(newtext);
				$("#signup-id").val('').focus();

				return false;
			} else {
				var newtext = '<font color="blue">사용 가능한 아이디입니다.</font>';
				$("#idcheck").text('');
				$("#idcheck").show();
				$("#idcheck").append(newtext);
				$("#signup-password").focus();
				idchecks = true;
			}
		},
		error : function(e) {
			alert("data error" + e);
		}
	});
};

function validateUserid(memid) {
	var pattern = new RegExp(/^[a-z0-9_]+$/);

	return pattern.test(memid);
};