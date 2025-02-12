//package com.example.web.tools.exception;
//
///**
// * 自定义全局异常
// */
//public class CustomException extends  RuntimeException{
//
//    protected Integer errorCode;
//    protected String errorMsg;
//
//    public CustomException(){
//
//    }
//    public CustomException(String errorMsg) {
//
//        this.errorMsg = errorMsg;
//    }
//
//    public Integer getErrorCode() {
//        return errorCode;
//    }
//
//    public void setErrorCode(Integer errorCode) {
//        this.errorCode = errorCode;
//    }
//
//    public String getErrorMsg() {
//        return errorMsg;
//    }
//
//    public void setErrorMsg(String errorMsg) {
//        this.errorMsg = errorMsg;
//    }
//
//}
package com.example.web.tools.exception;

/**
 * 自定义全局异常
 */
public class CustomException extends RuntimeException {

    private Integer errorCode;
    private String errorMsg;

    public CustomException() {
        super();
    }

    public CustomException(String errorMsg) {
        super(errorMsg); // 让父类 RuntimeException 处理消息，保证异常堆栈信息正确
        this.errorMsg = errorMsg;
    }

    public CustomException(String errorMsg, Integer errorCode) {
        super(errorMsg); // 传递给 RuntimeException，保证调用 `printStackTrace()` 有用
        this.errorCode = errorCode;
        this.errorMsg = errorMsg;
    }

    public Integer getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(Integer errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }
}

