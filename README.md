# Tarosky Coding Standards
Tarosky coding standards

## インストール

Composer でインストールします。

```
composer require --dev tarosky/coding-standards
```

下記使い方の通りにコマンドで一度実行し、エラーなくチェックが完走することを確認してください。

## 使い方

コマンドで実行する場合は、以下のようにします。

```
vendor/bin/phpcs --standard=vendor/tarosky/coding-standards .
```

`composer.json` にスクリプトを追加することで、 `composer lint` で実行できるようになります。併せて `composer fix` で自動修正もできるようにしておくと良いです。

```json
{
	"scripts": {
		"lint": "phpcs --standard=vendor/tarosky/coding-standards .",
		"fix": "phpcbf --standard=vendor/tarosky/coding-standards ."
	}
}
```
