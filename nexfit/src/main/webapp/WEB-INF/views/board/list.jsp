<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NEXFIT : 운동이 재밌는 커뮤니티</title>

<jsp:include page="/WEB-INF/views/layout/staticHeader.jsp"/>

<style type="text/css"> 
.body-container {
	max-width: 800px;
}

.table-style {
	border: 1px solid #ddd;
    border-radius: 5px;
    padding: 16px;
    margin: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
    background-color: #fff;
}

.btn-light:hover {
	background: black; 
	color: white;
}

.image-container {
    position: relative;
    width: 1300px; 
    height: 200px; 
}


.background-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.overlay-image {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}


.overlay-image2 {
    position: absolute;
    top: 80%; 
    left: 50%;
    transform: translate(-50%, -50%);
}


.background-container {
            position: relative;

        }
        
.background-container::before {
     content: "";
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background-image: url('/nexfit/resources/images/firefire.gif');
     background-size: cover;
     background-position: center;
     background-repeat: no-repeat;
     border-radius: 10px;
     opacity: 0.2;
     z-index: -1;
}

.background-container h3 {
     font-weight: bold;
     color: tomato;
}

.toggle-buttons {
     margin-top: 10px;
}

.top-liked-posts, .top-commented-posts {
     margin-top: 20px;
}


		.modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: black;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            animation: modalopen 0.5s;
            transform: scale(1.3) scaleY(1.2);
        }
        
        
        @keyframes modalopen {
            from {
                transform: scale(0.7) scale(1);
                opacity: 0;
            }
            to {
                transform: scale(1.3) scaleY(1.2);
                opacity: 1;
            }
        }
        

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: white;
            text-decoration: none;
            cursor: pointer;
        }
        

		.text-overlay {
			cursor: pointer;
            transition: opacity 0.5s ease;
		}
		
		
		.user-text-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            font-size: 1.2em;
            font-weight: bold;
            text-align: center;
            transition: opacity 0.5s ease;
        }
		
		
		@keyframes fadeUp {
            0% { transform: translate(-50%, -50%) translateY(0) scale(1.2) scale(1.2); opacity: 1; color: white; }
            25% { transform: translate(-50%, -50%) translateY(-35px) scale(1.1); opacity: 1; color: yellow; }
            50% { transform: translate(-50%, -50%) translateY(-70px) scale(0.9); opacity: 1; color: #FFA873; } 
            100% { transform: translate(-50%, -50%) translateY(-140px) scale(0.8); opacity: 0.5; color: red; }
        }

        .fade-up {
            animation: fadeUp 3.5s forwards;
        }
        
        
        
.game-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
}

.game-container::before {
     content: "";
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background-image: url('/nexfit/resources/images/soil.PNG'); 
     background-size: cover;
     background-position: center;
     background-repeat: no-repeat;
     border-radius: 10px;
     opacity: 0.8;
     z-index: -1;
}

.score {
	color: white;
    font-size: 1.5em;
    margin-bottom: 20px;
}

.grid {
    display: grid;
    grid-template-columns: repeat(3, 60px);
    grid-gap: 10px;
    justify-content: center;
    align-content: center;
}

.hole {
    width: 40px;
    height: 40px;
    background-color: #662500;
    border-radius: 50%;
    position: relative;
    overflow: hidden;
}

.mole {
    width: 100%;
    height: 100%;
    background-image: url('/nexfit/resources/images/digda.PNG');
    background-color: orange;
    border-radius: 50%;
    position: absolute;
    top: 100%;
    transition: top 0.3s;
}

.show {
    top: 0;
}


