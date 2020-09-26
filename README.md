# terraformのhelpをvimで参照するやつを作るのに必要な情報をまとめておくもの


`curl 'https://registry.terraform.io/v1/providers/hashicorp?limit=100'`

これでproviderの一覧取り出す

```json
{
  "meta":
    {
      "limit":1,
      "current_offset":0,
      "next_offset":1,
      "next_url":"/v1/providers/hashicorp?limit=1\u0026offset=1"
    },
  "providers":
    [
      {
        "id":"hashicorp/alicloud/1.98.0",
        "owner":"hashicorp",
        "namespace":"hashicorp",
        "name":"alicloud",
        "alias":null,
        "version":"1.98.0",
        "tag":"v1.98.0",
        "description":"terraform-provider-alicloud",
        "source":"https://github.com/hashicorp/terraform-provider-alicloud",
        "published_at":"2020-09-22T11:32:34Z",
        "downloads":604060,
        "tier":"official"
      }
    ]
  }
```


nameを/の後に入れるとproviderが見れる
`curl 'https://registry.terraform.io/v1/providers/hashicorp/alicloud`

結果はこんな感じ。

```json
{
  "id": "hashicorp/google/3.40.0",
  "owner": "hashicorp",
  "namespace": "hashicorp",
  "name": "google",
  "alias": "google",
  "version": "3.40.0",
  "tag": "v3.40.0",
  "description": "terraform-provider-google",
  "source": "https://github.com/hashicorp/terraform-provider-google",
  "published_at": "2020-09-22T00:05:01Z",
  "downloads": 19474086,
  "tier": "official",
  "versions": [
    "0.1.0",
    "...",
    "3.40.0"
  ],
  "docs": [
    {
      "id": "155449",
      "title": "overview",
      "path": "website/docs/index.html.markdown",
      "slug": "index",
      "category": "overview",
      "subcategory": ""
    }
  ]
}
```

`curl 'https://registry.terraform.io/v1/providers/hashicorp/alicloud | jq -r '.docs[].path`
って感じにすると対象resourceなどなどのドキュメントが持ってこれる。


curlしてjson持ってきて、json_encode()でパースして色々やってみよう
