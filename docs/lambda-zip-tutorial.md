# Lambda Zip Tutorial (Node.js)

This creates a minimal Lambda handler and packages it into `lambda.zip`.

## 1) Create the handler
Create a file named `index.js` with this content:

```js
exports.handler = async () => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: "Hello from Lambda" })
  };
};
```

## 2) Zip the file
From the folder containing `index.js`, run:

```bash
zip lambda.zip index.js
```

## 3) Use it in Terraform
Set `lambda_zip_path` to `lambda.zip` or keep the default.
