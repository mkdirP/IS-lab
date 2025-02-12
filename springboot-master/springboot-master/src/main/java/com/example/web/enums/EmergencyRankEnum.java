package com.example.web.enums;

import java.util.HashMap;

public enum EmergencyRankEnum {

    /**
     * 正常
     */
    正常(1),

    /**
     * 一般
     */
    一般(2),

    /**
     * 警告
     */
    警告(3),

    /**
     * 紧急
     */
    紧急(4);


    private final int index;

    EmergencyRankEnum(int index) {
        this.index = index;
    }

    public int index() {
        return index;
    }

    private static final HashMap<Integer, EmergencyRankEnum> MY_MAP = new HashMap<Integer, EmergencyRankEnum>();

    static {
        for (EmergencyRankEnum myEnum : values()) {
            MY_MAP.put(myEnum.index(), myEnum);
        }
    }

    public static EmergencyRankEnum GetEnum(Integer v) {
        if (v == null) {
            return MY_MAP.values().stream().findFirst().get();
        }
        return MY_MAP.get(v);
    }

}
