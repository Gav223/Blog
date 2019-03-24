-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: admin123
-- ------------------------------------------------------
-- Server version	5.5.60-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog_admin`
--

DROP TABLE IF EXISTS `blog_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `pw` varchar(100) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  `salt` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_admin`
--

LOCK TABLES `blog_admin` WRITE;
/*!40000 ALTER TABLE `blog_admin` DISABLE KEYS */;
INSERT INTO `blog_admin` VALUES (1,'admin123','e20301cb480f27a4a0100894083c5d45','1550478362','1550478513');
/*!40000 ALTER TABLE `blog_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_admin_role`
--

DROP TABLE IF EXISTS `blog_admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_admin_role`
--

LOCK TABLES `blog_admin_role` WRITE;
/*!40000 ALTER TABLE `blog_admin_role` DISABLE KEYS */;
INSERT INTO `blog_admin_role` VALUES (1,1,1,'1550478362'),(2,1,2,'1550478362');
/*!40000 ALTER TABLE `blog_admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_article`
--

DROP TABLE IF EXISTS `blog_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `content` text NOT NULL,
  `admin_id` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  `cate_id` int(11) NOT NULL,
  `is_top` tinyint(4) DEFAULT '0',
  `image` varchar(200) NOT NULL,
  `description` varchar(50) NOT NULL,
  `page_view` int(11) DEFAULT '0',
  `admin_name` varchar(20) NOT NULL,
  `is_recommended` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article`
--

LOCK TABLES `blog_article` WRITE;
/*!40000 ALTER TABLE `blog_article` DISABLE KEYS */;
INSERT INTO `blog_article` VALUES (1,'PHP设计模式','<p><strong><span>1.单例模式</span></strong></p><p>&nbsp;</p><div><p><span>单例模式顾名思义，就是只有一个实例。</span><span>作为对象的创建模式， 单例模式确保某一个类只有一个实例，而且自行实例化并向整个系统提供这个实例。</span></p><p>&nbsp;</p><div><p><span><strong>单例模式的要点有三个：</strong></span></p><ol><li><span>一是某个类只能有一个实例；</span></li><li><span>二是它必须自行创建这个实例；</span></li><li><span>三是它必须自行向整个系统提供这个实例。</span></li></ol></div><div><strong>为什么要使用PHP单例模式</strong></div><ol><li><span>1. php的应用主要在于</span><span>数据库应用</span><span>, 一个应用中会存在大量的数据库操作, 在使用面向对象的方式开发时, 如果使用单例模式, 则可以避免大量的new 操作消耗的资源,还可以减少数据库连接这样就不容易出现 too many connections情况。</span></li><li><span>2. 如果系统中需要有</span><span>一个类来全局控制某些配置信息</span><span>, 那么使用单例模式可以很方便的实现. 这个可以参看zend Framework的FrontController部分。</span></li><li><span>3. 在一次页面请求中,&nbsp;</span><span>便于进行调试</span><span>, 因为所有的代码(例如数据库操作类db)都集中在一个类中, 我们可以在类中设置钩子, 输出日志，从而避免到处var_dump, echo。</span></li></ol><p>&nbsp;</p><p><span></span></p></div><p><span>&nbsp;例子：</span></p><p>&nbsp;</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><div><span>/*</span><span>*<br>&nbsp;*&nbsp;设计模式之单例模式<br>&nbsp;*&nbsp;$_instance必须声明为静态的私有变量<br>&nbsp;*&nbsp;构造函数必须声明为私有,防止外部程序new类从而失去单例模式的意义<br>&nbsp;*&nbsp;getInstance()方法必须设置为公有的,必须调用此方法以返回实例的一个引用<br>&nbsp;*&nbsp;::操作符只能访问静态变量和静态函数<br>&nbsp;*&nbsp;new对象都会消耗内存<br>&nbsp;*&nbsp;使用场景:最常用的地方是数据库连接。<br>&nbsp;*&nbsp;使用单例模式生成一个对象后，该对象可以被其它众多对象所使用。<br>&nbsp;</span><span>*/</span><br><span>class</span>&nbsp;man<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;<span>//</span><span>保存例实例在此属性中</span><span><br></span>&nbsp;&nbsp;&nbsp;&nbsp;<span>private</span>&nbsp;<span>static</span>&nbsp;<span>$_instance</span>;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;<span>//</span><span>构造函数声明为private,防止直接创建对象</span><span><br></span>&nbsp;&nbsp;&nbsp;&nbsp;<span>private</span>&nbsp;<span>function</span>&nbsp;__construct()<br>&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>echo</span>&nbsp;\'我被实例化了！\';<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;<span>//</span><span>单例方法</span><span><br></span>&nbsp;&nbsp;&nbsp;&nbsp;<span>public</span>&nbsp;<span>static</span>&nbsp;<span>function</span>&nbsp;get_instance()<br>&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>var_dump</span>(<span>isset</span>(self::<span>$_instance</span>));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>if</span>(!<span>isset</span>(self::<span>$_instance</span>))<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;self::<span>$_instance</span>=<span>new</span>&nbsp;self();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>return</span>&nbsp;self::<span>$_instance</span>;<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;<span>//</span><span>阻止用户复制对象实例</span><span><br></span>&nbsp; &nbsp; private&nbsp;<span>function</span>&nbsp;__clone()<br>&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>trigger_error</span>(\'Clone&nbsp;is&nbsp;not&nbsp;allow\'&nbsp;,<span>E_USER_ERROR</span>);<br>&nbsp;&nbsp;&nbsp;&nbsp;}<br><br>&nbsp;&nbsp;&nbsp;&nbsp;<span>function</span>&nbsp;test()<br>&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>echo</span>(\"test\");<br><br>&nbsp;&nbsp;&nbsp;&nbsp;}<br>}<br><br><span>//</span><span>&nbsp;这个写法会出错，因为构造方法被声明为private<br>//$test&nbsp;=&nbsp;new&nbsp;man;<br><br>//&nbsp;下面将得到Example类的单例对象</span><span><br></span><span>$test</span>&nbsp;=&nbsp;man::get_instance();<br><span>$test</span>&nbsp;=&nbsp;man::get_instance();<br><span>$test</span>-&gt;test();<br><br><span>//</span><span>&nbsp;复制对象将导致一个E_USER_ERROR.<br>//$test_clone&nbsp;=&nbsp;clone&nbsp;$test;</span></div><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div>',1,'1550647387',1,0,'http://localhost/tp5/uploads/20190220/dbe0258c7b31a33b7c89c71367e2b9ca.jpeg','设计模式（Design Pattern）是一套被反复使用、多数人知晓的、经过分类的、代码设计经验的总',0,'admin123',1),(2,'PHP常用字符串函数','<pre><span>//获取字符串长度，有多少个字符，空格也算</span>\n<span>$str</span>=\" sdaf sd \"<span>;\n</span><span>$len</span>=<span>strlen</span>(<span>$str</span><span>);\n\n</span><span>//</span><span>用第一个参数里的字符串，把后面数组里的每个元素连接起来，返回一个字符串。</span>\n<span>$str</span>=<span>implode</span>(\"-\",<span>array</span>(\"a\",\"b\",\"c\"<span>));\n\n</span><span>//</span><span>字符串分割方法，返回一个数组，用第一个参数里的字符分割后面的字符串，指定字符的前后和之间都截取，如果指定字符在开头或结尾则返回的数组开头或结尾的元素为空字符串\n//没有分割到字符串就返回给数组对应元素一个空值。最后一个数字限制返回数组长度（最后一次分割后余下的字符串不再分割，作为一个整体放在返回数组的最后一个元素中），可不限制，则一直分割下去。</span>\n<span>$array</span>=<span>explode</span>(\"a\",\"asddad addsadassd dasdadfsdfasdaaa\",2<span>);\n</span><span>//</span><span>print_r($array);\n\n//剔除字符串左边开头的空格,并返回\n//如有第二个参数则是剔除左边开头的空格换成剔除第二个参数里的字符串</span>\n<span>$str</span>=<span>ltrim</span>(\"a asd \",\"a\"<span>);\n\n</span><span>//</span><span>剔除字符串右边开头的空格</span>\n<span>$str</span>=<span>rtrim</span>(\" asd \"<span>);\n\n</span><span>//</span><span>把第一个字符串两边以第二个参数开头的字符串剔除。如没有第二个参数，默认剔除掉字符串两边开头的空格</span>\n<span>$str</span>=<span>trim</span>(\" sdsdfas \",\"a\"<span>);\n\n</span><span>//</span><span>从字符串第一个参数里的指定位置开始取多长（多少个）字符，字符串中第一个字符位置从0算。\n//如果第二个参数为负则从字符串结尾倒数第几个开始取多长的字符串。结尾最后一个字符算-1，截取方向总是从左到右</span>\n<span>$str</span>=<span>substr</span>(\"abcdefgh\",0,4<span>);\n\n\n</span><span>//</span><span>将第三个参数的第一个参数字符串用参数二字符串替换</span>\n<span>$str</span>=<span>str_replace</span>(\"a\",\"\",\"abcabcAbca\"<span>);\n</span><span>//</span><span>与str_replace用法同，只是不区分大小写\n//$str=str_ireplace(\"a\",\" \",\"abcabcAbca\");\n\n//返回括号里字符串的字符全部大写的字符串</span>\n<span>$str</span>=<span>strtoupper</span>(\"sdaf\"<span>);\n\n</span><span>//</span><span>将括号里第一个字符串变成大写后返回</span>\n<span>$str</span>=<span>ucfirst</span>(\"asdf\"<span>);\n\n</span><span>//</span><span>用echo等将括号里字符串打印在网页上时原汁原味打印出括号里的字符串，包括标签字符</span>\n<span>$str</span>=<span>htmlentities</span>(\"&lt;br/&gt;\"<span>);\n\n</span><span>//</span><span>返回第二个参数字符串在第一个字符串里出现的次数</span>\n<span>$int</span>=<span>substr_count</span>(\"abcdeabcdeablkabd\",\"ab\"<span>);\n\n</span><span>//</span><span>返回第二个字符串在第一个字符串第一次出现的位置，第一个字符位置算0</span>\n<span>$int</span>=<span>strpos</span>(\"asagaab\",\"ab\"<span>);\n\n</span><span>//</span><span>返回第二个字符串在第一个字符串最后一次出现的位置，第一个字符位置算0</span>\n<span>$int</span>=<span>strrpos</span>(\"asagaabadfab\",\"ab\"<span>);\n\n</span><span>//</span><span>截取返回参数一中从左至右第一个出现的参数二到参数一最后一个字符的字符串</span>\n<span>$str</span>=<span>strstr</span>(\"sdafsdgaababdsfgs\",\"ab\"<span>);\n\n</span><span>//</span><span>截取返回参数一中从左至右最后一个出现的参数二到参数一最后一个字符的字符串</span>\n<span>$str</span>=<span>strrchr</span>(\"sdafsdgaababdsfgs\",\"ab\"<span>);\n\n</span><span>//</span><span>将参数二中每一个字符在参数一中相同字符前加\"\\\"</span>\n<span>$str</span>=<span>addcslashes</span>(\"abcdefghijklmn\",\"akd\"<span>);\n\n</span><span>//</span><span>将参数一的字符串填充到参数二指定的长度（单字符个数），参数三为指定填充的字符串，不写默认空格\n//参数四填充位置，0在参数一左侧开头填充，1右侧开头，2两边开头同时。不写默认在右侧开头填充</span>\n<span>$str</span>=<span>str_pad</span>(\"abcdefgh\",10,\"at\",0<span>);\n\n</span><span>//</span><span>依次比较两字符串对应字符阿斯克码值，第一对不一样的，如果参数一里大于参数二里的返回1,反之返回-1，两字符串完全一样返回0</span>\n<span>$int1</span>=<span>strcmp</span>(\"b\",\"a\"<span>);\n\n</span><span>//</span><span>返回第一个参数格式化后的数字格式，第二个参数为保留几个小数，参数三为将小数点换成参数三，参数四为整数部分每三位用什么字符分割\n//后面三个参数都不写，则默认去掉小数部分，整数每隔三位用逗号,分割。参数三，参数四必须同时存在</span>\n<span>$str</span>=<span>number_format</span>(1231233.1415,2,\"d\",\"a\"<span>);\n\n</span><span>//</span><span>base64_encode 加密常用语图片和微信 nickname 的编码（因为nickname常有特殊字符做昵称数据库直接保存不了，需用base64_encode编码后保存，使用时再用base64_decode解码），返回的是字符串</span>\n<span>$base64str</span> = <span>base64_encode</span>(\"teststr\"<span>);\n\n</span><span>//</span><span>针对 base64_encode 编码后的字符串进行解码，返回的也是字符串</span>\n<span>$str</span> = <span>base64_decode</span> (<span>$base64str</span><span>);</span></pre>',1,'1550647562',1,0,'http://localhost/tp5/uploads/20190220/95706a27a64ef7e42d4cf63c44c25c62.jpg','总结常用的php字符串函数,方便查看',1,'admin123',1),(3,'PHP面向对象-多态','<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/giantpanda/archive/2012/11/10/2763998.html\">PHP面向对象——多态</a></h1><div class=\"clear\"></div><div class=\"postBody\"><div id=\"cnblogs_post_body\" class=\"blogpost-body\"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 多态是指在面向对象中能够根据使用类的上下文来重新定义或改变类的性质和行为。&nbsp;&nbsp;&nbsp;&nbsp;</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHP不支持重载实现多态，但是PHP可以变向的实现多态效果。如下:</p><div class=\"cnblogs_code\"><pre><span>class</span><span> a{\n    </span><span>function</span> test(<span>$i</span>){ <span>//</span><span> $i可以是任何类型的变量</span>\n        <span>print_r</span> <span>$i</span><span>;\n    }\n}</span></pre></div><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 上例，可以看出由于PHP是弱类型语言，所以$i可以是任何类型的变量，这样一个函数就可以实现如java等强类型语言中靠改变参数类型重载方法的多态形式。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 这种形式比JAVA的参数类型重载更便捷高效，但也存在问题，如下：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>&lt;?<span>php\n</span><span>/*</span><span>*\n教师类有一个drawPolygon()方法需要一个Polygon类，用来画多边形，此方法内部调用多边形的draw()方法，但由于弱类型，我们可以传入Circle类，就会调用Circle类的draw方法，这就事与愿违了。甚至可以传入阿猫、阿狗类，如果这些类没有draw()方法还会报错。\n</span><span>*/</span>\n<span>class</span><span> Teacher{\n    </span><span>function</span> drawPolygon(<span>$polygon</span><span>){ \n        </span><span>$polygon</span>-&gt;<span>draw(); \n    }    \n}\n\n</span><span>class</span><span> Polygon{\n    </span><span>function</span><span> draw(){\n        </span><span>echo</span> \"draw a polygon\"<span>;\n    }\n}\n\n</span><span>class</span><span> Circle{\n    </span><span>function</span><span> draw(){\n        </span><span>echo</span> \"draw a circle\"<span>;\n    }\n}\n</span>?&gt;</pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 可以看出这样灵活的多态，需要一些控制，在PHP5.3以后可以对参数做类型限制，如下：</p><div class=\"cnblogs_code\"><pre><span>//</span><span> 仿java，在变量参数前加一个限制类名</span>\n    <span>function</span> drawPolygon(Polygon <span>$polygon</span><span>){ \n        </span><span>$polygon</span>-&gt;<span>draw(); \n    }</span></pre></div><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 这样就限制了只能传入Polygon及其子类。</p><p>&nbsp;&nbsp;&nbsp;&nbsp; 还有一只是改变参数数量的重载，同样是因为PHP也不支持方法的重载，所以也需要些变通的方法实现，如下：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>&lt;?<span>php\n</span><span>//</span><span> 通过可变参数来达到改变参数数量重载的目的\n// 不是必须传入的参数，必须在函数定义时赋初始值</span>\n<span>function</span> open_database(<span>$DB</span>, <span>$cache_size_or_values</span>=<span>null</span>, <span>$cache_size</span>=<span>null</span><span>)\n{\n    </span><span>switch</span> (function_num_args())  <span>//</span><span> 通过function_num_args()函数计算传入参数的个数，根据个数来判断接下来的操作</span>\n<span>    {\n        </span><span>case</span> 1:\n            <span>$r</span> = select_db(<span>$DB</span><span>);\n            </span><span>break</span><span>;\n        </span><span>case</span> 2:\n            <span>$r</span> = select_db(<span>$DB</span>, <span>$cache_size_or_values</span><span>);\n            </span><span>break</span><span>;\n        </span><span>case</span> 3:\n            <span>$r</span> = select_db(<span>$DB</span>, <span>$cache_size_or_values</span>, <span>$cache_size</span><span>);\n            </span><span>break</span><span>;\n    }\n    </span><span>return</span> <span>is_resource</span>(<span>$r</span><span>);\n}\n</span>?&gt;</pre></div></div></div>',1,'1550647737',1,0,'http://localhost/tp5/uploads/20190220/43983cb042ce0fc3cd240c7959a69b13.jpeg','面向对象(Object Oriented,OO)是软件开发方法。面向对象的概念和应用已超越了程序设计',0,'admin123',1),(4,'PHP面向对象-封装','<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/bilibiliganbei/p/5561592.html\">php 面向对象之封装</a></h1><div class=\"clear\"></div><div class=\"postBody\"><div id=\"cnblogs_post_body\" class=\"blogpost-body\"><p><img src=\"https://images2015.cnblogs.com/blog/895074/201606/895074-20160605200147492-1671836814.png\" alt=\"\"></p><p><img src=\"https://images2015.cnblogs.com/blog/895074/201606/895074-20160605200155914-1399281727.png\" alt=\"\"></p><div class=\"cnblogs_code\"><img id=\"code_img_opened_032a32b3-e725-4aa2-ada8-ee22252d0cda\" class=\"code_img_opened\" src=\"https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif\" alt=\"\"><div id=\"cnblogs_code_open_032a32b3-e725-4aa2-ada8-ee22252d0cda\" class=\"cnblogs_code_hide\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>&lt;body&gt;\n&lt;?<span>php\n</span><span>//</span><span>类的概念\n//对象的概念\n//定义类\n//class Ren\n//{\n    //成员变量\n    //成员方法\n//}\n//造对象\n//$r = new Ren();\n//调用对象的成员$r-&gt;\n\n//面向对象三大特性：封装，继承，多态\n\n//1.封装\n//目的：让类更加的安全。做法：不让外界直接访问类的成员\n\n//具体做法：\n//1.成员变为私有:访问修饰符（public private protected）\n//2.造成员方法来操作变量\n\n//3.使用类里面提供的__get()和__set()方法</span>\n\n<span>class</span><span> Ren\n{\n    </span><span>private</span> <span>$age</span>; <span>//</span><span>私有成员</span>\n    <span>private</span> <span>$name</span><span>;\n    </span><span>private</span> <span>$sex</span><span>;\n    \n    </span><span>//</span><span>构造函数：在造对象的时候，对成员变量进行初始化\n    //1.执行时间特殊：造对象的时候就自动执行\n    //2.写法特殊:__construct</span>\n    \n    <span>function</span> __construct(<span>$s</span><span>)\n    {\n        </span><span>$this</span>-&gt;sex = <span>$s</span><span>;\n    }\n    \n    </span><span>//</span><span>造方法去给变量$age赋值</span>\n    <span>/*</span><span>public function SetAge($a)\n    {\n        if($a&gt;18 and $a&lt;50)\n        {\n            $this-&gt;age = $a;\n        }\n    }\n    //取值\n    function GetAge()\n    {\n        return $this-&gt;age;\n    }</span><span>*/</span>\n    \n    \n    \n    <span>//</span><span>变量赋值的方法</span>\n    <span>function</span> __set(<span>$n</span>,<span>$v</span><span>)\n    {\n        </span><span>if</span>(<span>$n</span>==\"age\"<span>)\n        {\n            </span><span>if</span>(<span>$v</span>&gt;18 and <span>$v</span>&lt;50<span>)\n            {\n                </span><span>$this</span>-&gt;<span>$n</span> = <span>$v</span><span>;\n            }\n        }\n        </span><span>else</span><span>\n        {\n            </span><span>$this</span>-&gt;<span>$n</span> = <span>$v</span><span>;\n        }\n    }\n    </span><span>//</span><span>取值方法</span>\n    <span>function</span> __get(<span>$n</span><span>)\n    {\n        </span><span>return</span> <span>$this</span>-&gt;<span>$n</span><span>;\n    }\n    \n    \n}\n\n</span><span>$r</span> = <span>new</span> Ren(\"男\"<span>);\n\n</span><span>$r</span>-&gt;name = \"张三\"<span>;\n\n\n</span><span>var_dump</span>(<span>$r</span><span>);\n\n\n</span><span>//</span><span>设计一个类：包含$a,$b，求和的方法,求乘积的方法，可以对变量进行初始化，$a,$b必须大于0小于100</span>\n\n\n\n\n\n\n\n\n?&gt;\n&lt;/body&gt;</pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div></div></div></div>',1,'1550647899',1,0,'http://localhost/tp5/uploads/20190220/862a21bd36ebdd33ada461dc1266b028.png','面向对象(Object Oriented,OO)是软件开发方法。面向对象的概念和应用已超越了程序设计',1,'admin123',1),(5,'乐观锁&悲观锁','<p>悲观锁与乐观锁是两种常见的资源并发锁设计思路，也是并发编程中一个非常基础的概念。本文将对这两种常见的锁机制在数据库数据上的实现进行比较系统的介绍。</p><h4>悲观锁（Pessimistic Lock）</h4><hr><p>悲观锁的特点是先获取锁，再进行业务操作，即“悲观”的认为获取锁是非常有可能失败的，因此要先确保获取锁成功再进行业务操作。<span>通常所说的“一锁二查三更新”即指的是使用悲观锁。通常来讲在数据库上的悲观锁需要数据库本身提供支持，即通过常用的select … for update操作来实现悲观锁。</span>当数据库执行select for update时会获取被select中的数据行的行锁，因此其他并发执行的select for update如果试图选中同一行则会发生排斥（需要等待行锁被释放），因此达到锁的效果。select for update获取的行锁会在当前事务结束时自动释放，因此必须在事务中使用。</p><p>这里需要注意的一点是不同的数据库对select for update的实现和支持都是有所区别的，例如oracle支持select for update no wait，表示如果拿不到锁立刻报错，而不是等待，mysql就没有no wait这个选项。另外<span>mysql还有个问题是select for update语句执行中所有扫描过的行都会被锁上，这一点很容易造成问题。因此如果在mysql中用悲观锁务必要确定走了索引，而不是全表扫描。</span></p><h4>乐观锁（Optimistic Lock）</h4><hr><p>乐观锁的特点先进行业务操作，不到万不得已不去拿锁。即“乐观”的认为拿锁多半是会成功的，因此在进行完业务操作需要实际更新数据的最后一步再去拿一下锁就好。</p><p>乐观锁在数据库上的实现完全是逻辑的，不需要数据库提供特殊的支持。一般的做法是在需要锁的数据上增加一个版本号，或者时间戳，然后按照如下方式实现：</p><div class=\"codehilite\"><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre><span>1</span><span>. SELECT data AS old_data, version AS old_version FROM …;\n</span><span>2</span><span>. 根据获取的数据进行业务操作，得到new_data和new_version\n</span><span>3</span>. UPDATE SET data = new_data, version = new_version WHERE version =<span> old_version\n</span><span>if</span> (updated row &gt; <span>0</span><span>) {\n    </span><span>//</span><span> 乐观锁获取成功，操作完成</span>\n} <span>else</span><span> {\n    </span><span>//</span><span> 乐观锁获取失败，回滚并重试</span>\n}</pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div></div><p>乐观锁是否在事务中其实都是无所谓的，其底层机制是这样：在数据库内部update同一行的时候是不允许并发的，即数据库每次执行一条update语句时会获取被update行的写锁，直到这一行被成功更新后才释放。因此在业务操作进行前获取需要锁的数据的当前版本号，然后实际更新数据时再次对比版本号确认与之前获取的相同，并更新版本号，即可确认这之间没有发生并发的修改。如果更新失败即可认为老版本的数据已经被并发修改掉而不存在了，此时认为获取锁失败，需要回滚整个业务操作并可根据需要重试整个过程。</p><h4>总结</h4><ul><li><p>乐观锁在不发生取锁失败的情况下开销比悲观锁小，但是一旦发生失败回滚开销则比较大，因此适合用在取锁失败概率比较小的场景，可以提升系统并发性能</p></li><li><p>乐观锁还适用于一些比较特殊的场景，例如在业务操作过程中无法和数据库保持连接等悲观锁无法适用的地方</p></li></ul><p>参考资料&nbsp;<a href=\"http://dev.mysql.com/doc/refman/5.6/en/internal-locking.html\">Internal Locking Methods</a></p>',1,'1550648117',2,0,'http://localhost/tp5/uploads/20190220/d3b43f5331bea1f6a59230a24e2509be.jpeg','悲观锁与乐观锁是两种常见的资源并发锁设计思路，也是并发编程中一个非常基础的概念。本文将对这两种常见的',0,'admin123',1),(6,'使用MySql乐观锁解决并发问题','<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/laoyeye/p/8097684.html\">使用mysql乐观锁解决并发问题</a></h1><div class=\"clear\"></div><div class=\"postBody\"><div id=\"cnblogs_post_body\" class=\"blogpost-body\"><h1><span>案例说明：</span></h1><p>银行两操作员同时操作同一账户。<br>比如A、B操作员同时读取一余额为1000元的账户，A操作员为该账户增加100元，B操作员同时为该账户扣除50元，A先提交，B后提交。最后实际账户余额为1000-50=950元，但本该为1000+100-50=1050。这就是典型的并发问题。</p><p>乐观锁机制在一定程度上解决了这个问题。乐观锁，大多是基于数据版本(Version)记录机制实现。何谓数据版本？即为数据增加一个版本标识，在基于数据库表的版本解决方案中，一般是通过为数据库表增加一个 “version” 字段来实现。</p><p>读取出数据时，将此版本号一同读出，之后更新时，对此版本号加一。此时，将提交数据的版本数据与数据库表对应记录的当前版本信息进行比对，如果提交的数据版本号大于数据库表当前版本号，则予以更新，否则认为是过期数据。</p><p>对于上面修改用户帐户信息的例子而言，假设数据库中帐户信息表中有一个version字段，当前值为1；而当前帐户余额字段(balance)为1000元。假设操作员A先更新完，操作员B后更新。<br>a、操作员A此时将其读出(version=1)，并从其帐户余额中增加100(1000+100=1100)。<br>b、在操作员A操作的过程中，操作员B也读入此用户信息(version=1)，并从其帐户余额中扣除50(1000-50=950)。<br>c、操作员A完成了修改工作，将数据版本号加一(version=2)，连同帐户增加后余额(balance=1100)，提交至数据库更新，此时由于提交数据版本大于数据库记录当前版本，数据被更新，数据库记录version更新为2。<br>d、操作员B完成了操作，也将版本号加一(version=2)试图向数据库提交数据(balance=950)，但此时比对数据库记录版本时发现，操作员B提交的数据版本号为2，数据库记录当前版本也为2，不满足 “提交版本必须大于记录当前版本才能执行更新 “的乐观锁策略，因此，操作员B的提交被驳回。<br>这样，就避免了操作员B用基于version=1的旧数据修改的结果覆盖操作员A的操作结果的可能。</p><h1><strong>乐观锁介绍：</strong></h1><p>乐观锁（ Optimistic Locking ） 相对悲观锁而言，乐观锁假设认为数据一般情况下不会造成冲突，所以在数据进行提交更新的时候，才会正式对数据的冲突与否进行检测，如果发现冲突了，则让返回用户错误的信息，让用户决定如何去做。那么我们如何实现乐观锁呢，一般来说有以下2种方式：</p><p><strong>1、使用版本号实现乐观锁</strong></p><p><strong>版本号的实现方式有两种，一个是数据版本机制，一个是时间戳机制。具体如下。</strong></p><p>a.使用数据版本（Version）记录机制实现，这是乐观锁最常用的一种实现方式。何谓数据版本？即为数据增加一个版本标识，一般是通过为数据库表增加一个数字类型的 “version” 字段来实现。当读取数据时，将version字段的值一同读出，数据每更新一次，对此version值加一。当我们提交更新的时候，判断数据库表对应记录的当前版本信息与第一次取出来的version值进行比对，如果数据库表当前版本号与第一次取出来的version值相等，则予以更新，否则认为是过期数据。用下面的一张图来说明：</p><p><img src=\"https://images2017.cnblogs.com/blog/1075594/201712/1075594-20171224120703021-326642906.png\" alt=\"\"></p><p>如上图所示，如果更新操作顺序执行，则数据的版本（version）依次递增，不会产生冲突。但是如果发生有不同的业务操作对同一版本的数据进行修改，那么，先提交的操作（图中B）会把数据version更新为2，当A在B之后提交更新时发现数据的version已经被修改了，那么A的更新操作会失败。</p><p>b.时间戳机制，同样是在需要乐观锁控制的table中增加一个字段，名称无所谓，字段类型使用时间戳（timestamp）, 和上面的version类似，也是在更新提交的时候检查当前数据库中数据的时间戳和自己更新前取到的时间戳进行对比，如果一致则OK，否则就是版本冲突。</p><p><strong>2、使用条件限制实现乐观锁</strong></p><p>这个适用于只更新是做数据安全校验，适合库存模型，扣份额和回滚份额，性能更高。这种模式也是目前我用来锁产品库存的方法，十分方便实用。</p><h1><strong>使用版本号实现乐观锁</strong></h1><p>还是拿之前的实例来举：商品goods表中有一个字段status，status为1代表商品未被下单，status为2代表商品已经被下单，那么我们对某个商品下单时必须确保该商品status为1。假设商品的id为1。</p><p>&nbsp;</p><p>下单操作包括3步骤：</p><p>1.查询出商品信息</p><p>select (status,status,version) from t_goods where id=#{id}</p><p>2.根据商品信息生成订单</p><p>3.修改商品status为2</p><p>update t_goods&nbsp;</p><p>set status=2,version=version+1</p><p>where id=#{id}&nbsp;and version=#{version};</p><p>&nbsp;</p><p>那么为了使用乐观锁，我们首先修改t_goods表，增加一个version字段，数据默认version值为1。</p><p>t_goods表初始数据如下：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>mysql<span>&gt;</span> <span>select</span> <span>*</span> <span>from</span><span> t_goods;  \n</span><span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span> id <span>|</span> status <span>|</span> name <span>|</span> version <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span>  <span>1</span> <span>|</span>      <span>1</span> <span>|</span> 道具 <span>|</span>       <span>1</span> <span>|</span>  \n<span>|</span>  <span>2</span> <span>|</span>      <span>2</span> <span>|</span> 装备 <span>|</span>       <span>2</span> <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>2</span> rows <span>in</span> <span>set</span><span>  \n  \nmysql</span><span>&gt;</span>  </pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>对于乐观锁的实现，我使用MyBatis来进行实践，具体如下：</p><p>Goods实体类：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre><span>/**</span><span> \n * ClassName: Goods &lt;br/&gt; \n * Function: 商品实体. &lt;br/&gt; \n * date: 2013-5-8 上午09:16:19 &lt;br/&gt; \n * </span><span>@author</span><span> chenzhou1025@126.com \n </span><span>*/</span>  \n<span>public</span> <span>class</span> Goods <span>implements</span><span> Serializable {  \n  \n    </span><span>/**</span><span> \n     * serialVersionUID:序列化ID. \n     </span><span>*/</span>  \n    <span>private</span> <span>static</span> <span>final</span> <span>long</span> serialVersionUID = 6803791908148880587L<span>;  \n      \n    </span><span>/**</span><span> \n     * id:主键id. \n     </span><span>*/</span>  \n    <span>private</span> <span>int</span><span> id;  \n      \n    </span><span>/**</span><span> \n     * status:商品状态：1未下单、2已下单. \n     </span><span>*/</span>  \n    <span>private</span> <span>int</span><span> status;  \n      \n    </span><span>/**</span><span> \n     * name:商品名称. \n     </span><span>*/</span>  \n    <span>private</span><span> String name;  \n      \n    </span><span>/**</span><span> \n     * version:商品数据版本号. \n     </span><span>*/</span>  \n    <span>private</span> <span>int</span><span> version;  \n      \n    @Override  \n    </span><span>public</span><span> String toString(){  \n        </span><span>return</span> \"good id:\"+id+\",goods status:\"+status+\",goods name:\"+name+\",goods version:\"+<span>version;  \n    }  \n  \n    </span><span>//</span><span>setter and getter  </span>\n<span>  \n}  </span></pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>GoodsDao</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre><span>/**</span><span> \n * updateGoodsUseCAS:使用CAS(Compare and set)更新商品信息. &lt;br/&gt; \n * \n * </span><span>@author</span><span> chenzhou1025@126.com \n * </span><span>@param</span><span> goods 商品对象 \n * </span><span>@return</span><span> 影响的行数 \n </span><span>*/</span>  \n<span>int</span> updateGoodsUseCAS(Goods goods);  </pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>mapper.xml</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre><span>&lt;</span><span>update </span><span>id</span><span>=\"updateGoodsUseCAS\"</span><span> parameterType</span><span>=\"Goods\"</span><span>&gt;</span>  \n    <span>&lt;![CDATA[</span><span> \n        update t_goods \n        set status=#{status},name=#{name},version=version+1 \n        where id=#{id} and version=#{version} \n    </span><span>]]&gt;</span>  \n<span>&lt;/</span><span>update</span><span>&gt;</span>  </pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>GoodsDaoTest测试类</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre><span>@Test  \n</span><span>public</span> <span>void</span><span> goodsDaoTest(){  \n    </span><span>int</span> goodsId = 1<span>;  \n    </span><span>//</span><span>根据相同的id查询出商品信息，赋给2个对象  </span>\n    Goods goods1 = <span>this</span><span>.goodsDao.getGoodsById(goodsId);  \n    Goods goods2 </span>= <span>this</span><span>.goodsDao.getGoodsById(goodsId);  \n      \n    </span><span>//</span><span>打印当前商品信息  </span>\n<span>    System.out.println(goods1);  \n    System.out.println(goods2);  \n      \n    </span><span>//</span><span>更新商品信息1  </span>\n    goods1.setStatus(2);<span>//</span><span>修改status为2  </span>\n    <span>int</span> updateResult1 = <span>this</span><span>.goodsDao.updateGoodsUseCAS(goods1);  \n    System.out.println(</span>\"修改商品信息1\"+(updateResult1==1?\"成功\":\"失败\"<span>));  \n      \n    </span><span>//</span><span>更新商品信息2  </span>\n    goods1.setStatus(2);<span>//</span><span>修改status为2  </span>\n    <span>int</span> updateResult2 = <span>this</span><span>.goodsDao.updateGoodsUseCAS(goods2);  \n    System.out.println(</span>\"修改商品信息2\"+(updateResult2==1?\"成功\":\"失败\"<span>));  \n}  </span></pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>输出结果：</p><div class=\"cnblogs_code\"><pre><span>good id:1,goods status:1,goods name:道具,goods version:1  \ngood id:1,goods status:1,goods name:道具,goods version:1  \n修改商品信息1成功  \n修改商品信息2失败  </span></pre></div><p>说明：</p><p>在GoodsDaoTest测试方法中，我们同时查出同一个版本的数据，赋给不同的goods对象，然后先修改good1对象然后执行更新操作，执行成功。然后我们修改goods2，执行更新操作时提示操作失败。此时t_goods表中数据如下：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>mysql<span>&gt;</span> <span>select</span> <span>*</span> <span>from</span><span> t_goods;  \n</span><span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span> id <span>|</span> status <span>|</span> name <span>|</span> version <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span>  <span>1</span> <span>|</span>      <span>2</span> <span>|</span> 道具 <span>|</span>       <span>2</span> <span>|</span>  \n<span>|</span>  <span>2</span> <span>|</span>      <span>2</span> <span>|</span> 装备 <span>|</span>       <span>2</span> <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>2</span> rows <span>in</span> <span>set</span><span>  \n  \nmysql</span><span>&gt;</span>  </pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>我们可以看到 id为1的数据version已经在第一次更新时修改为2了。所以我们更新good2时update where条件已经不匹配了，所以更新不会成功，具体sql如下：</p><div class=\"cnblogs_code\"><pre><span>update</span><span> t_goods   \n</span><span>set</span> status<span>=</span><span>2</span>,version<span>=</span>version<span>+</span><span>1</span>  \n<span>where</span> id<span>=</span>#{id} <span>and</span> version<span>=</span>#{version};  </pre></div><p><span><strong>这样我们就用版本号实现了乐观锁</strong></span></p><p>其实这种版本号的方法并不是适用于所有的乐观锁场景。举个例子，当电商抢购活动时，大量并发进入，如果仅仅使用版本号或者时间戳，就会出现大量的用户查询出库存存在，但是却在扣减库存时失败了，而这个时候库存是确实存在的。想象一下，版本号每次只会有一个用户扣减成功，不可避免的人为造成失败。这种时候就需要我们的第二种场景的乐观锁方法。</p><h1><strong>使用条件限制实现乐观锁</strong></h1><p>同样以上述案例为例。将表结构修改如下：</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>mysql<span>&gt;</span> <span>select</span> <span>*</span> <span>from</span><span> t_goods;  \n</span><span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span> id <span>|</span> status <span>|</span> name <span>|</span>    num  <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\n<span>|</span>  <span>1</span> <span>|</span>      <span>1</span> <span>|</span> 道具 <span>|</span>      <span>10</span> <span>|</span>  \n<span>|</span>  <span>2</span> <span>|</span>      <span>2</span> <span>|</span> 装备 <span>|</span>      <span>10</span> <span>|</span>  \n<span>+</span><span>--</span><span>--+--------+------+---------+  </span>\nrows <span>in</span> <span>set</span><span>  \n  \nmysql</span><span>&gt;</span></pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>status表示产品状态：1、在售。2、暂停出售。 num表示产品库存</p><p>更新库存操作如下：</p><div class=\"cnblogs_code\"><pre><span>UPDATE</span><span> t_goods\n</span><span>SET</span> num <span>=</span> num <span>-</span><span> #{buyNum} \n</span><span>WHERE</span><span>\n    id </span><span>=</span><span> #{id} \n</span><span>AND</span> num <span>-</span> #{buyNum} <span>&gt;=</span> <span>0</span> \n<span>AND</span> STATUS <span>=</span> <span>1</span></pre></div><p>说明：num-#{buyNum}&gt;=0 ，这个情景适合不用版本号，只更新是做数据安全校验，适合库存模型，扣份额和回滚份额，性能更高。这种模式也是目前我用来锁产品库存的方法，十分方便实用。</p><p><span><strong>注意：乐观锁的更新操作，最好用主键或者唯一索引来更新,这样是行锁，否则更新时会锁表</strong></span></p><p>以上就是我对MySQL乐观锁的总结和实践，写得比较浅显，有不对的地方欢迎拍砖</p><p>&nbsp;参考来源：</p><p>https://www.cnblogs.com/linjiqin/p/5096206.html</p><p>http://blog.csdn.net/liyantianmin/article/details/50752102</p></div></div>',1,'1550648189',2,0,'http://localhost/tp5/uploads/20190220/e1ecac3920bc1d79a8e343b3bdf7ca42.jpeg','乐观锁，大多是基于数据版本(Version)记录机制实现。何谓数据版本？即为数据增加一个版本标识，在',1,'admin123',1),(7,'MySql命令大全','<h1 align=\"center\">1、连接Mysql</h1><div id=\"comment\">格式： mysql -h主机地址 -u用户名 －p用户密码<br><br><strong>1、连接到本机上的MYSQL。</strong><br>首先打开DOS窗口，然后进入目录mysql\\bin，再键入命令mysql -u root -p，回车后提示你输密码.注意用户名前可以有空格也可以没有空格，但是密码前必须没有空格，否则让你重新输入密码。<br><br>如果刚安装好MYSQL，超级用户root是没有密码的，故直接回车即可进入到MYSQL中了，MYSQL的提示符是： mysql&gt;<br><br><strong>2、连接到远程主机上的MYSQL。</strong>假设远程主机的IP为：110.110.110.110，用户名为root,密码为abcd123。则键入以下命令：<br>&nbsp;&nbsp;&nbsp; mysql -h110.110.110.110 -u root -p 123;（注:u与root之间可以不用加空格，其它也一样）<br><br><strong>3、退出MYSQL命令</strong>： exit （回车）</div><div>&nbsp;</div><div><h1 align=\"center\">2、修改密码</h1><div id=\"comment\">格式：mysqladmin -u用户名 -p旧密码 password 新密码<br><br><strong>1、给root加个密码ab12。</strong><br>首先在DOS下进入目录mysql\\bin，然后键入以下命令<br>&nbsp;&nbsp;&nbsp; mysqladmin -u root -password ab12<br>注：因为开始时root没有密码，所以-p旧密码一项就可以省略了。<br><br><strong>2、再将root的密码改为djg345。</strong><br>&nbsp;&nbsp;&nbsp; mysqladmin -u root -p ab12 password djg345</div><div><h1 align=\"center\">3、增加新用户</h1><div id=\"comment\">注意：和上面不同，下面的因为是MYSQL环境中的命令，所以后面都带一个分号作为命令结束符<br><br>格式：grant select on 数据库.* to 用户名@登录主机 identified by “密码”<br><br><strong>1、增加一个用户test1密码为abc，让他可以在任何主机上登录，并对所有数据库有查询、插入、修改、删除的权限。首先用root用户连入MYSQL，然后键入以下命令：</strong><br>&nbsp;&nbsp;&nbsp; grant select,insert,update,delete on *.* to [email=test1@”%]test1@”%[/email]” Identified by “abc”;<br><br>但增加的用户是十分危险的，你想如某个人知道test1的密码，那么他就可以在internet上的任何一台电脑上登录你的mysql数据库并对你的数据可以为所欲为了，解决办法见2。<br><br><strong>2、增加一个用户test2密码为abc,让他只可以在localhost上登录，并可以对数据库mydb进行查询、插入、修改、删除的操作（localhost指本地主机，即MYSQL数据库所在的那台主机）</strong>，这样用户即使用知道test2的密码，他也无法从internet上直接访问数据库，只能通过MYSQL主机上的web页来访问了。<br>&nbsp;&nbsp;&nbsp; grant select,insert,update,delete on mydb.* to [email=test2@localhost]test2@localhost[/email] identified by “abc”;<br><br>如果你不想test2有密码，可以再打一个命令将密码消掉。<br>&nbsp;&nbsp;&nbsp; grant select,insert,update,delete on mydb.* to [email=test2@localhost]test2@localhost[/email] identified by “”;</div><div>&nbsp;</div><div><h1 align=\"center\">4.1 创建数据库</h1><div id=\"comment\">注意：创建数据库之前要先连接Mysql服务器<br><br>命令：create database &lt;数据库名&gt;<br><br><strong>例1：建立一个名为xhkdb的数据库</strong><br>&nbsp; &nbsp;mysql&gt; create database xhkdb;<br><br><strong>例2：创建数据库并分配用户</strong><br><br>①CREATE DATABASE 数据库名;<br><br>②GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON 数据库名.* TO 数据库名@localhost IDENTIFIED BY \'密码\';<br><br>③SET PASSWORD FOR&nbsp;\'数据库名\'@\'localhost\' = OLD_PASSWORD(\'密码\');<br><br>依次执行3个命令完成数据库创建。注意：中文 “密码”和“数据库”是户自己需要设置的。</div><div><h1 align=\"center\">4.2 显示数据库</h1><div id=\"comment\">命令：show databases （注意：最后有个s）<br>mysql&gt; show databases;<br><br>注意：为了不再显示的时候乱码，要修改数据库默认编码。以下以GBK编码页面为例进行说明：<br><br><strong>1、修改MYSQL的配置文件：</strong>my.ini里面修改default-character-set=gbk<br><strong>2、代码运行时修改：</strong><br>&nbsp; &nbsp;①Java代码：jdbc:mysql://localhost:3306/test?useUnicode=true&amp;characterEncoding=gbk<br>&nbsp; &nbsp;②PHP代码：header(\"Content-Type:text/html;charset=gb2312\");<br>&nbsp; &nbsp;③C语言代码：int mysql_set_character_set( MYSQL * mysql, char * csname)；<br>该函数用于为当前连接设置默认的字符集。字符串csname指定了1个有效的字符集名称。连接校对成为字符集的默认校对。该函数的工作方式与SET NAMES语句类似，但它还能设置mysql- &gt; charset的值，从而影响了由mysql_real_escape_string() 设置的字符集。</div><div><h1 align=\"center\">4.3 删除数据库</h1><div id=\"comment\">命令：drop database &lt;数据库名&gt;<br>例如：删除名为 xhkdb的数据库<br>mysql&gt; drop database xhkdb;<br><br>例子1：删除一个已经确定存在的数据库<br>&nbsp; &nbsp;mysql&gt; drop database drop_database;<br>&nbsp; &nbsp;Query OK, 0 rows affected (0.00 sec)<br><br>例子2：删除一个不确定存在的数据库<br>&nbsp; &nbsp;mysql&gt; drop database drop_database;<br>&nbsp; &nbsp;ERROR 1008 (HY000): Can\'t drop database \'drop_database\'; database doesn\'t exist<br>&nbsp; &nbsp; &nbsp; //发生错误，不能删除\'drop_database\'数据库，该数据库不存在。<br>&nbsp; &nbsp;mysql&gt; drop database if exists drop_database;<br>&nbsp; &nbsp;Query OK, 0 rows affected, 1 warning (0.00 sec)//产生一个警告说明此数据库不存在<br>&nbsp; &nbsp;mysql&gt; create database drop_database;<br>&nbsp; &nbsp;Query OK, 1 row affected (0.00 sec)<br>&nbsp; &nbsp;mysql&gt; drop database if exists drop_database;//if exists 判断数据库是否存在，不存在也不产生错误<br>&nbsp; &nbsp;Query OK, 0 rows affected (0.00 sec)</div><div><h1 align=\"center\">4.4 连接数据库</h1><div id=\"comment\">命令： use &lt;数据库名&gt;<br><br>例如：如果xhkdb数据库存在，尝试存取它：<br>&nbsp; &nbsp;mysql&gt; use xhkdb;<br>屏幕提示：Database changed<br><br><strong>use 语句可以通告MySQL把db_name数据库作为默认（当前）数据库使用，用于后续语句。</strong>该数据库保持为默认数据库，直到语段的结尾，或者直到发布一个不同的USE语句：<br>&nbsp; &nbsp;mysql&gt; USE db1;<br>&nbsp; &nbsp;mysql&gt; SELECT COUNT(*) FROM mytable;&nbsp;&nbsp; # selects from db1.mytable<br>&nbsp; &nbsp;mysql&gt; USE db2;<br>&nbsp; &nbsp;mysql&gt; SELECT COUNT(*) FROM mytable;&nbsp;&nbsp; # selects from db2.mytable<br><br><strong>使用USE语句为一个特定的当前的数据库做标记，不会阻碍您访问其它数据库中的表。</strong>下面的例子可以从db1数据库访问作者表，并从db2数据库访问编辑表：<br>&nbsp; &nbsp;mysql&gt; USE db1;<br>&nbsp; &nbsp;mysql&gt; SELECT author_name,editor_name FROM author,db2.editor<br>&nbsp; &nbsp; &nbsp; &nbsp;-&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WHERE author.editor_id = db2.editor.editor_id;<br><br>USE语句被设立出来，用于与Sybase相兼容。<br><br>有些网友问到，连接以后怎么退出。其实，不用退出来，use 数据库后，使用show databases就能查询所有数据库，如果想跳到其他数据库，用<br>&nbsp; &nbsp;use 其他数据库名字<br>就可以了。</div></div></div></div></div></div></div>',1,'1550648286',2,0,'http://localhost/tp5/uploads/20190220/ad7ad4270987a2eecbdf530d152f4367.jpeg','因为图形界面的方便导致很多程序员都抛弃了mysql的命令行模式',4,'admin123',1),(8,'MySql性能优化','<h2>Mysql数据库的优化技术</h2><p>对mysql优化是一个综合性的技术，主要包括</p><ul><li>表的设计合理化(符合3NF)</li><li>添加适当索引(index) [四种: 普通索引、主键索引、唯一索引unique、全文索引]</li><li>分表技术(水平分割、垂直分割)</li><li>读写[写: update/delete/add]分离</li><li>存储过程 [模块化编程，可以提高速度]</li><li>对mysql配置优化 [配置最大并发数my.ini, 调整缓存大小 ]</li><li>mysql服务器硬件升级</li><li>定时的去清除不需要的数据,定时进行碎片整理(MyISAM)</li></ul><h2>数据库优化工作</h2><p>对于一个以数据为中心的应用，数据库的好坏直接影响到程序的性能，因此数据库性能至关重要。一般来说，要保证数据库的效率，要做好以下四个方面的工作：</p><p>① 数据库设计</p><p>② sql语句优化</p><p>③ 数据库参数配置</p><p>④ 恰当的硬件资源和操作系统</p><p>此外，使用适当的存储过程，也能提升性能。</p><p>这个顺序也表现了这四个工作对性能影响的大小</p><h2>数据库表设计&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h2><p>通俗地理解三个范式，对于数据库设计大有好处。在数据库设计中，为了更好地应用三个范式，就必须通俗地理解三个范式(通俗地理解是够用的理解，并不是最科学最准确的理解)：</p><p>第一范式：1NF是对属性的原子性约束，要求属性(列)具有原子性，不可再分解；(只要是关系型数据库都满足1NF)</p><p>第二范式：2NF是对记录的惟一性约束，要求记录有惟一标识，即实体的惟一性；</p><p>第三范式：3NF是对字段冗余性的约束，它要求字段没有冗余。 没有冗余的数据库设计可以做到。</p><p>但是，没有冗余的数据库未必是最好的数据库，有时为了提高运行效率，就必须降低范式标准，适当保留冗余数据。具体做法是： 在概念数据模型设计时遵守第三范式，降低范式标准的工作放到物理数据模型设计时考虑。降低范式就是增加字段，允许冗余。</p><p><strong>☞&nbsp;</strong><strong>数据库的分类</strong></p><p>关系型数据库: mysql/oracle/db2/informix/sysbase/sql server</p><p>非关系型数据库: (特点: 面向对象或者集合)</p><p>NoSql数据库: MongoDB(特点是面向文档)</p><p>举例说明什么是适度冗余，或者说有理由的冗余!</p><p>&nbsp;<img src=\"https://images2015.cnblogs.com/blog/413851/201604/413851-20160409103127859-1064042671.png\" alt=\"\"></p><p>上面这个就是不合适的冗余，原因是:</p><p>在这里，为了提高学生活动记录的检索效率，把单位名称冗余到学生活动记录表里。单位信息有500条记录，而学生活动记录在一年内大概有200万数据量。 如果学生活动记录表不冗余这个单位名称字段，只包含三个int字段和一个timestamp字段，只占用了16字节，是一个很小的表。而冗余了一个 varchar(32)的字段后则是原来的3倍，检索起来相应也多了这么多的I/O。而且记录数相差悬殊，500 VS 2000000 ，导致更新一个单位名称还要更新4000条冗余记录。由此可见，这个冗余根本就是适得其反。</p><p>&nbsp;<img src=\"https://images2015.cnblogs.com/blog/413851/201604/413851-20160409103251312-1716059760.png\" alt=\"\"></p><p>订单表里面的Price就是一个冗余字段，因为我们可以从订单明细表中统计出这个订单的价格，但是这个冗余是合理的，也能提升查询性能。</p><p>从上面两个例子中可以得出一个结论:</p><p>1---n 冗余应当发生在1这一方.</p>',1,'1550648579',2,0,'http://localhost/tp5/uploads/20190220/8b835499fd398b2e40ffb5682bc9b8eb.jpeg','mysql的性能优化无法一蹴而就，必须一步一步慢慢来，从各个方面进行优化，最终性能就会有大的提升。',1,'admin123',0),(9,'PHP面向对象-继承','<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/giantpanda/archive/2012/11/10/2763924.html\">PHP面向对象——继承</a></h1><div class=\"clear\"></div><div class=\"postBody\"><div id=\"cnblogs_post_body\" class=\"blogpost-body\"><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 程序世界中对象的继承，是从现实世界中事物对象的分类和共性抽象而来的。比如：公司雇员是一个类，包括名字、年龄、工资、工龄等属性，公司里还有主管、CEO等，他们也属于公司雇员，只是比普通雇员多了些权限和工作内容，那么主管、CEO类就可以继承雇员类。</p><div class=\"cnblogs_code\"><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div><pre>&lt;?<span>php\n\n</span><span>class</span><span> Employee{\n    </span><span>private</span> <span>$name</span><span>;\n    </span><span>private</span> <span>$age</span><span>;\n    </span><span>private</span> <span>$wages</span><span>;\n\n    </span><span>public</span> setName(<span>$name</span><span>){\n        </span><span>$this</span>-&gt;name = <span>$name</span><span>;\n    }\n    </span><span>//</span><span> setter 略...</span>\n\n    <span>public</span><span> getName(){\n        </span><span>return</span> <span>$this</span>-&gt;<span>name;\n    }\n    </span><span>//</span><span> getter 略...</span>\n<span>}\n\n</span><span>class</span> Executive <span>extends</span><span> Employee{\n    </span><span>public</span><span> operate(){\n        </span><span>echo</span> \"经营管理！\"<span>;\n    }\n    </span><span>//</span><span> 其它方法略...</span>\n<span>}\n\n</span><span>class</span> CEO <span>extends</span><span> Executive{\n    </span><span>public</span><span> manage(){\n        </span><span>echo</span> \"管理公司！\"<span>;\n    }\n    </span><span>//</span><span> 其它方法略...</span>\n}</pre><div class=\"cnblogs_code_toolbar\"><span class=\"cnblogs_code_copy\"><a title=\"复制代码\"><img src=\"https://common.cnblogs.com/images/copycode.gif\" alt=\"复制代码\"></a></span></div></div><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PHP中使用extends关键字表示继承，上例中，由于Executive具有Employee的成员，所以Executive继承Employee后，自然具有了Employee的成员，这样增加了重用性。（关于继承的访问权限请看《<a href=\"http://www.cnblogs.com/giantpanda/archive/2012/11/08/2760074.html\" target=\"_blank\">PHP面向对象——访问修饰符</a>》）</p><p>&nbsp;&nbsp;&nbsp;&nbsp; PHP中子类的构造方法不会自动调用父类构造方法（与java不同），请《<a href=\"http://www.cnblogs.com/giantpanda/archive/2012/11/07/2759458.html\">PHP面向对象——构造函数、析构函数</a>》</p></div></div>',1,'1550648864',1,1,'http://localhost/tp5/uploads/20190220/e429186dcfa4a01a392e323371ea41d2.jpeg','面向对象(Object Oriented,OO)是软件开发方法。面向对象的概念和应用已超越了程序设计',12,'admin123',0),(10,'MySql数据类型','<h1 class=\"postTitle\"><a id=\"cb_post_title_url\" class=\"postTitle2\" href=\"https://www.cnblogs.com/zbseoag/archive/2013/03/19/2970004.html\">mysql 数据类型</a></h1><div class=\"clear\"></div><div class=\"postBody\"><div id=\"cnblogs_post_body\" class=\"blogpost-body\"><p><strong>1、整型</strong></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" class=\"layui-table\"><tbody><tr><td align=\"center\" width=\"173\"><strong>MySQL数据类型</strong></td><td align=\"center\" width=\"418\"><strong>含义（有符号）</strong></td></tr><tr><td>tinyint(m)</td><td>1个字节&nbsp; 范围(-128~127)</td></tr><tr><td>smallint(m)</td><td>2个字节&nbsp; 范围(-32768~32767)</td></tr><tr><td>mediumint(m)</td><td>3个字节&nbsp; 范围(-8388608~8388607)</td></tr><tr><td>int(m)</td><td>4个字节&nbsp; 范围(-2147483648~2147483647)</td></tr><tr><td>bigint(m)</td><td>8个字节&nbsp; 范围(+-9.22*10的18次方)</td></tr></tbody></table><p>取值范围如果加了unsigned，则最大值翻倍，如tinyint unsigned的取值范围为(0~256)。&nbsp;<br>int(m)里的m是表示SELECT查询结果集中的显示宽度，并不影响实际的取值范围，没有影响到显示的宽度，不知道这个m有什么用。</p><p><strong>2、浮点型(float和double)</strong></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" class=\"layui-table\"><tbody><tr><td align=\"center\" width=\"173\"><strong>MySQL数据类型</strong></td><td align=\"center\" width=\"418\"><strong>含义</strong></td></tr><tr><td width=\"151\">float(m,d)</td><td width=\"427\">单精度浮点型&nbsp;&nbsp;&nbsp; 8位精度(4字节)&nbsp;&nbsp;&nbsp; &nbsp;m总个数，d小数位</td></tr><tr><td width=\"151\">double(m,d)</td><td width=\"427\">双精度浮点型&nbsp;&nbsp;&nbsp; 16位精度(8字节)&nbsp;&nbsp; &nbsp;m总个数，d小数位</td></tr></tbody></table><p>设一个字段定义为float(5,3)，如果插入一个数123.45678,实际数据库里存的是123.457，但总个数还以实际为准，即6位。</p><p><strong>3、定点数</strong></p><p>浮点型在数据库中存放的是近似值，而定点类型在数据库中存放的是精确值。&nbsp;<br>decimal(m,d) 参数m&lt;65 是总个数，d&lt;30且 d&lt;m 是小数位。</p><p><strong>4、字符串(char,varchar,_text)</strong></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" class=\"layui-table\"><tbody><tr><td align=\"center\" width=\"173\"><strong>MySQL数据类型</strong></td><td align=\"center\" width=\"418\"><strong>含义</strong></td></tr><tr><td width=\"146\">char(n)</td><td width=\"428\">固定长度，最多255个字符</td></tr><tr><td width=\"146\">varchar(n)</td><td width=\"428\">固定长度，最多65535个字符</td></tr><tr><td width=\"146\">tinytext</td><td width=\"428\">可变长度，最多255个字符</td></tr><tr><td width=\"146\">text</td><td width=\"428\">可变长度，最多65535个字符</td></tr><tr><td width=\"146\">mediumtext</td><td width=\"428\">可变长度，最多2的24次方-1个字符</td></tr><tr><td width=\"146\">longtext</td><td width=\"428\">可变长度，最多2的32次方-1个字符</td></tr></tbody></table><p>char和varchar：<br>1.char(n) 若存入字符数小于n，则以空格补于其后，查询之时再将空格去掉。所以char类型存储的字符串末尾不能有空格，varchar不限于此。&nbsp;<br>2.char(n) 固定长度，char(4)不管是存入几个字符，都将占用4个字节，varchar是存入的实际字符数+1个字节（n&lt;=255）或2个字节(n&gt;255)，所以varchar(4),存入3个字符将占用4个字节。&nbsp;<br>3.char类型的字符串检索速度要比varchar类型的快。<br><br>varchar和text：&nbsp;<br>1.varchar可指定n，text不能指定，内部存储varchar是存入的实际字符数+1个字节（n&lt;=255）或2个字节(n&gt;255)，text是实际字符数+2个字节。&nbsp;<br>2.text类型不能有默认值。&nbsp;<br>3.varchar可直接创建索引，text创建索引要指定前多少个字符。varchar查询速度快于text,在都创建索引的情况下，text的索引似乎不起作用。</p><p><strong>5.二进制数据(_Blob)</strong></p><p>1._BLOB和_text存储方式不同，_TEXT以文本方式存储，英文存储区分大小写，而_Blob是以二进制方式存储，不分大小写。&nbsp;<br>2._BLOB存储的数据只能整体读出。&nbsp;<br>3._TEXT可以指定字符集，_BLO不用指定字符集。</p><p><strong>6.日期时间类型</strong></p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" class=\"layui-table\"><tbody><tr><td align=\"center\" width=\"173\"><strong>MySQL数据类型</strong></td><td align=\"center\" width=\"418\"><strong>含义</strong></td></tr><tr><td>date</td><td>日期 \'2008-12-2\'</td></tr><tr><td>time</td><td>时间 \'12:25:36\'</td></tr><tr><td>datetime</td><td>日期时间 \'2008-12-2 22:06:44\'</td></tr><tr><td>timestamp</td><td>自动存储记录修改时间</td></tr></tbody></table><p>若定义一个字段为timestamp，这个字段里的时间数据会随其他字段修改的时候自动刷新，所以这个数据类型的字段可以存放这条记录最后被修改的时间。</p><p><strong>数据类型的属性</strong></p><p>&nbsp;</p><table border=\"1\" cellspacing=\"0\" cellpadding=\"5\" class=\"layui-table\"><tbody><tr><td align=\"center\" width=\"173\"><strong>MySQL关键字</strong></td><td align=\"center\" width=\"418\"><strong>含义</strong></td></tr><tr><td>NULL</td><td>数据列可包含NULL值</td></tr><tr><td>NOT NULL</td><td>数据列不允许包含NULL值</td></tr><tr><td>DEFAULT</td><td>默认值</td></tr><tr><td>PRIMARY KEY</td><td>主键</td></tr><tr><td>AUTO_INCREMENT</td><td>自动递增，适用于整数类型</td></tr><tr><td>UNSIGNED</td><td>无符号</td></tr><tr><td>CHARACTER SET name</td><td>指定一个字符集</td></tr></tbody></table></div></div>',1,'1550650613',2,0,'http://localhost/tp5/uploads/20190220/20fa95d6adf4bc23360f9a0da66002ca.png','MySQL是一个关系型数据库管理系统，由瑞典MySQL AB 公司开发，目前属于 Oracle 旗下',15,'admin123',0);
/*!40000 ALTER TABLE `blog_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_article_cate`
--

DROP TABLE IF EXISTS `blog_article_cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article_cate`
--

LOCK TABLES `blog_article_cate` WRITE;
/*!40000 ALTER TABLE `blog_article_cate` DISABLE KEYS */;
INSERT INTO `blog_article_cate` VALUES (1,'PHP','1550647298'),(2,'MySql','1550647302');
/*!40000 ALTER TABLE `blog_article_cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comment`
--

DROP TABLE IF EXISTS `blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `content` varchar(200) NOT NULL,
  `create_time` varchar(30) NOT NULL,
  `article_id` int(11) NOT NULL,
  `image` varchar(200) DEFAULT NULL,
  `article_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comment`
