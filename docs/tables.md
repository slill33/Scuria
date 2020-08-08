# 必要テーブル

* Companies

* Admins
    * devise
    * User情報の編集はdevise使用しない
* Users 
    * devise
    * Companyに所属

* UserAuthorities(権限管理)
    * 後から実装
    * 最初はPO SMのみできる操作をメンバーでもできるように変更するかも

* ProductBacklogs
    * Companyに関連
    * 親、もしくは子にProductBacklogsを持つことがある
    * 子にSprintBacklogsを持つことがある

* ProductBacklogColumns

* SprintBacklogColumns
    * ProductBacklogColumnsと関連付け(Doing->Doing レビュー待ち->Doing awaiting_release ->レビュー待ち)

* SprintBacklogs
    * 親にProductBacklogsを持つ

* Backlog to Users
    * BacklogとUserを繋ぐ中間テーブル

* Items

* Item to Users
    * ItemとUserを繋ぐ中間テーブル
* Item to Tags 
    * ItemとTagを繋ぐ中間テーブル

* Tags


* Notifications
    * 通知設定
    * 終了したら通知する先を設定する
    * ポリモーフィック
        * Slack

* Notification_Servicies

* Notification_Slack