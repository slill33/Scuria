(function () {
    let root = this;
    root.backlogIndexFunc = function () {
        window: onload = function () {
            $('#display-affiliate').click(function () {
                $('#affiliate-backlogs').show();
                $('#all-backlogs').hide();
            });
            $('#display-all').click(function () {
                $('#all-backlogs').show();
                $('#affiliate-backlogs').hide();
            });
        };
    };
    root.backlogFormFunc = function () {
        window: onload = function () {
            $('#user-add').click(function () {
                $('.tmp > .user-setting').clone(true).appendTo('#users-box')
                let userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                userAndRoleIds.push({ user_id: 0, role_id: 0 })
                $('#user_and_role_ids').val(JSON.stringify(userAndRoleIds))
            });
            $('.user-remove').click(function () {
                const thisBox = $(this).parents('.user-setting')
                const i = thisBox.index();
                let userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                userAndRoleIds.splice(i, 1)
                $('#user_and_role_ids').val(JSON.stringify(userAndRoleIds))
                thisBox.remove();

            });
            $('#select_role').change(function () {
                const i = $(this).parents('.user-setting').index();
                let userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                userAndRoleIds[i]['role_id'] = $(this).val()
                $('#user_and_role_ids').val(JSON.stringify(userAndRoleIds))
            });
            $('#select_user').change(function () {
                const i = $(this).parents('.user-setting').index();
                let userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                userAndRoleIds[i]['user_id'] = $(this).val()
                $('#user_and_role_ids').val(JSON.stringify(userAndRoleIds))
            });
            $('#submit-btn').on('click', function (e) {
                const userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                var checkIds = []
                for (let i = 0; i < userAndRoleIds.length; i++) {
                    if (userAndRoleIds[i]['user_id'] == 0 || userAndRoleIds[i]['role_id'] == 0 || checkIds.indexOf(userAndRoleIds[i]['user_id']) != -1) {
                        alert('参加ユーザー設定が正しくありません')
                        return false;
                    }
                    checkIds.push(userAndRoleIds[i]['user_id'])
                }
            });
            restore_user_and_role_ids()
            function restore_user_and_role_ids() {
                const userAndRoleIds = JSON.parse($('#user_and_role_ids').val());
                for (let i = 0; i < userAndRoleIds.length; i++) {
                    thisBox = $('.tmp > .user-setting').clone(true).appendTo('#users-box')
                    console.log(userAndRoleIds[i]['user_id'])
                    $(thisBox).find('#select_user').val(userAndRoleIds[i]['user_id'])
                    $(thisBox).find('#select_role').val(userAndRoleIds[i]['role_id'])
                }
            }
        };
    };
}.call(this));