</style>
	<script type="text/javascript">
	function filterCategory(category) {
        const urlParams = new URLSearchParams(window.location.search);
        if (category === '전체') {
            urlParams.delete('category');
        } else {
            urlParams.set('category', category);
        }
        window.location.href = window.location.pathname + '?' + urlParams.toString();
    }
	
	function searchList() {
		const f = document.searchForm;
		f.submit();
	}

	
	
	function showTopLikedPosts() {
        document.getElementById('topLikedPosts').style.display = 'block';
        document.getElementById('topCommentedPosts').style.display = 'none';
    }

    function showTopCommentedPosts() {
        document.getElementById('topLikedPosts').style.display = 'none';
        document.getElementById('topCommentedPosts').style.display = 'block';
    }
    
    
    const messages = [
        "오늘도 수고했어요! &nbsp; (클릭)",
        "초가 자신을 희생해가며 촛불을 빛내듯, &nbsp; (클릭)",
        "자신을 믿고 나아가며 빛내는 당신! &nbsp; (클릭)",
        "그 자체로 이미 충분히 아름답습니다. &nbsp; (클릭)",
        "NEXFIT 일동."
    ];
    let currentIndex = 0;

    function showNextMessage() {
        currentIndex = (currentIndex + 1) % messages.length;
        const textOverlay = document.getElementById('textOverlay');
        textOverlay.style.opacity = 0; 
        setTimeout(() => {
            textOverlay.innerHTML = messages[currentIndex];
            textOverlay.style.opacity = 1; 
        }, 500); 
    }
    
    
    function showUserText() {
        const userInput = document.getElementById('userInput').value;
        const userTextOverlay = document.getElementById('userTextOverlay');
        userTextOverlay.innerHTML = userInput;
        userTextOverlay.classList.add('fade-up');
        setTimeout(() => {
            userTextOverlay.classList.remove('fade-up');
            userTextOverlay.innerHTML = '';
        }, 2000);
    }

      
    document.addEventListener('DOMContentLoaded', function() {
	    document.getElementById('marqueeText').onclick = function() {
	        document.getElementById('myModal').style.display = "block";
	    }
	
	    document.getElementsByClassName('close')[0].onclick = function() {
	        document.getElementById('myModal').style.display = "none";
	    }
	
	    window.onclick = function(event) {
	        if (event.target == document.getElementById('myModal')) {
	            document.getElementById('myModal').style.display = "none";
	        }
	    }
	    
	    document.getElementById('textOverlay').addEventListener('click', showNextMessage);
	    window.showUserText = showUserText;
    });

    
    
    document.addEventListener('DOMContentLoaded', () => {
        const holes = document.querySelectorAll('.hole');
        const scoreBoard = document.getElementById('score');
        const startButton = document.getElementById('startButton');
        const result = document.getElementById('result');
        let score = 0;
        let lastHole;
        let timeUp = false;

        function randomTime(min, max) {
            return Math.round(Math.random() * (max - min) + min);
        }

        function randomHole(holes) {
            const idx = Math.floor(Math.random() * holes.length);
            const hole = holes[idx];
            if (hole === lastHole) {
                return randomHole(holes);
            }
            lastHole = hole;
            return hole;
        }

        function showMole() {
            const time = randomTime(100, 700);
            const hole = randomHole(holes);
            const mole = document.createElement('div');
            mole.classList.add('mole');
            hole.appendChild(mole);
            setTimeout(() => {
                mole.classList.add('show');
            }, 50);
            mole.addEventListener('click', bonk);
            setTimeout(() => {
                mole.classList.remove('show');
                setTimeout(() => {
                    hole.removeChild(mole);
                    if (!timeUp) showMole();
                }, 300);
            }, time);
        }

        function startGame() {
            scoreBoard.textContent = 0;
            score = 0;
            timeUp = false;
            result.textContent = '';
            showMole();
            setTimeout(() => {
                timeUp = true;
                result.textContent = `아쉬워요! 한 번 더 하실래요?`;
            }, 20000);
        }

        function bonk(e) {
            if (!e.isTrusted) return;
            score++;
            this.classList.remove('show');
            scoreBoard.textContent = score;
        }

        holes.forEach(hole => hole.addEventListener('click', function(e) {
            if (e.target.classList.contains('mole')) {
                bonk.call(e.target, e);
            }
        }));

        startButton.addEventListener('click', startGame);
    });
    
	</script>
 

</head>

