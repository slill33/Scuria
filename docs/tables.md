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

* Backlogs
    * Companyに関連
    * 親、もしくは子にBacklogsを持つことがある
* BacklogMembers

* BacklogMembers To Users
    * Member to Users


* Backlog to Users
    * BacklogとUserを繋ぐ中間テーブル

* BacklogColumns
    * BacklogColumnsと関連付け(Doing->Doing レビュー待ち->Doing awaiting_release ->Doing)


* BacklogItems
    * BacklogItemsのアイテムと関連付けがあるかも
* BacklogItem to Users
    * ItemとUserを繋ぐ中間テーブル
* BacklogItem to BacklogTags 
    * ItemとTagを繋ぐ中間テーブル

* BacklogItem to BacklogTags 
    * ItemとTagを繋ぐ中間テーブル

* BacklogTags


* Notifications
    * 通知設定
    * 終了したら通知する先を設定する
    * ポリモーフィック
        * Slack

* Notification_Servicies

* Notification_Slack