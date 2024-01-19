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
{
	"scripts": {
		"lint": "phpcs --standard=vendor/tarosky/coding-standards .",
		"fix": "phpcbf --standard=vendor/tarosky/coding-standards ."
	}
}
```

さらに、`composer lint` は GitHub Actions 等のCIツールを利用して、コミット時やプルリクエスト時に必ず実行されるようにしておくと、開発チーム全体でコードチェック漏れを防ぐことができます。
