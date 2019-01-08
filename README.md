# ruby-vision

```shell
$ bundle
```

- `GOOGLE_APPLICATION_CREDENTIALS` の設定をする。

## 画像の文字認識

- 対象のファイルを指定する
```shell
$ bundle exec ruby detect_images.rb "./images/*.png"
```

## PDFの文字認識
Google Cloud StorageにアップロードしているPDFファイルを文字認識しjson形式として指定ディレクトリに保存（第１引数＝対象のPDF、第２引数＝json出力先）
```shell
$ bundle exec ruby detect_pdf.rb gs://9fu/pdfs/test.pdf gs://9fu/texts
```

Google Cloud Storageに出力されたjsonからテキストを抽出する（複数ある場合、先頭のjsonのみ対象。複数ページある場合、先頭ページのみ標準出力する）
```shell
$ bundle exec ruby parse_gs_json.rb gs://9fu/texts
```
