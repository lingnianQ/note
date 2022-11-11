/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 8.0.26 : Database - mall_seckill
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mall_seckill` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `mall_seckill`;

/*Table structure for table `seckill_sku` */

DROP TABLE IF EXISTS `seckill_sku`;

CREATE TABLE `seckill_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '表主键',
  `sku_id` bigint DEFAULT NULL COMMENT '秒杀商品sku关联id',
  `spu_id` bigint DEFAULT NULL COMMENT '秒杀商品spu关联id',
  `seckill_stock` int DEFAULT NULL COMMENT '秒杀商品库存数',
  `seckill_price` decimal(10,0) DEFAULT NULL COMMENT '秒杀价钱',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `seckill_limit` int DEFAULT '0' COMMENT '秒杀商品数量限制,最多一个用户可以秒杀的商品个数,如果是0表示没有限制',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `seckill_sku` */

insert  into `seckill_sku`(`id`,`sku_id`,`spu_id`,`seckill_stock`,`seckill_price`,`gmt_create`,`gmt_modified`,`seckill_limit`) values 
(1,1,2,81,1000,'2022-02-22 16:43:09','2022-05-01 18:35:19',1),
(2,2,2,9,800,'2022-02-22 16:43:09','2022-02-28 16:28:42',1);

/*Table structure for table `seckill_spu` */

DROP TABLE IF EXISTS `seckill_spu`;

CREATE TABLE `seckill_spu` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `spu_id` bigint DEFAULT NULL COMMENT '关联商品spuid',
  `list_price` decimal(11,0) DEFAULT NULL COMMENT '列表显示价格',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '秒杀开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '秒杀截止时间',
  `gmt_create` timestamp NULL DEFAULT NULL COMMENT '数据创建时间',
  `gmt_modified` timestamp NULL DEFAULT NULL COMMENT '数据最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `seckill_spu` */

insert  into `seckill_spu`(`id`,`spu_id`,`list_price`,`start_time`,`end_time`,`gmt_create`,`gmt_modified`) values 
(1,2,2000,'2022-03-31 12:05:48','2029-03-01 16:51:42','2022-02-23 16:51:45','2022-02-23 16:51:48');

/*Table structure for table `seckill_success` */

DROP TABLE IF EXISTS `seckill_success`;

CREATE TABLE `seckill_success` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seckill_id` bigint DEFAULT NULL COMMENT '关联秒杀id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `user_phone` varchar(50) DEFAULT NULL COMMENT '手机号码(冗余)',
  `sku_id` bigint DEFAULT NULL COMMENT 'SKU id',
  `title` varchar(255) DEFAULT NULL COMMENT '商品SKU标题（冗余）',
  `main_picture` varchar(255) DEFAULT NULL COMMENT '商品SKU图片URL（第1张）',
  `seckill_price` decimal(10,2) DEFAULT NULL COMMENT '秒杀商品单价(加入时)',
  `quantity` smallint DEFAULT NULL COMMENT '秒杀商品数量',
  `gmt_create` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `gmt_modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据最后修改时间',
  `bar_code` varchar(255) DEFAULT NULL COMMENT '商品条码',
  `data` varchar(2500) DEFAULT NULL COMMENT '销售属性',
  `order_sn` varchar(36) DEFAULT NULL COMMENT '关联订单id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='秒杀成功表格';

/*Data for the table `seckill_success` */

insert  into `seckill_success`(`id`,`seckill_id`,`user_id`,`user_phone`,`sku_id`,`title`,`main_picture`,`seckill_price`,`quantity`,`gmt_create`,`gmt_modified`,`bar_code`,`data`,`order_sn`) values 
(2,NULL,1,NULL,1,'2021年新款，小米11 Ultra黑色512G，16G超大内存120Hz高刷67w快充','picture1',6999.99,10,'2022-02-28 16:17:44','2022-02-28 16:17:44','0','{\"attributes\":[{\"id\":1,\"name\":\"屏幕尺寸\",\"value\":\"6.1寸\"},{\"id\":3,\"name\":\"颜色\",\"value\":\"黑色\"},{\"id\":5,\"name\":\"运行内存\",\"value\":\"16GB\"}]}',NULL),
(3,NULL,1,NULL,2,'2021年新款，小米11 Ultra黑色512G，16G超大内存120Hz高刷67w快充','picture1',6999.99,1,'2022-02-28 16:28:42','2022-02-28 16:28:42','0','{\"attributes\":[{\"id\":1,\"name\":\"屏幕尺寸\",\"value\":\"6.1寸\"},{\"id\":3,\"name\":\"颜色\",\"value\":\"黑色\"},{\"id\":5,\"name\":\"运行内存\",\"value\":\"16GB\"}]}',NULL),
(4,NULL,1,NULL,1,'2021年新款，小米11 Ultra黑色512G，16G超大内存120Hz高刷67w快充','picture1',6999.99,10,'2022-03-31 16:21:39','2022-03-31 16:21:39','0','{\"attributes\":[{\"id\":1,\"name\":\"屏幕尺寸\",\"value\":\"6.1寸\"},{\"id\":3,\"name\":\"颜色\",\"value\":\"黑色\"},{\"id\":5,\"name\":\"运行内存\",\"value\":\"16GB\"}]}',NULL),
(5,NULL,1,NULL,1,'2021年新款，小米11 Ultra黑色512G，16G超大内存120Hz高刷67w快充','picture1',6999.99,10,'2022-05-01 18:19:37','2022-05-01 18:19:37','0','[{\"id\":1,\"name\":\"屏幕尺寸\",\"value\":\"6.1寸\"},{\"id\":3,\"name\":\"颜色\",\"value\":\"黑色\"},{\"id\":5,\"name\":\"运行内存\",\"value\":\"16GB\"}]','01530d12-b61b-4226-896d-302a03e94520'),
(6,NULL,1,NULL,1,'2021年新款，小米11 Ultra黑色512G，16G超大内存120Hz高刷67w快充','picture1',6999.99,10,'2022-05-01 18:35:19','2022-05-01 18:35:19','0','[{\"id\":1,\"name\":\"屏幕尺寸\",\"value\":\"6.1寸\"},{\"id\":3,\"name\":\"颜色\",\"value\":\"黑色\"},{\"id\":5,\"name\":\"运行内存\",\"value\":\"16GB\"}]','c55f2fa3-911a-4cba-b7c6-79809266cbb4');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
