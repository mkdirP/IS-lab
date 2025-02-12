package com.example.web.tools;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import lombok.SneakyThrows;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;

import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.util.Map;

/**
 * Http请求辅助类
 */
public   class HttpUtils {
    /**
     * 发送post请求
     * @param url  请求的路径
     * @param bodyData 请求的Json对象
     * @param headerMap 请求的header
     * @return 返回的结果
     */
    @SneakyThrows
    public static String Post(String url,Object bodyData, Map<String, String> headerMap) {

        String result="";
        // 声明一个ssl证书,声明他可以无视https的请求证书验证
        SSLContext sslContext = SSLContextBuilder.create().loadTrustMaterial(null, (chain, authType) -> true).build();

        // 获得Http客户端(可以理解为:你得先有一个浏览器;注意:实际上HttpClient与浏览器是不一样的)
        CloseableHttpClient httpClient = HttpClientBuilder
                .create()
                .setSSLContext(sslContext)
                .setSSLHostnameVerifier(new NoopHostnameVerifier())
                .build();

        // 创建Post请求
        HttpPost httpPost = new HttpPost(url);

        ObjectMapper mapper = new ObjectMapper();
        mapper.setPropertyNamingStrategy(PropertyNamingStrategy.UPPER_CAMEL_CASE);
        String jsonString = mapper.writeValueAsString(bodyData);

        StringEntity entity = new StringEntity(jsonString, "UTF-8");

        // post请求是将参数放在请求体里面传过去的;这里将entity放入post请求体中
        httpPost.setEntity(entity);

        //设置默认json的响应格式
        httpPost.setHeader("Content-Type", "application/json");

        //如果有自定义的头部 把值循环添加到httpPost头部中
        if(headerMap!=null&&headerMap.size()!=0)
        {
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                httpPost.addHeader(entry.getKey(), entry.getValue());
            }
        }

        // 响应模型
        CloseableHttpResponse response = null;
        try {
            // 由客户端执行(发送)Post请求
            response = httpClient.execute(httpPost);
            // 从响应模型中获取响应实体
            HttpEntity responseEntity = response.getEntity();

            System.out.println("响应状态为:" + response.getStatusLine());
            if (responseEntity != null) {
                System.out.println("响应内容长度为:" + responseEntity.getContentLength());
                System.out.println("响应内容为:" + EntityUtils.toString(responseEntity));
            }

        } finally {
            try {
                // 释放资源 为什么要释放,对应流这块系统不会自动的去释放 需要手动释放
                if (httpClient != null) {
                    httpClient.close();
                }
                if (response != null) {
                    response.close();
                }
                System.out.println("成功释放掉流资源");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return "成功";
    }


    /**
     * 以get方式调用第三方接口
     * @param url
     * @return
     */
    @SneakyThrows
    public static String Get(String url , Map<String, String> headerMap)  {

        // 声明一个ssl证书,声明他可以无视https的请求证书验证
        SSLContext sslContext = SSLContextBuilder.create().loadTrustMaterial(null, (chain, authType) -> true).build();


        // 获得Http客户端(可以理解为:你得先有一个浏览器;注意:实际上HttpClient与浏览器是不一样的)
        CloseableHttpClient httpClient = HttpClientBuilder
                .create()
                .setSSLContext(sslContext)
                .setSSLHostnameVerifier(new NoopHostnameVerifier())
                .build();

        HttpGet httpGet = new HttpGet(url);

        //如果有自定义的头部 把值循环添加到httpPost头部中
        if(headerMap!=null&&headerMap.size()!=0)
        {
            for (Map.Entry<String, String> entry : headerMap.entrySet()) {
                httpGet.addHeader(entry.getKey(), entry.getValue());
            }
        }
        try {
            HttpResponse response = httpClient.execute(httpGet);
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                //返回json格式
                String res = EntityUtils.toString(response.getEntity());
                return res;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }



}