--

LOCK TABLES `blog_comment` WRITE;
/*!40000 ALTER TABLE `blog_comment` DISABLE KEYS */;
INSERT INTO `blog_comment` VALUES (1,'::1','嘻嘻嘻','哈哈哈','1550649267',6,'http://localhost//tp5/public/static/index/images/tx1.jpg','使用MySql乐观锁解决并发问题'),(2,'::1','asdad1','asd1','1550711217',9,'http://localhost//tp5/public/static/index/images/tx5.jpg','PHP面向对象-继承'),(3,'::1','厉害了','厉害了','1550711299',10,'http://localhost//tp5/public/static/index/images/tx2.jpg','MySql数据类型');
/*!40000 ALTER TABLE `blog_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_log`
--

DROP TABLE IF EXISTS `blog_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `ip` varchar(20) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_log`
--

LOCK TABLES `blog_log` WRITE;
/*!40000 ALTER TABLE `blog_log` DISABLE KEYS */;
INSERT INTO `blog_log` VALUES (3,'admin123','::1','1550639083'),(4,'admin123','::1','1550711099'),(5,'admin123','::1','1550714634'),(6,'admin123','::1','1550717829'),(7,'admin123','::1','1550722170'),(8,'admin123','::1','1550722187'),(9,'admin123','::1','1550722191'),(10,'admin123','::1','1550722200'),(11,'admin123','::1','1550722325'),(12,'admin123','::1','1550722475'),(13,'admin123','::1','1550722479'),(14,'admin123','::1','1550722483'),(15,'admin123','::1','1550722492'),(16,'admin123','::1','1550723080'),(17,'admin123','::1','1550723131'),(18,'admin123','::1','1550723218'),(19,'admin123','::1','1550723221'),(20,'admin123','::1','1550723229'),(21,'admin123','::1','1550723283'),(22,'admin123','::1','1550723311'),(23,'admin123','::1','1550723401'),(24,'admin123','::1','1550729262'),(25,'admin123','::1','1550729285'),(26,'admin123','::1','1550729329'),(27,'admin123','::1','1550729390'),(28,'admin123','::1','1550729408'),(29,'admin123','::1','1550729460'),(30,'admin123','::1','1550729590'),(31,'admin123','::1','1550729605'),(32,'admin123','::1','1550729701'),(33,'admin123','::1','1550729723');
/*!40000 ALTER TABLE `blog_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_message`
--

DROP TABLE IF EXISTS `blog_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `content` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `ip` varchar(20) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  `is_reply` tinyint(4) NOT NULL DEFAULT '0',
  `reply_content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_message`
--

LOCK TABLES `blog_message` WRITE;
/*!40000 ALTER TABLE `blog_message` DISABLE KEYS */;
INSERT INTO `blog_message` VALUES (1,'刘','喜欢','http://localhost//tp5/public/static/index/images/tx1.jpg','::1','1550571726',1,'xxx萨达所大所大所'),(2,'金','嘻嘻嘻','http://localhost//tp5/public/static/index/images/tx3.jpg','::1','1550572174',1,'ADASDASDASDASDASDASDA'),(5,'新消息','新消息','http://localhost//tp5/public/static/index/images/tx2.jpg','::1','1550648913',1,'四不四傻'),(6,'asdad1','asdasd1','http://localhost//tp5/public/static/index/images/tx4.jpg','::1','1550711273',0,NULL),(7,'哼哼','哈哈哈哈','http://localhost//tp5/public/static/index/images/tx3.jpg','::1','1550714510',0,NULL);
/*!40000 ALTER TABLE `blog_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_node`
--

DROP TABLE IF EXISTS `blog_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(20) NOT NULL,
  `pid` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_node`
--

LOCK TABLES `blog_node` WRITE;
/*!40000 ALTER TABLE `blog_node` DISABLE KEYS */;
INSERT INTO `blog_node` VALUES (1,'文章管理',0,'1550478362','Article'),(2,'文章列表',1,'1550478362','articleList'),(3,'日志管理',0,'1550478362','Log'),(4,'日志列表',3,'1550478362','logList'),(6,'节点管理',0,'1550733685','Node'),(7,'节点列表',6,'1550735310','nodeList'),(10,'添加节点',6,'1550737046','add'),(11,'删除节点',6,'1550737057','delete'),(12,'更新节点',6,'1550737068','update');
/*!40000 ALTER TABLE `blog_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_role`
--

DROP TABLE IF EXISTS `blog_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_role`
--

LOCK TABLES `blog_role` WRITE;
/*!40000 ALTER TABLE `blog_role` DISABLE KEYS */;
INSERT INTO `blog_role` VALUES (1,'文章发布员','1550478362','只能访问文章相关接口哈哈'),(2,'日志管理员','1550478362','只能看登录日志'),(22,'超级管理员','1550741482','啥都能干');
/*!40000 ALTER TABLE `blog_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_role_node`
--

DROP TABLE IF EXISTS `blog_role_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_role_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  `create_time` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_role_node`
--

LOCK TABLES `blog_role_node` WRITE;
/*!40000 ALTER TABLE `blog_role_node` DISABLE KEYS */;
INSERT INTO `blog_role_node` VALUES (17,22,6,'1550744584'),(18,22,12,'1550744584'),(19,22,11,'1550744584'),(20,22,3,'1550744584'),(21,22,4,'1550744584'),(22,22,1,'1550744584'),(23,22,2,'1550744584'),(24,2,3,'1550744592'),(25,2,4,'1550744592'),(26,1,1,'1550744600'),(27,1,2,'1550744600');
/*!40000 ALTER TABLE `blog_role_node` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-21 18:48:56
