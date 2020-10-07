(function () {
    let root = this;
    root.backlogIndexFunc = function () {
        window: onload = function () {
            $("#display-affiliate").click(function () {
                $("#affiliate-backlogs").show();
                $("#all-backlogs").hide();
            });
            $("#display-all").click(function () {
                $("#all-backlogs").show();
                $("#affiliate-backlogs").hide();
            });
        };
    };
    root.backlogNewFunc = function () {
        window: onload = function () {
            $("#user-add").click(function () {
                $(".tmp > .user-setting").clone(true).appendTo("#users-box")
                let userIds = JSON.parse($("#user_and_role_ids").val());
                userIds.push({ user_id: 0, role_id: 0 })
                $("#user_and_role_ids").val(JSON.stringify(userIds))
            });
            $(".user-remove").click(function () {
                const thisBox = $(this).parents('.user-setting')
                const i = thisBox.index();
                let userIds = JSON.parse($("#user_and_role_ids").val());
                userIds.splice(i, 1)
                $("#user_and_role_ids").val(JSON.stringify(userIds))
                thisBox.remove();

            });
            $("#select_role").change(function () {
                const i = $(this).parents('.user-setting').index();
                let userIds = JSON.parse($("#user_and_role_ids").val());
                userIds[i]["role_id"] = $(this).val()
                $("#user_and_role_ids").val(JSON.stringify(userIds))
            });
            $("#select_user").change(function () {
                const i = $(this).parents('.user-setting').index();
                let userIds = JSON.parse($("#user_and_role_ids").val());
                userIds[i]["user_id"] = $(this).val()
                $("#user_and_role_ids").val(JSON.stringify(userIds))
            });
            $('#submit-btn').on('click', function (e) {
                const userIds = JSON.parse($("#user_and_role_ids").val());
                var checkIds = []
                for (let i = 0; i < userIds.length; i++) {
                    if (userIds[i]["user_id"] == 0 || userIds[i]["role_id"] == 0 || checkIds.indexOf(userIds[i]["user_id"]) != -1) {
                        alert("参加ユーザー設定が正しくありません")
                        return false;
                    }
                    checkIds.push(userIds[i]["user_id"])
                }
            });
            // $(".select-user").click(function () {
            //     let i = $(this).parents('.user-setting').index();
            // });
        };
    };
}.call(this));