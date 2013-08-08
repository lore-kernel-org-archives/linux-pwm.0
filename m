Return-Path: <linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org>
From: Mike Dunn <mikedunn@newsguy.com>
Subject: [PATCH] ARM: pxa: make pwm driver module_platform_driver
Date: Thu,  8 Aug 2013 10:00:37 -0700
Message-Id: <1375981237-7167-1-git-send-email-mikedunn@newsguy.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+thierry.reding=gmail.com@lists.infradead.org
List-ID: <linux-pwm.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, linux-pwm@vger.kernel.org, Mike Dunn <mikedunn@newsguy.com>, Thierry Reding <thierry.reding@avionic-design.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <chao.xie@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Robert Jarzmik <robert.jarzmik@free.fr>

Commit 76abbdde2d95a3807d0dc6bf9f84d03d0dbd4f3d

    pwm: Add sysfs interface

causes a kernel oops due to a null pointer dereference on pxa platforms.  This
happens because the class added by the patch is registered in a subsys_initcall
(initcall4), but the pxa pwm driver is registered in arch_initcall (initcall3).
If the class is not registered before the driver probe function runs, the oops
occurs in device_add() when the uninitialized pointers in struct class are
dereferenced.  I don't see a reason that the driver must be an arch_initcall, so
this patch makes it a regular module_platform_driver (initcall6), preventing the
oops.

Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
---
 drivers/pwm/pwm-pxa.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index dc97175..a4d2164 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -182,16 +182,6 @@ static struct platform_driver pwm_driver = {
 	.id_table	= pwm_id_table,
 };
 
-static int __init pwm_init(void)
-{
-	return platform_driver_register(&pwm_driver);
-}
-arch_initcall(pwm_init);
-
-static void __exit pwm_exit(void)
-{
-	platform_driver_unregister(&pwm_driver);
-}
-module_exit(pwm_exit);
+module_platform_driver(pwm_driver);
 
 MODULE_LICENSE("GPL v2");
-- 
1.8.1.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
