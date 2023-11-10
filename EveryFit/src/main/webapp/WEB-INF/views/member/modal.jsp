<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/sandstone/bootstrap.min.css" rel="stylesheet">
    <!-- <link href="test.css" rel="stylesheet"> -->
</head>

<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-10 offset-md-1">

                

                <!-- 내용(배너, 컨텐츠 등)을 배치할 때는 margin top을 줘서 메뉴가 표시될 자리만큼 띄워야 한다 -->
                <div class="row mt-5 pt-5" style="min-height: 400px;">
                    <div class="col">
                        <h1>모달 샘플</h1>

                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                            Launch demo modal
                        </button>

                        <!-- 커스텀 버튼 -->
                        <button type="button" class="open-modal-btn">모달 열기</button>

                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                            aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        ...
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                

            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jquery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        //목표 : .open-modal-btn을 누르면 수동으로 모달을 표시
        $(function(){
            $(".open-modal-btn").click(function(){
                //$("#exampleModal").modal("show");//표시
                //$("#exampleModal").modal("hide");//숨김

                var modal = new bootstrap.Modal(document.querySelector("#exampleModal"));
                modal.show();
            });
        });
    </script>
</body>