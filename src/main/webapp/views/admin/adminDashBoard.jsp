<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>관리자 페이지 - 대시보드</title>

<!-- Font Awesome CDN -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<!-- Google Fonts (Nunito) -->
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,300,400,600,700,800,900"
	rel="stylesheet">
<!-- Bootstrap CSS CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<!-- 사용자 정의 CSS -->
<link href="/assets/css/adminDashBoard.css" rel="stylesheet">
<!-- 폰트추가 위한 구글 폰트 -->
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">


</head>
<body>
	<!-- 	<script>
		$(function() {
			$.ajax({
				url : "/dashboard.admin"
			}).done(function(resp) {
				resp = Json.parse(resp);
				resp
			})
		}) 
	</script> -->
	<div class="container-fluid p-0">
		<div class="row g-0" style="width: 100%;">
			<!-- 사이드바 영역 -->
			<div class="col-md-3 col-lg-2 p-0">
				<div class="sidebar" id="sidebar">
					<div class="logo">
						<a href="/index.jsp"> <img src="/assets/img/logoW.png"
							alt="Logo">
						</a>
					</div>
					<ul class="sidebar-menu nav flex-column">
						<li class="nav-item"><a class="nav-link active"
							href="/dashboard.admin"> <i class="fa-solid fa-toolbox"></i>
								<span class="ms-2">관리자 페이지</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/customerlist.admin"> <i class="fa-solid fa-users"></i>
								<span class="ms-2">회원 리스트</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/boardlist.admin"> <i class="fa-solid fa-file-lines"></i>
								<span class="ms-2">게시글 리스트</span>
						</a></li>
					</ul>
				</div>
			</div>
			<!-- 메인 콘텐츠 영역 -->
			<div class="col-md-9 col-lg-10">
				<div class="main-content" id="main-content">
					<!-- 상단바 -->
					<div
						class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
						<h1 class="h2">관리자 페이지</h1>
						<div>
							<span class="text-muted">관리자 계정</span>
						</div>
					</div>
					<!-- 통계 카드 영역 -->
					<div class="row mb-4">
						<!-- 카드 1: 금일 접속 유저 -->
						<div class="col-xl-3 col-md-6">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">
												방문 횟수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${todayVisit }</div>
										</div>
										<div class="col-auto">
											<i class="fa-solid fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 카드 2: 접속중인 유저 -->
						<div class="col-xl-3 col-md-6">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">
												온라인 유저수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${onlineUser }</div>
										</div>
										<div class="col-auto">
											<i class="fa-solid fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 카드 3: 신규 게시글 -->
						<div class="col-xl-3 col-md-6">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">
												신규 게시글수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${todayPost }</div>
										</div>
										<div class="col-auto">
											<i class="fa-solid fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 카드 4: 금일 경고 유저 -->
						<div class="col-xl-3 col-md-6">
							<div class="card border-left-primary shadow h-100 py-2">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1">
												플레이 횟수</div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">${todayPlayGame }</div>
										</div>
										<div class="col-auto">
											<i class="fa-solid fa-calendar fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 차트 섹션 -->
					<div class="row">
						<!-- 신규 회원 현황 차트 -->
						<div class="col-lg-8">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">신규 회원 현황</h6>
								</div>
								<div class="card-body">
									<canvas id="myLineChart"></canvas>
								</div>
							</div>
						</div>
						<!-- 연령별 회원 차트 -->
						<div class="col-lg-4">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">연령별 회원</h6>
								</div>
								<div class="card-body">
									<canvas id="myDoughnutChart"></canvas>
								</div>
							</div>
						</div>
					</div>
					<!-- 게임별 플레이 현황 차트 -->
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 class="m-0 font-weight-bold text-primary">게임별 플레이 현황</h6>
								</div>
								<div class="card-body">
									<canvas id="myBarChart"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- .main-content -->
			</div>
			<!-- .col-md-9 col-lg-10 -->
		</div>
		<!-- .row -->
	</div>
	<!-- .container-fluid -->

	<!-- 푸터 -->
	<footer class="sticky-footer">
		<div class="container">
			<div class="text-center">
				<span>© 2025 TechX. All rights reserved.</span>
			</div>
		</div>
	</footer>

	<!-- 스크립트 -->
	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>

	<!-- Chart.js CDN -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<!-- 사용자 정의 차트 모듈 -->
	<script type="module">
    import ChartManager from '${pageContext.request.contextPath}/assets/js/lineChart.js';
    import DoughnutChartManager from '${pageContext.request.contextPath}/assets/js/doughnutChart.js';
    import BarChartManager from '${pageContext.request.contextPath}/assets/js/barChart.js';

    async function loadCharts() {
        const lineChartManager = new ChartManager('myLineChart', 'line');
        const doughnutChartManager = new DoughnutChartManager('myDoughnutChart', 'doughnut');
        const barChartManager = new BarChartManager('myBarChart', 'bar');

        try {
            await Promise.all([
                lineChartManager.createChart(),
                doughnutChartManager.createChart(),
                barChartManager.createChart()
            ]);
            console.log("차트 로드 완료");
        } catch (error) {
            console.error("차트 로드 실패", error);
        }
    }

  loadCharts();
// function autoUpdate(){
// loadCharts();
//	setInterval(loadCharts,10000);
//	}
// autoUpdate();

</script>
</body>
</html>