<body>
<div class="container-fluid px-0">
	<header>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"/> 
	</header>
	<main>
		<div class="container-xxl text-center">
			<div class="row py-5 mt-5">
				<div class="col image-container">
					<img src="/nexfit/resources/images/exercisebg.PNG" class="background-image" style="width:1300px; height:200px; opacity: 0.3;">
					<img src="/nexfit/resources/images/freelounge.png" class="overlay-image" style="width:550px; height:110px;"><br>
					<img src="/nexfit/resources/images/sci.png" class="overlay-image2" style="width:330px; height:25px;">
				</div> 
				
				
			</div>
	
	<div class="row gx-2">
		<jsp:include page="/WEB-INF/views/board/list_leftbar.jsp"></jsp:include>
			
			
		
	
	
	<div class="col-sm-7">
		<main>
			<div class="container" style="font-family: 'nexon lv2 medium';">
				<div class="body-container">	
					<div class="body-title">
						<h3 style="font-family: 'nexon lv2 medium';">자유 게시판</h3>
					</div>
					
				
					
					<div class="body-main">
				        <div class="row board-list-header">
				            <div class="col-auto me-auto">${dataCount}개(${page}/${total_page} 페이지)</div>
				            
				        </div>
				        
				        <form class="row mx-auto" name="searchForm" action="${pageContext.request.contextPath}/board/list" method="post" > 
							<div class="col-auto p-1">
								<select name="schType" class="form-select">
									<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
									<option value="nickname" ${schType=="nickname"?"selected":""}>작성자</option>
									<option value="reg_date" ${schType=="reg_date"?"selected":""}>등록일</option>
									<option value="subject" ${schType=="subject"?"selected":""}>제목</option>
									<option value="content" ${schType=="content"?"selected":""}>내용</option>
								</select>
							</div>
							<div class="col-auto p-1">
								<input type="text" name="kwd" value="${kwd}" class="form-control" style="width: 450px;">
							</div>
							<div class="col-auto p-1">
								<button type="button" class="btn btn-light" onclick="searchList()" style=""> <i class="bi bi-search"></i> </button>
							</div>
						</form>
						 
						<div class="col-auto">&nbsp;<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/board/write';" style="float: right;">글쓰기</button></div>
				     	
				     	<div class="table-style">		
						<table class="table table-hover board-list">
							<thead>
								<tr>
									<th class="num">번호</th>
									<th class="categoryName">제목</th>
									<th class="name">작성자</th>
									<th class="date">작성일</th>
									<th class="hit">조회수</th>
								</tr>
							</thead>
							
							<tbody>
								<c:forEach var="dto" items="${list}" varStatus="status">
									<tr> 
										<td>${dataCount - (page-1) * size - status.index}</td>
										<td class="left">
									
											<a href="${articleUrl}&num=${dto.num}" class="text-reset">
											<span style="float: left"><span style="color: orange;">[${dto.categoryName}]&nbsp; </span><span class="text-overflow"> ${dto.subject} </span><span style="color: #23A41A; font-weight: bold;">&nbsp; 🗨 ${dto.replyCount}</span>
											<span style="color: #FF73B8; font-weight: bold;">♥ ${dto.boardLikeCount}</span> 
											</span>
											</a>
										
										</td>
										<td>${dto.nickname}</td>
										<td>${dto.reg_date}</td>
										<td>${dto.hitCount}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						</div>
						
						<div class="page-navigation">
							${dataCount == 0 ? "등록된 게시물이 없습니다." : paging}
						</div> 
						<div class="row board-list-footer">
							
						</div>
		
					</div>
				</div>
			</div>
		</main>				
		</div>
		<div class="col-sm-3 mt-5" style="font-family: 'nexon lv1 light'; font-weight: bold;"> 
			<h3 style="font-weight: bold;">CATEGORY</h3>
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio1" onclick="filterCategory('전체')" ${category == '전체' ? 'checked' : ''} checked>
				  <label class="btn btn-outline-dark" for="btnradio1">전체</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio2" onclick="filterCategory('2')" ${category == '2' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio2">잡담</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio3" onclick="filterCategory('3')" ${category == '3' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio3">건강</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio4" onclick="filterCategory('4')" ${category == '4' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio4">축구</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio5" onclick="filterCategory('5')" ${category == '5' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio5">야구</label>
				</div>
				
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio6" onclick="filterCategory('6')" ${category == '6' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio6">농구</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio7" onclick="filterCategory('7')" ${category == '7' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio7">배구</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio8" onclick="filterCategory('8')" ${category == '8' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio8">기타종목</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio9" onclick="filterCategory('9')" ${category == '9' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio9">동물</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio10" onclick="filterCategory('10')" ${category == '10' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio10">식단</label>
				</div>
				
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio11" onclick="filterCategory('11')" ${category == '11' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio11">게임</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio12" onclick="filterCategory('12')" ${category == '12' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio12">영화</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio13" onclick="filterCategory('13')" ${category == '13' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio13">문학</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio14" onclick="filterCategory('14')" ${category == '14' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio14">유머</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio15" onclick="filterCategory('15')" ${category == '15' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio15">연애</label>
				</div>
				
				<div class="btn-group" role="group" aria-label="Basic radio toggle button group">
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio16" onclick="filterCategory('16')" ${category == '16' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio16">여행</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio17" onclick="filterCategory('17')" ${category == '17' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio17">음악</label>
				
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio18" onclick="filterCategory('18')" ${category == '18' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio18">취업</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio19" onclick="filterCategory('19')" ${category == '19' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio19">재테크</label>
				  
				  <input type="radio" class="btn-check" name="btnradio" id="btnradio20" onclick="filterCategory('1')" ${category == '1' ? 'checked' : ''}>
				  <label class="btn btn-outline-dark" for="btnradio20">IT</label>
				</div>
				<br><br><hr>
				
				<div class="background-container">
					<br>
		            <h3 style="font-weight: bold; color: tomato;">🔥 H O T 🔥</h3>
		            <div class="toggle-buttons">
			            <button type="button" class="btn btn-outline-dark" onclick="showTopLikedPosts()">좋아요수</button>
			            <button type="button" class="btn btn-outline-dark" onclick="showTopCommentedPosts()">댓글수</button>
			        </div>
			        
					<div id="topLikedPosts" class="top-liked-posts">
			            <br>
		                <ul>
		                    <c:forEach var="post" items="${topLikedPosts}">
		                        <li style="text-align: left;">
		                            <a href="${pageContext.request.contextPath}/board/article?num=${post.num}">
		                                <span style="font-weight: bold;">${post.subject}</span> - <span style="color: #FF73B8; font-weight: bold;">♥ ${post.boardLikeCount}</span>
		                            </a>
		                        </li>
		                    </c:forEach>
		                </ul>
		            </div>
		            
		            <div id="topCommentedPosts" class="top-commented-posts" style="display: none;">
		            	<br>
		                <ul>
		                    <c:forEach var="post" items="${topCommentedPosts}">
		                        <li style="text-align: left;">
		                            <a href="${pageContext.request.contextPath}/board/article?num=${post.num}">
		                                <span style="font-weight: bold;">${post.subject}</span> - <span style="color: #23A41A; font-weight: bold;">🗨 ${post.replyCount}</span>
		                            </a>
		                        </li>
		                    </c:forEach>
		                </ul>
		            </div>
		            <br>
		            <marquee><span id="marqueeText" style="cursor: pointer;">잠깐! 잠시 <span style="color: #E0844F;">불멍</span>을 때리며 오늘 하루는 알찼는지 돌아볼래...?</span></marquee>
		            
		            <div id="myModal" class="modal">
				        <div class="modal-content">
				            <span class="close">&times;</span>
				            <img src="/nexfit/resources/images/firefire.gif" style="width: 100%;">
				            <div class="text-overlay" id="textOverlay" style="color: white;">오늘도 수고했어요! &nbsp; (클릭)</div>
				            <div class="user-text-overlay" id="userTextOverlay"></div>
				            <div class="input-container">
				                <input type="text" id="userInput" placeholder="원하는 텍스트를 띄워보세요!" style="width: 250px; background: black; color: white; border: 2px solid white;">
				                <button class="btn btn-outline-danger" onclick="showUserText()" style=" transform: scale(0.8) scaleY(0.8);">띄우기</button>
				            </div>
				        </div>
				    </div>
	            </div>
	            <hr>
	            
	            <div class="game-container">
			        <div id="scoreBoard" style="color: white;">디그다 좀 잡고 가실래요?</div>
			        <div class="score">Score: <span id="score">0</span></div>
			        <div class="grid">
			            <div class="hole" id="hole1"></div> 
			            <div class="hole" id="hole2"></div>
			            <div class="hole" id="hole3"></div>
			            <div class="hole" id="hole4"></div>
			            <div class="hole" id="hole5"></div>
			            <div class="hole" id="hole6"></div>
			            <div class="hole" id="hole7"></div>
			            <div class="hole" id="hole8"></div>
			            <div class="hole" id="hole9"></div>
			        </div>
			        <br>
			        <div id="result" class="result" style="color: white;"></div>
			        <button class="btn btn-secondary" id="startButton">Start!</button>
			        <div id="result" class="result"></div>
    			</div>
				
		</div>
		</div>
			
			
		</div>
			
			</div>
		
	
	
	<div class="row py-5">
										
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
	</footer>
</body>

<jsp:include page="/WEB-INF/views/layout/staticFooter.jsp"/>
</body>
</html>