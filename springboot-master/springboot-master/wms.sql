/*
 Navicat Premium Data Transfer

 Source Server         : 定制
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : wms

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 09/12/2024 11:28:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appuser
-- ----------------------------
DROP TABLE IF EXISTS `appuser`;
CREATE TABLE `appuser`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `Password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `Email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `UserName` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `Name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `RoleType` int(11) NULL DEFAULT NULL COMMENT '角色',
  `ImageUrls` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `Birth` datetime(0) NULL DEFAULT NULL COMMENT '出生年月',
  `PhoneNumber` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appuser
-- ----------------------------
INSERT INTO `appuser` VALUES (1, '2024-11-30 12:48:15', 0, 'admin', NULL, 'admin', '管理员', 1, NULL, NULL, NULL);
INSERT INTO `appuser` VALUES (2, '2024-11-30 13:59:54', 1, 'test0001', '8601289789@qq.com', 'test0001', '李子木', 2, 'http://localhost:7245/1732946393324/用户.png', '2024-11-05 00:00:00', '18574774833');
INSERT INTO `appuser` VALUES (3, '2024-12-09 10:44:57', 1, 'test006', '897986789@qq.com', 'test006', '科信', 2, 'http://localhost:7245/1733712296630/用户信息.png', '2024-12-01 00:00:00', '18574774811');

-- ----------------------------
-- Table structure for cargo
-- ----------------------------
DROP TABLE IF EXISTS `cargo`;
CREATE TABLE `cargo`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `SKU` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '条码',
  `Brand` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '品牌',
  `Specification` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '规格型号',
  `Unit` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '单位',
  `MinStockAlert` double(18, 6) NULL DEFAULT NULL COMMENT '最低库存预警',
  `MaxStockLimit` double(18, 6) NULL DEFAULT NULL COMMENT '最高库存限制',
  `CargoTypeId` int(11) NULL DEFAULT NULL COMMENT '商品分类',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `CargoTypeId`(`CargoTypeId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `cargo_ibfk_1` FOREIGN KEY (`CargoTypeId`) REFERENCES `cargotype` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `cargo_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `cargo_ibfk_3` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cargo
-- ----------------------------
INSERT INTO `cargo` VALUES (1, '2024-01-15 09:30:00', 1, 13, 7, '小米手机13 Pro', 'XMP13PRO-20240115', '小米', '6.73英寸 AMOLED, 12GB RAM, 512GB 存储', '台', 10.000000, 100.000000, 31);
INSERT INTO `cargo` VALUES (2, '2024-02-20 14:45:00', 2, 13, 2, '戴森吹风机 HD08', 'DSHD08-20240220', '戴森', '1600W, 磁吸风嘴, 智能温控', '个', 5.000000, 50.000000, 11);
INSERT INTO `cargo` VALUES (3, '2024-03-10 08:15:00', 3, 13, 3, '雀巢咖啡 1公斤', 'NESCAFE-1KG-20240310', '雀巢', '研磨咖啡, 100% 阿拉比卡豆', '袋', 20.000000, 200.000000, 4);
INSERT INTO `cargo` VALUES (4, '2024-04-05 11:20:00', 4, 13, 4, '联想笔记本电脑 ThinkPad X1 Carbon', 'LNX1C-20240405', '联想', '14英寸, Intel i7, 16GB RAM, 1TB SSD', '台', 3.000000, 30.000000, 30);
INSERT INTO `cargo` VALUES (5, '2024-05-18 16:35:00', 5, 13, 5, '耐克运动鞋 Air Max 270', 'NKAIRMAX270-20240518', '耐克', '男款, 白色, US 9', '双', 15.000000, 150.000000, 22);

-- ----------------------------
-- Table structure for cargotype
-- ----------------------------
DROP TABLE IF EXISTS `cargotype`;
CREATE TABLE `cargotype`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品分类主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `cargotype_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cargotype
-- ----------------------------
INSERT INTO `cargotype` VALUES (2, '2024-01-15 09:30:00', 1, '电子产品', 13);
INSERT INTO `cargotype` VALUES (3, '2024-02-20 14:45:00', 2, '家用电器', 13);
INSERT INTO `cargotype` VALUES (4, '2024-03-10 08:15:00', 3, '食品饮料', 13);
INSERT INTO `cargotype` VALUES (5, '2024-04-05 11:20:00', 4, '日用百货', 13);
INSERT INTO `cargotype` VALUES (6, '2024-05-18 16:35:00', 5, '办公用品', 13);
INSERT INTO `cargotype` VALUES (7, '2024-06-22 09:50:00', 6, '服装鞋帽', 13);
INSERT INTO `cargotype` VALUES (8, '2024-07-12 13:05:00', 7, '家居用品', 13);
INSERT INTO `cargotype` VALUES (9, '2024-08-03 10:40:00', 8, '体育用品', 13);
INSERT INTO `cargotype` VALUES (10, '2024-09-19 15:25:00', 9, '图书音像', 13);
INSERT INTO `cargotype` VALUES (11, '2024-10-08 09:10:00', 10, '化妆品', 13);
INSERT INTO `cargotype` VALUES (12, '2024-11-01 11:30:00', 1, '玩具礼品', 13);
INSERT INTO `cargotype` VALUES (13, '2024-11-15 14:00:00', 2, '汽车用品', 13);
INSERT INTO `cargotype` VALUES (14, '2024-12-05 09:25:00', 3, '医疗器械', 13);
INSERT INTO `cargotype` VALUES (15, '2024-01-20 10:55:00', 4, '宠物用品', 13);
INSERT INTO `cargotype` VALUES (16, '2024-02-14 12:40:00', 5, '母婴用品', 13);
INSERT INTO `cargotype` VALUES (17, '2024-03-28 14:10:00', 6, '建筑材料', 13);
INSERT INTO `cargotype` VALUES (18, '2024-04-11 09:45:00', 7, '园艺工具', 13);
INSERT INTO `cargotype` VALUES (19, '2024-05-05 11:00:00', 8, '珠宝首饰', 13);
INSERT INTO `cargotype` VALUES (20, '2024-06-30 13:30:00', 9, '艺术品', 13);
INSERT INTO `cargotype` VALUES (21, '2024-07-25 15:50:00', 10, '乐器', 13);
INSERT INTO `cargotype` VALUES (22, '2024-08-10 09:00:00', 1, '运动装备', 13);
INSERT INTO `cargotype` VALUES (23, '2024-09-15 10:30:00', 2, '户外装备', 13);
INSERT INTO `cargotype` VALUES (24, '2024-10-20 11:45:00', 3, '厨房用品', 13);
INSERT INTO `cargotype` VALUES (25, '2024-11-25 13:15:00', 4, '清洁用品', 13);
INSERT INTO `cargotype` VALUES (26, '2024-12-30 14:20:00', 5, '个人护理', 13);
INSERT INTO `cargotype` VALUES (27, '2025-01-10 09:45:00', 6, '床上用品', 13);
INSERT INTO `cargotype` VALUES (28, '2025-02-15 11:00:00', 7, '钟表配件', 13);
INSERT INTO `cargotype` VALUES (29, '2025-03-20 13:30:00', 8, '文具', 13);
INSERT INTO `cargotype` VALUES (30, '2025-04-25 15:00:00', 9, '电脑及配件', 13);
INSERT INTO `cargotype` VALUES (31, '2025-05-30 16:30:00', 10, '手机及配件', 13);
INSERT INTO `cargotype` VALUES (32, '2025-06-15 09:15:00', 1, '家具', 13);
INSERT INTO `cargotype` VALUES (33, '2025-07-20 10:45:00', 2, '厨具', 13);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '货主主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `OwnerName` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '货主名称',
  `ContactPerson` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `Phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `Email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `Address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '货主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '2024-11-30 15:18:26', 1, '字母哥编程书籍工厂', '字母哥', '18646215125', '635289789789@qq.com', '北京市朝阳区幸福路123号阳光花园小区5号楼2单元1202室', 13);
INSERT INTO `customer` VALUES (2, '2024-01-15 09:30:00', 1, '华联超市有限公司', '张伟', '+86 10 1234 5678', 'zhangwei@huolian.com', '北京市朝阳区东四环北路1号', 13);
INSERT INTO `customer` VALUES (3, '2024-02-20 14:45:00', 2, '苏宁易购股份有限公司', '李娜', '+86 21 8765 4321', 'lina@suning.com', '上海市浦东新区世纪大道88号', 13);
INSERT INTO `customer` VALUES (4, '2024-03-10 08:15:00', 3, '京东物流集团', '王强', '+86 20 5678 9012', 'wangqiang@jd.com', '广州市天河区天河北路30号', 13);
INSERT INTO `customer` VALUES (5, '2024-04-05 11:20:00', 4, '顺丰速运有限公司', '赵敏', '+86 27 1234 5678', 'zhaomin@sf-express.com', '武汉市洪山区珞喻路129号', 13);
INSERT INTO `customer` VALUES (6, '2024-05-18 16:35:00', 5, '圆通速递有限公司', '孙莉', '+86 28 8765 4321', 'sunli@yto.net.cn', '成都市武侯区人民南路四段12号', 13);
INSERT INTO `customer` VALUES (7, '2024-06-22 09:50:00', 6, '中通快递股份有限公司', '周涛', '+86 29 5678 9012', 'zhou@zto.com', '西安市雁塔区科技路38号', 13);

-- ----------------------------
-- Table structure for inventorycheck
-- ----------------------------
DROP TABLE IF EXISTS `inventorycheck`;
CREATE TABLE `inventorycheck`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '盘点单主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `No` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '单号',
  `CheckUserId` int(11) NULL DEFAULT NULL COMMENT '盘点人',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `InventoryCheckStatus` int(11) NULL DEFAULT NULL COMMENT '盘点状态',
  `IsExcuteInventoryChange` tinyint(1) NULL DEFAULT NULL COMMENT '是否执行库存调整',
  `BeginCheckTime` datetime(0) NULL DEFAULT NULL COMMENT '起始盘点时间',
  `EndCheckTime` datetime(0) NULL DEFAULT NULL COMMENT '截至盘点时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `CheckUserId`(`CheckUserId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  CONSTRAINT `inventorycheck_ibfk_1` FOREIGN KEY (`CheckUserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventorycheck_ibfk_2` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventorycheck_ibfk_3` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '盘点单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventorycheck
-- ----------------------------
INSERT INTO `inventorycheck` VALUES (1, '2024-11-30 21:38:10', 2, 'P202411302138', 2, 13, 5, 3, 1, '2024-11-30 00:00:00', '2024-12-01 00:00:00');
INSERT INTO `inventorycheck` VALUES (2, '2024-12-09 11:03:04', 1, 'P202412-01103', 1, 13, 1, 3, 1, '2024-12-09 00:00:00', '2024-12-11 00:00:00');
INSERT INTO `inventorycheck` VALUES (3, '2024-12-09 11:05:46', 1, 'P202412091105', 1, 13, 5, 3, 1, '2024-12-09 00:00:00', '2024-12-10 00:00:00');
INSERT INTO `inventorycheck` VALUES (4, '2024-12-09 11:18:31', 1, 'P202412091118', 1, 13, 5, 3, 1, '2024-12-09 00:00:00', '2024-12-10 00:00:00');

-- ----------------------------
-- Table structure for inventorycheckdet
-- ----------------------------
DROP TABLE IF EXISTS `inventorycheckdet`;
CREATE TABLE `inventorycheckdet`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '盘点明细主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `InventoryCheckId` int(11) NULL DEFAULT NULL COMMENT '盘点单',
  `WarehouseBinId` int(11) NULL DEFAULT NULL COMMENT '库位',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CargoId` int(11) NULL DEFAULT NULL COMMENT '商品',
  `Qty` double(20, 5) NULL DEFAULT NULL COMMENT '数量',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `CargoId`(`CargoId`) USING BTREE,
  INDEX `WarehouseBinId`(`WarehouseBinId`) USING BTREE,
  INDEX `InventoryCheckId`(`InventoryCheckId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `inventorycheckdet_ibfk_1` FOREIGN KEY (`CargoId`) REFERENCES `cargo` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventorycheckdet_ibfk_2` FOREIGN KEY (`WarehouseBinId`) REFERENCES `warehousebin` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventorycheckdet_ibfk_3` FOREIGN KEY (`InventoryCheckId`) REFERENCES `inventorycheck` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventorycheckdet_ibfk_4` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '盘点明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventorycheckdet
-- ----------------------------
INSERT INTO `inventorycheckdet` VALUES (1, '2024-11-30 21:42:43', 2, 1, 1, 13, 5, 10.00000);
INSERT INTO `inventorycheckdet` VALUES (2, '2024-12-09 11:04:16', 1, 2, 1, 13, 5, 10.00000);
INSERT INTO `inventorycheckdet` VALUES (3, '2024-12-09 11:05:51', 1, 3, 1, 13, 5, 10.00000);
INSERT INTO `inventorycheckdet` VALUES (4, '2024-12-09 11:18:40', 1, 4, 11, 13, 5, 6.00000);

-- ----------------------------
-- Table structure for inventoryrecord
-- ----------------------------
DROP TABLE IF EXISTS `inventoryrecord`;
CREATE TABLE `inventoryrecord`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库存记录主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `CargoId` int(11) NULL DEFAULT NULL COMMENT '商品',
  `WarehouseBinId` int(11) NULL DEFAULT NULL COMMENT '库位',
  `StockQty` double(20, 5) NULL DEFAULT NULL COMMENT '库存数量',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseBinId`(`WarehouseBinId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  INDEX `CargoId`(`CargoId`) USING BTREE,
  CONSTRAINT `inventoryrecord_ibfk_1` FOREIGN KEY (`WarehouseBinId`) REFERENCES `warehousebin` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventoryrecord_ibfk_2` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventoryrecord_ibfk_3` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventoryrecord_ibfk_4` FOREIGN KEY (`CargoId`) REFERENCES `cargo` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '库存记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventoryrecord
-- ----------------------------
INSERT INTO `inventoryrecord` VALUES (1, '2024-11-30 16:48:11', 2, 13, 5, 5, 1, 10.00000);
INSERT INTO `inventoryrecord` VALUES (2, '2024-12-09 11:04:40', 1, 13, 1, 5, 1, 10.00000);
INSERT INTO `inventoryrecord` VALUES (3, '2024-12-09 11:16:20', 1, 13, 5, 5, 11, 6.00000);

-- ----------------------------
-- Table structure for inventoryruningrecord
-- ----------------------------
DROP TABLE IF EXISTS `inventoryruningrecord`;
CREATE TABLE `inventoryruningrecord`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库存流水记录主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CargoId` int(11) NULL DEFAULT NULL COMMENT '商品',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `Type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  `RelativeNo` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联单号',
  `Qty` double(20, 5) NULL DEFAULT NULL COMMENT '变动数量',
  `WarehouseBinId` int(11) NULL DEFAULT NULL COMMENT '库位',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `CargoId`(`CargoId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  CONSTRAINT `inventoryruningrecord_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventoryruningrecord_ibfk_2` FOREIGN KEY (`CargoId`) REFERENCES `cargo` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `inventoryruningrecord_ibfk_3` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '库存流水记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventoryruningrecord
-- ----------------------------
INSERT INTO `inventoryruningrecord` VALUES (1, '2024-11-30 16:48:11', 2, 13, 5, 5, '入库完成', 'IN202411301610', 1.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (4, '2024-11-30 18:00:10', 2, 13, 5, 5, '出库完成', 'OUT202411301715', -1.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (5, '2024-11-30 21:55:46', 2, 13, 5, 5, '盘点完成', 'P202411302138', 10.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (6, '2024-12-09 11:01:09', 1, 13, 5, 5, '入库完成', 'IN2024120911', 15.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (7, '2024-12-09 11:02:36', 1, 13, 5, 5, '出库完成', 'OUT20241291102', -5.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (8, '2024-12-09 11:04:40', 1, 13, 5, 1, '盘点完成', 'P202412-01103', 10.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (9, '2024-12-09 11:05:56', 1, 13, 5, 5, '盘点完成', 'P202412091105', -10.00000, 1);
INSERT INTO `inventoryruningrecord` VALUES (10, '2024-12-09 11:16:20', 1, 13, 5, 5, '入库完成', '202412091115', 10.00000, 11);
INSERT INTO `inventoryruningrecord` VALUES (11, '2024-12-09 11:17:37', 1, 13, 5, 5, '出库完成', 'OUT20241209', -5.00000, 11);
INSERT INTO `inventoryruningrecord` VALUES (12, '2024-12-09 11:18:52', 1, 13, 5, 5, '盘点完成', 'P202412091118', 1.00000, 11);

-- ----------------------------
-- Table structure for stockin
-- ----------------------------
DROP TABLE IF EXISTS `stockin`;
CREATE TABLE `stockin`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库单主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `No` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '入库单号',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `StockInType` int(11) NULL DEFAULT NULL COMMENT '入库类型枚举',
  `StockInStatus` int(11) NULL DEFAULT NULL COMMENT '入库状态枚举',
  `InTime` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `Remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `PlanInTime` datetime(0) NULL DEFAULT NULL COMMENT '计划入库时间',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  CONSTRAINT `stockin_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockin_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 220 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '入库单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stockin
-- ----------------------------
INSERT INTO `stockin` VALUES (1, '2024-11-30 16:10:40', 2, 'IN202411301610', 13, 5, 1, 3, '2024-11-30 16:48:11', '正常入库', '2024-11-30 00:00:00');
INSERT INTO `stockin` VALUES (2, '2024-11-30 23:20:22', 2, 'IN202411302319', 13, 5, 1, 1, NULL, '正常入库', '2024-12-01 00:00:00');
INSERT INTO `stockin` VALUES (3, '2024-11-30 23:21:20', 2, 'IN202411302321', 13, 7, 2, 1, NULL, '测试', '2024-12-04 00:00:00');
INSERT INTO `stockin` VALUES (4, '2024-11-30 23:36:40', 2, '202411302336', 13, 7, 1, 1, NULL, '测试', '2024-11-29 00:00:00');
INSERT INTO `stockin` VALUES (5, '2024-11-30 23:43:52', 2, 'IN202411302343', 13, 6, 3, 1, NULL, '测试', '2024-12-19 00:00:00');
INSERT INTO `stockin` VALUES (6, '2024-11-30 23:44:31', 2, 'IN202411302345', 13, 6, 1, 1, NULL, '测试', '2024-12-06 00:00:00');
INSERT INTO `stockin` VALUES (7, '2024-12-09 09:56:20', 2, 'IN2024129956', 13, 7, 1, 2, NULL, '测试', '2024-12-09 09:56:14');
INSERT INTO `stockin` VALUES (8, '2024-12-09 00:00:00', 2, '20241209100230111336', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (9, '2024-12-09 00:00:00', 2, '20241209100230966448', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (10, '2024-12-09 00:00:00', 2, '20241209100230530205', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (11, '2024-12-09 00:00:00', 2, '20241209100230149275', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (12, '2024-12-09 00:00:00', 2, '20241209100230380853', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (13, '2024-12-09 00:00:00', 2, '20241209100230348580', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (14, '2024-12-09 00:00:00', 2, '20241209100230188833', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:31');
INSERT INTO `stockin` VALUES (15, '2024-12-08 00:00:00', 2, '20241209100232641125', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (16, '2024-12-08 00:00:00', 2, '20241209100232327123', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (17, '2024-12-08 00:00:00', 2, '20241209100232851596', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (18, '2024-12-08 00:00:00', 2, '20241209100232864352', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (19, '2024-12-08 00:00:00', 2, '20241209100232556326', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (20, '2024-12-08 00:00:00', 2, '20241209100232989140', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (21, '2024-12-08 00:00:00', 2, '20241209100232271506', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (22, '2024-12-07 00:00:00', 2, '20241209100232973230', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (23, '2024-12-07 00:00:00', 2, '20241209100232608612', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (24, '2024-12-07 00:00:00', 2, '20241209100232149017', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (25, '2024-12-07 00:00:00', 2, '20241209100232323809', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (26, '2024-12-07 00:00:00', 2, '20241209100232522469', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (27, '2024-12-07 00:00:00', 2, '20241209100232782743', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (28, '2024-12-07 00:00:00', 2, '20241209100232975896', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (29, '2024-12-06 00:00:00', 2, '20241209100232592011', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (30, '2024-12-06 00:00:00', 2, '20241209100232256122', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (31, '2024-12-06 00:00:00', 2, '20241209100232724609', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (32, '2024-12-06 00:00:00', 2, '20241209100232601110', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (33, '2024-12-06 00:00:00', 2, '20241209100232751536', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (34, '2024-12-06 00:00:00', 2, '20241209100232254679', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (35, '2024-12-06 00:00:00', 2, '20241209100232924493', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (36, '2024-12-05 00:00:00', 2, '20241209100232916489', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (37, '2024-12-05 00:00:00', 2, '20241209100232276101', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (38, '2024-12-05 00:00:00', 2, '20241209100232598803', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (39, '2024-12-05 00:00:00', 2, '20241209100232981505', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (40, '2024-12-05 00:00:00', 2, '20241209100232427656', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (41, '2024-12-05 00:00:00', 2, '20241209100232577467', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (42, '2024-12-05 00:00:00', 2, '20241209100232662885', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (43, '2024-12-04 00:00:00', 2, '20241209100232357520', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (44, '2024-12-04 00:00:00', 2, '20241209100232287199', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (45, '2024-12-04 00:00:00', 2, '20241209100232151429', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (46, '2024-12-04 00:00:00', 2, '20241209100232861042', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (47, '2024-12-04 00:00:00', 2, '20241209100232877562', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (48, '2024-12-04 00:00:00', 2, '20241209100232778848', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (49, '2024-12-04 00:00:00', 2, '20241209100232803041', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (50, '2024-12-03 00:00:00', 2, '20241209100232628415', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (51, '2024-12-03 00:00:00', 2, '20241209100232510190', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (52, '2024-12-03 00:00:00', 2, '20241209100232623036', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (53, '2024-12-03 00:00:00', 2, '20241209100232802258', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (54, '2024-12-03 00:00:00', 2, '20241209100232484017', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (55, '2024-12-03 00:00:00', 2, '20241209100232566259', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (56, '2024-12-03 00:00:00', 2, '20241209100232126723', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (57, '2024-12-02 00:00:00', 2, '20241209100232877556', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (58, '2024-12-02 00:00:00', 2, '20241209100232187865', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (59, '2024-12-02 00:00:00', 2, '20241209100232987299', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (60, '2024-12-02 00:00:00', 2, '20241209100232805894', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (61, '2024-12-02 00:00:00', 2, '20241209100232489536', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (62, '2024-12-02 00:00:00', 2, '20241209100232474790', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (63, '2024-12-02 00:00:00', 2, '20241209100232955847', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (64, '2024-12-01 00:00:00', 2, '20241209100232367842', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (65, '2024-12-01 00:00:00', 2, '20241209100232239143', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (66, '2024-12-01 00:00:00', 2, '20241209100232520037', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (67, '2024-12-01 00:00:00', 2, '20241209100232749167', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (68, '2024-12-01 00:00:00', 2, '20241209100232152170', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (69, '2024-12-01 00:00:00', 2, '20241209100232355829', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (70, '2024-12-01 00:00:00', 2, '20241209100232167678', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (71, '2024-11-30 00:00:00', 2, '20241209100232175118', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (72, '2024-11-30 00:00:00', 2, '20241209100232294381', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (73, '2024-11-30 00:00:00', 2, '20241209100232279858', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (74, '2024-11-30 00:00:00', 2, '20241209100232231847', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (75, '2024-11-30 00:00:00', 2, '20241209100232974336', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (76, '2024-11-30 00:00:00', 2, '20241209100232893989', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (77, '2024-11-30 00:00:00', 2, '20241209100232999898', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (78, '2024-11-29 00:00:00', 2, '20241209100232762930', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (79, '2024-11-29 00:00:00', 2, '20241209100232246402', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (80, '2024-11-29 00:00:00', 2, '20241209100232540284', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (81, '2024-11-29 00:00:00', 2, '20241209100232832177', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (82, '2024-11-29 00:00:00', 2, '20241209100232856118', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (83, '2024-11-29 00:00:00', 2, '20241209100232159376', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (84, '2024-11-29 00:00:00', 2, '20241209100232973188', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (85, '2024-11-28 00:00:00', 2, '20241209100232830670', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (86, '2024-11-28 00:00:00', 2, '20241209100232768094', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (87, '2024-11-28 00:00:00', 2, '20241209100232231816', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (88, '2024-11-28 00:00:00', 2, '20241209100232234103', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (89, '2024-11-28 00:00:00', 2, '20241209100232799146', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (90, '2024-11-28 00:00:00', 2, '20241209100232499123', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (91, '2024-11-28 00:00:00', 2, '20241209100232134332', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (92, '2024-11-27 00:00:00', 2, '20241209100232692181', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (93, '2024-11-27 00:00:00', 2, '20241209100232535384', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (94, '2024-11-27 00:00:00', 2, '20241209100232192470', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (95, '2024-11-27 00:00:00', 2, '20241209100232943778', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (96, '2024-11-27 00:00:00', 2, '20241209100232915182', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (97, '2024-11-27 00:00:00', 2, '20241209100232175449', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (98, '2024-11-27 00:00:00', 2, '20241209100232700788', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (99, '2024-11-26 00:00:00', 2, '20241209100232497303', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (100, '2024-11-26 00:00:00', 2, '20241209100232190864', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (101, '2024-11-26 00:00:00', 2, '20241209100232221656', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (102, '2024-11-26 00:00:00', 2, '20241209100232870032', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (103, '2024-11-26 00:00:00', 2, '20241209100232635801', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (104, '2024-11-26 00:00:00', 2, '20241209100232194815', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (105, '2024-11-26 00:00:00', 2, '20241209100232931678', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (106, '2024-11-25 00:00:00', 2, '20241209100232495435', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (107, '2024-11-25 00:00:00', 2, '20241209100232596703', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (108, '2024-11-25 00:00:00', 2, '20241209100232943688', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (109, '2024-11-25 00:00:00', 2, '20241209100232318257', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (110, '2024-11-25 00:00:00', 2, '20241209100232411216', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (111, '2024-11-25 00:00:00', 2, '20241209100232914577', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (112, '2024-11-25 00:00:00', 2, '20241209100232169014', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (113, '2024-11-24 00:00:00', 2, '20241209100232859045', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (114, '2024-11-24 00:00:00', 2, '20241209100232485961', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (115, '2024-11-24 00:00:00', 2, '20241209100232514680', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (116, '2024-11-24 00:00:00', 2, '20241209100232396042', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (117, '2024-11-24 00:00:00', 2, '20241209100232444339', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (118, '2024-11-24 00:00:00', 2, '20241209100232908959', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (119, '2024-11-24 00:00:00', 2, '20241209100232939375', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (120, '2024-11-23 00:00:00', 2, '20241209100232914551', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (121, '2024-11-23 00:00:00', 2, '20241209100232796824', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (122, '2024-11-23 00:00:00', 2, '20241209100232369336', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (123, '2024-11-23 00:00:00', 2, '20241209100232830245', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (124, '2024-11-23 00:00:00', 2, '20241209100232584097', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (125, '2024-11-23 00:00:00', 2, '20241209100232581900', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (126, '2024-11-23 00:00:00', 2, '20241209100232649386', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (127, '2024-11-22 00:00:00', 2, '20241209100232499770', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (128, '2024-11-22 00:00:00', 2, '20241209100232924883', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (129, '2024-11-22 00:00:00', 2, '20241209100232889778', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (130, '2024-11-22 00:00:00', 2, '20241209100232576328', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (131, '2024-11-22 00:00:00', 2, '20241209100232265596', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (132, '2024-11-22 00:00:00', 2, '20241209100232507236', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (133, '2024-11-22 00:00:00', 2, '20241209100232111242', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (134, '2024-11-21 00:00:00', 2, '20241209100232302532', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (135, '2024-11-21 00:00:00', 2, '20241209100232387702', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (136, '2024-11-21 00:00:00', 2, '20241209100232467626', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (137, '2024-11-21 00:00:00', 2, '20241209100232447834', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (138, '2024-11-21 00:00:00', 2, '20241209100232913315', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (139, '2024-11-21 00:00:00', 2, '20241209100232444182', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (140, '2024-11-21 00:00:00', 2, '20241209100232747225', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (141, '2024-11-20 00:00:00', 2, '20241209100232394182', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (142, '2024-11-20 00:00:00', 2, '20241209100232393487', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (143, '2024-11-20 00:00:00', 2, '20241209100232404910', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (144, '2024-11-20 00:00:00', 2, '20241209100232470203', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (145, '2024-11-20 00:00:00', 2, '20241209100232905282', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (146, '2024-11-20 00:00:00', 2, '20241209100232119117', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (147, '2024-11-20 00:00:00', 2, '20241209100233213993', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (148, '2024-11-19 00:00:00', 2, '20241209100233453254', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (149, '2024-11-19 00:00:00', 2, '20241209100233614799', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (150, '2024-11-19 00:00:00', 2, '20241209100233379362', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (151, '2024-11-19 00:00:00', 2, '20241209100233971720', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (152, '2024-11-19 00:00:00', 2, '20241209100233565318', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (153, '2024-11-19 00:00:00', 2, '20241209100233801751', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (154, '2024-11-19 00:00:00', 2, '20241209100233474690', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (155, '2024-11-18 00:00:00', 2, '20241209100233914615', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (156, '2024-11-18 00:00:00', 2, '20241209100233336998', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (157, '2024-11-18 00:00:00', 2, '20241209100233212464', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (158, '2024-11-18 00:00:00', 2, '20241209100233882461', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (159, '2024-11-18 00:00:00', 2, '20241209100233128239', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (160, '2024-11-18 00:00:00', 2, '20241209100233152888', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (161, '2024-11-18 00:00:00', 2, '20241209100233732240', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (162, '2024-11-17 00:00:00', 2, '20241209100233228617', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (163, '2024-11-17 00:00:00', 2, '20241209100233991555', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (164, '2024-11-17 00:00:00', 2, '20241209100233346832', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (165, '2024-11-17 00:00:00', 2, '20241209100233766933', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (166, '2024-11-17 00:00:00', 2, '20241209100233955047', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (167, '2024-11-17 00:00:00', 2, '20241209100233443940', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (168, '2024-11-17 00:00:00', 2, '20241209100233260076', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (169, '2024-11-16 00:00:00', 2, '20241209100233438460', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (170, '2024-11-16 00:00:00', 2, '20241209100233926261', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (171, '2024-11-16 00:00:00', 2, '20241209100233886351', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (172, '2024-11-16 00:00:00', 2, '20241209100233715344', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (173, '2024-11-16 00:00:00', 2, '20241209100233420254', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (174, '2024-11-16 00:00:00', 2, '20241209100233476101', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (175, '2024-11-16 00:00:00', 2, '20241209100233976678', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (176, '2024-11-15 00:00:00', 2, '20241209100233606067', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (177, '2024-11-15 00:00:00', 2, '20241209100233138756', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (178, '2024-11-15 00:00:00', 2, '20241209100233255470', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (179, '2024-11-15 00:00:00', 2, '20241209100233655989', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (180, '2024-11-15 00:00:00', 2, '20241209100233899286', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (181, '2024-11-15 00:00:00', 2, '20241209100233245274', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (182, '2024-11-15 00:00:00', 2, '20241209100233905460', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (183, '2024-11-14 00:00:00', 2, '20241209100233947135', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (184, '2024-11-14 00:00:00', 2, '20241209100233903232', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (185, '2024-11-14 00:00:00', 2, '20241209100233418879', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (186, '2024-11-14 00:00:00', 2, '20241209100233646741', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (187, '2024-11-14 00:00:00', 2, '20241209100233900132', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (188, '2024-11-14 00:00:00', 2, '20241209100233156103', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (189, '2024-11-14 00:00:00', 2, '20241209100233795488', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (190, '2024-11-13 00:00:00', 2, '20241209100233545721', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (191, '2024-11-13 00:00:00', 2, '20241209100233619717', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (192, '2024-11-13 00:00:00', 2, '20241209100233351306', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (193, '2024-11-13 00:00:00', 2, '20241209100233630866', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (194, '2024-11-13 00:00:00', 2, '20241209100233190722', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (195, '2024-11-13 00:00:00', 2, '20241209100233699694', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (196, '2024-11-13 00:00:00', 2, '20241209100233126181', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (197, '2024-11-12 00:00:00', 2, '20241209100233596019', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (198, '2024-11-12 00:00:00', 2, '20241209100233487312', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (199, '2024-11-12 00:00:00', 2, '20241209100233405922', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (200, '2024-11-12 00:00:00', 2, '20241209100233306239', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (201, '2024-11-12 00:00:00', 2, '20241209100233472295', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (202, '2024-11-12 00:00:00', 2, '20241209100233160938', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (203, '2024-11-12 00:00:00', 2, '20241209100233895249', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (204, '2024-11-11 00:00:00', 2, '20241209100233114952', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (205, '2024-11-11 00:00:00', 2, '20241209100233460468', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (206, '2024-11-11 00:00:00', 2, '20241209100233737105', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (207, '2024-11-11 00:00:00', 2, '20241209100233331185', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (208, '2024-11-11 00:00:00', 2, '20241209100233930350', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (209, '2024-11-11 00:00:00', 2, '20241209100233643191', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (210, '2024-11-11 00:00:00', 2, '20241209100233654648', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (211, '2024-11-10 00:00:00', 2, '20241209100233558821', 13, 1, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (212, '2024-11-10 00:00:00', 2, '20241209100233294008', 13, 2, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (213, '2024-11-10 00:00:00', 2, '20241209100233643431', 13, 3, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (214, '2024-11-10 00:00:00', 2, '20241209100233455978', 13, 4, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (215, '2024-11-10 00:00:00', 2, '20241209100233431229', 13, 5, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (216, '2024-11-10 00:00:00', 2, '20241209100233855419', 13, 6, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (217, '2024-11-10 00:00:00', 2, '20241209100233502831', 13, 7, 1, 1, NULL, '正常入库', '2025-01-08 10:02:33');
INSERT INTO `stockin` VALUES (218, '2024-12-09 11:00:35', 1, 'IN2024120911', 13, 5, 1, 3, '2024-12-09 11:01:09', '测试', '2024-12-09 00:00:00');
INSERT INTO `stockin` VALUES (219, '2024-12-09 11:15:35', 1, '202412091115', 13, 5, 1, 3, '2024-12-09 11:16:20', '测试', '2024-12-09 00:00:00');

-- ----------------------------
-- Table structure for stockindet
-- ----------------------------
DROP TABLE IF EXISTS `stockindet`;
CREATE TABLE `stockindet`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入库明细主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `StockInId` int(11) NULL DEFAULT NULL COMMENT '入库单',
  `WarehouseBinId` int(11) NULL DEFAULT NULL COMMENT '库位',
  `CargoId` int(11) NULL DEFAULT NULL COMMENT '商品',
  `Qty` double(20, 5) NULL DEFAULT NULL COMMENT '数量',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `StockInId`(`StockInId`) USING BTREE,
  INDEX `WarehouseBinId`(`WarehouseBinId`) USING BTREE,
  INDEX `CargoId`(`CargoId`) USING BTREE,
  CONSTRAINT `stockindet_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockindet_ibfk_2` FOREIGN KEY (`StockInId`) REFERENCES `stockin` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockindet_ibfk_3` FOREIGN KEY (`WarehouseBinId`) REFERENCES `warehousebin` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockindet_ibfk_4` FOREIGN KEY (`CargoId`) REFERENCES `cargo` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '入库明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stockindet
-- ----------------------------
INSERT INTO `stockindet` VALUES (1, '2024-11-30 16:16:57', 2, 1, 1, 5, 1.00000, 13);
INSERT INTO `stockindet` VALUES (2, '2024-12-09 10:05:02', 2, 7, 1, 1, 1.00000, 13);
INSERT INTO `stockindet` VALUES (3, '2024-12-09 11:00:59', 1, 218, 1, 5, 15.00000, 13);
INSERT INTO `stockindet` VALUES (4, '2024-12-09 11:16:08', 1, 219, 11, 5, 10.00000, 13);

-- ----------------------------
-- Table structure for stockout
-- ----------------------------
DROP TABLE IF EXISTS `stockout`;
CREATE TABLE `stockout`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '出库单主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `No` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '单号',
  `CustomerId` int(11) NULL DEFAULT NULL COMMENT '货主',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `OutTime` datetime(0) NULL DEFAULT NULL COMMENT '出库时间',
  `PlanOutTime` datetime(0) NULL DEFAULT NULL COMMENT '计划出库时间',
  `Remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `StockOutType` int(11) NULL DEFAULT NULL COMMENT '出库类型枚举',
  `StockOutStatus` int(11) NULL DEFAULT NULL COMMENT '出库状态枚举',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `CustomerId`(`CustomerId`) USING BTREE,
  CONSTRAINT `stockout_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockout_ibfk_2` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '出库单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stockout
-- ----------------------------
INSERT INTO `stockout` VALUES (1, '2024-11-30 17:15:34', 2, 'OUT202411301715', 5, 13, '2024-11-30 18:00:10', '2024-11-30 00:00:00', '正常的销售出库', 1, 5);
INSERT INTO `stockout` VALUES (2, '2024-11-30 23:41:56', 2, 'OUT202411302341', 6, 13, NULL, '2024-12-20 00:00:00', '测试', 2, 1);
INSERT INTO `stockout` VALUES (3, '2024-12-01 00:14:32', 2, 'OUT2024120102', 5, 13, NULL, '2024-12-03 00:00:00', '测试', 2, 1);
INSERT INTO `stockout` VALUES (4, '2024-12-09 11:02:22', 1, 'OUT20241291102', 5, 13, '2024-12-09 11:02:36', '2024-12-09 00:00:00', '测试', 2, 5);
INSERT INTO `stockout` VALUES (5, '2024-12-09 11:16:58', 1, 'OUT20241209', 5, 13, '2024-12-09 11:17:37', '2024-12-09 00:00:00', '测试', 1, 5);

-- ----------------------------
-- Table structure for stockoutdet
-- ----------------------------
DROP TABLE IF EXISTS `stockoutdet`;
CREATE TABLE `stockoutdet`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '出库明细主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `StockOutId` int(11) NULL DEFAULT NULL COMMENT '出库单',
  `CargoId` int(11) NULL DEFAULT NULL COMMENT '商品',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  `Qty` double(20, 5) NULL DEFAULT NULL COMMENT '数量',
  `WarehouseBinId` int(11) NULL DEFAULT NULL COMMENT '库位',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `CargoId`(`CargoId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  INDEX `WarehouseBinId`(`WarehouseBinId`) USING BTREE,
  INDEX `StockOutId`(`StockOutId`) USING BTREE,
  CONSTRAINT `stockoutdet_ibfk_1` FOREIGN KEY (`CargoId`) REFERENCES `cargo` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockoutdet_ibfk_2` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockoutdet_ibfk_3` FOREIGN KEY (`WarehouseBinId`) REFERENCES `warehousebin` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `stockoutdet_ibfk_4` FOREIGN KEY (`StockOutId`) REFERENCES `stockout` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '出库明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stockoutdet
-- ----------------------------
INSERT INTO `stockoutdet` VALUES (2, '2024-11-30 17:28:22', 2, 1, 5, 13, 1.00000, 1);
INSERT INTO `stockoutdet` VALUES (3, '2024-12-09 11:02:31', 1, 4, 5, 13, 5.00000, 1);
INSERT INTO `stockoutdet` VALUES (4, '2024-12-09 11:17:12', 1, 5, 5, 13, 5.00000, 11);

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `Name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '仓库名称',
  `Address` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `City` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '城市',
  `Country` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国家',
  `ContactPerson` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系人',
  `Area` double(20, 5) NULL DEFAULT NULL COMMENT '面积',
  `Type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '仓库类型',
  `EnvironmentalConditions` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '环境条件',
  `Phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '仓库表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES (1, '2024-01-15 09:30:00', 1, '华北仓储中心', '北京市朝阳区东四环北路1号', '北京', '中国', '张伟', 5000.00000, '普通仓库', '常温', '+86 10 1234 5678');
INSERT INTO `warehouse` VALUES (2, '2024-02-20 14:45:00', 2, '华东仓储中心', '上海市浦东新区世纪大道88号', '上海', '中国', '李娜', 7500.00000, '冷藏仓库', '冷藏温度控制在2-8°C', '+86 21 8765 4321');
INSERT INTO `warehouse` VALUES (3, '2024-03-10 08:15:00', 3, '华南仓储中心', '广州市天河区天河北路30号', '广州', '中国', '王强', 6000.00000, '危险品仓库', '防火防爆', '+86 20 5678 9012');
INSERT INTO `warehouse` VALUES (4, '2024-04-05 11:20:00', 4, '华中仓储中心', '武汉市洪山区珞喻路129号', '武汉', '中国', '赵敏', 4500.00000, '普通仓库', '常温', '+86 27 1234 5678');
INSERT INTO `warehouse` VALUES (5, '2024-05-18 16:35:00', 5, '西南仓储中心', '成都市武侯区人民南路四段12号', '成都', '中国', '孙莉', 5500.00000, '冷冻仓库', '冷冻温度控制在-18°C以下', '+86 28 8765 4321');
INSERT INTO `warehouse` VALUES (6, '2024-06-22 09:50:00', 6, '西北仓储中心', '西安市雁塔区科技路38号', '西安', '中国', '周涛', 4000.00000, '普通仓库', '常温', '+86 29 5678 9012');
INSERT INTO `warehouse` VALUES (7, '2024-07-12 13:05:00', 7, '东北仓储中心', '沈阳市和平区青年大街288号', '沈阳', '中国', '吴芳', 6500.00000, '冷藏仓库', '冷藏温度控制在2-8°C', '+86 24 1234 5678');
INSERT INTO `warehouse` VALUES (8, '2024-08-03 10:40:00', 8, '东南仓储中心', '厦门市思明区湖滨南路95号', '厦门', '中国', '郑军', 5000.00000, '普通仓库', '常温', '+86 592 8765 4321');
INSERT INTO `warehouse` VALUES (9, '2024-09-19 15:25:00', 9, '香港仓储中心', '香港九龙观塘道418号', '香港', '中国香港', '黄磊', 8000.00000, '保税仓库', '海关监管', '+852 2345 6789');
INSERT INTO `warehouse` VALUES (10, '2024-10-08 09:10:00', 10, '澳门仓储中心', '澳门新口岸宋玉生广场333号', '澳门', '中国澳门', '陈静', 4500.00000, '普通仓库', '常温', '+853 1234 5678');
INSERT INTO `warehouse` VALUES (11, '2024-11-01 11:30:00', 11, '台北仓储中心', '台北市信义区松智路15号', '台北', '中国台湾', '林晓', 6000.00000, '冷冻仓库', '冷冻温度控制在-18°C以下', '+886 2 2718 2718');
INSERT INTO `warehouse` VALUES (12, '2024-11-15 14:00:00', 12, '首尔仓储中心', '韩国首尔特别市江南区论岘路123号', '首尔', '韩国', '朴正熙', 7000.00000, '普通仓库', '常温', '+82 2 1234 5678');
INSERT INTO `warehouse` VALUES (13, '2024-12-05 09:25:00', 13, '东京仓储中心', '日本东京都千代田区丸之内1-1-1', '东京', '日本', '田中一郎', 9000.00000, '冷藏仓库', '冷藏温度控制在2-8°C', '+81 3 1234 5678');

-- ----------------------------
-- Table structure for warehousebin
-- ----------------------------
DROP TABLE IF EXISTS `warehousebin`;
CREATE TABLE `warehousebin`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库位主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '所属仓库',
  `BinCode` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '库位编码',
  `Type` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  `Level` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '层',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `warehousebin_ibfk_1` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '库位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehousebin
-- ----------------------------
INSERT INTO `warehousebin` VALUES (1, '2024-11-30 14:24:52', 2, 13, 'A1-01-03', '存储库位', '1');
INSERT INTO `warehousebin` VALUES (2, '2024-01-15 09:30:00', 1, 13, 'A1-01-01', '存储库位', '1');
INSERT INTO `warehousebin` VALUES (3, '2024-02-20 14:45:00', 2, 13, 'A1-01-02', '存储库位', '2');
INSERT INTO `warehousebin` VALUES (4, '2024-03-10 08:15:00', 3, 13, 'A1-02-01', '存储库位', '1');
INSERT INTO `warehousebin` VALUES (5, '2024-04-05 11:20:00', 4, 13, 'A1-02-02', '存储库位', '2');
INSERT INTO `warehousebin` VALUES (6, '2024-05-18 16:35:00', 5, 13, 'B1-01-01', '拣货库位', '1');
INSERT INTO `warehousebin` VALUES (7, '2024-06-22 09:50:00', 6, 13, 'B1-01-02', '拣货库位', '2');
INSERT INTO `warehousebin` VALUES (8, '2024-07-12 13:05:00', 7, 13, 'B1-02-01', '拣货库位', '1');
INSERT INTO `warehousebin` VALUES (9, '2024-08-03 10:40:00', 8, 13, 'B1-02-02', '拣货库位', '2');
INSERT INTO `warehousebin` VALUES (10, '2024-09-19 15:25:00', 9, 13, 'C1-01-01', '存储库位', '1');
INSERT INTO `warehousebin` VALUES (11, '2024-10-08 09:10:00', 10, 13, 'C1-01-02', '存储库位', '2');

-- ----------------------------
-- Table structure for warehouserelativeuser
-- ----------------------------
DROP TABLE IF EXISTS `warehouserelativeuser`;
CREATE TABLE `warehouserelativeuser`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT COMMENT '仓库用户主键',
  `CreationTime` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CreatorId` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `UserId` int(11) NULL DEFAULT NULL COMMENT '用户',
  `WarehouseId` int(11) NULL DEFAULT NULL COMMENT '仓库',
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `UserId`(`UserId`) USING BTREE,
  INDEX `WarehouseId`(`WarehouseId`) USING BTREE,
  CONSTRAINT `warehouserelativeuser_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `appuser` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `warehouserelativeuser_ibfk_2` FOREIGN KEY (`WarehouseId`) REFERENCES `warehouse` (`Id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '仓库用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouserelativeuser
-- ----------------------------
INSERT INTO `warehouserelativeuser` VALUES (1, '2024-11-30 14:12:02', 2, 2, 13);
INSERT INTO `warehouserelativeuser` VALUES (3, '2024-11-30 14:14:07', 2, 1, 13);
INSERT INTO `warehouserelativeuser` VALUES (4, '2024-11-30 14:14:12', 2, 1, 12);

SET FOREIGN_KEY_CHECKS = 1;
