# Tarosky Coding Standards

Tarosky coding standards

## インストール

Composer でインストールします。

```
composer require --dev tarosky/coding-standards
```

最後に下記のような確認メッセージが表示される場合は、 `y` を入力してください。

> dealerdirect/phpcodesniffer-composer-installer contains a Composer plugin which is currently not in your allow-plugins config. See https://getcomposer.org/allow-plugins
> Do you trust "dealerdirect/phpcodesniffer-composer-installer" to execute code and wish to enable it now? (writes "allow-plugins" to composer.json) [y,n,d,?]

インストールが完了した `composer.json` には下記のようになっているはずです。

```json
{
	"require-dev": {
		// ... 他のパッケージ
		"tarosky/coding-standards": "^1.0"
	},
	"config": {
		"allow-plugins": {
			"dealerdirect/phpcodesniffer-composer-installer": true
		}
	}
}
```

## 使い方

コマンドで実行する場合は、以下のようにします。

```
./vendor/bin/phpcs --standard=Tarosky .
```

`composer.json` にスクリプトを設定しておくことで、より簡単なコマンドで実行ができます。
下記の例では `composer lint` で phpcs を使ったコードチェックを、 `composer fix` で phpcbf を使った自動修正を実行できます。

```json
"scripts": {
	"lint": "phpcs --standard=Tarosky .",
	"fix": "phpcbf --standard=Tarosky ."
},
```

さらに、`composer lint` は GitHub Actions 等のCIツールを利用して、コミット時やプルリクエスト時に必ず実行されるようにしておくと、開発チーム全体でコードチェック漏れを防ぐことができます。

## 依存関係の更新

このパッケージの依存関係を最新の状態に保つために、以下のコマンドが利用できます。

### Composer スクリプト

```bash
# 古くなった依存関係をチェック
composer update-check

# 本番環境の依存関係のみを更新
composer update-deps

# 開発環境も含めたすべての依存関係を更新
composer update-deps-dev
```

### 手動での更新

依存関係を安全に更新するためのスクリプトが提供されています：

```bash
./update-dependencies.sh
```

このスクリプトは以下の処理を行います：
- 古くなった依存関係の確認
- composer.lock のバックアップ作成
- 依存関係の更新
- PHP_CodeSniffer ルールセットの動作確認
- 問題があった場合の自動ロールバック

### 自動更新

GitHub Actions により、毎週月曜日に依存関係の更新チェックが自動実行されます。更新が必要な場合は、自動的にプルリクエストが作成されます。
