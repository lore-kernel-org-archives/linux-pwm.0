From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 1/2] backlight: show brightness even if get_brightness is not
 implemented
Date: Fri, 30 May 2014 12:10:49 +0200
Message-ID: <1401444650-12267-2-git-send-email-a.hajda@samsung.com>
References: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1401444650-12267-1-git-send-email-a.hajda@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "open list:X86 PLATFORM DRIVERS" <platform-driver-x86@vger.kernel.org>, Andrzej Hajda <a.hajda@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yijing Wang <wangyijing@huawei.com>, Matthew Garrett <matthew.garrett@nebula.com>, Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, "moderated list:ARM/S5P EXYNOS AR..." <linux-samsung-soc@vger.kernel.org>, Mikulas Patocka <mpato>
List-Id: linux-pwm@vger.kernel.org

Many implementations of get_brightness operation returns only value
of props.brightness field. This change makes such implementations
unnecessary.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/video/backlight/backlight.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 19b170d..0ce8823 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -221,6 +221,8 @@ static ssize_t actual_brightness_show(struct device *dev,
 	mutex_lock(&bd->ops_lock);
 	if (bd->ops && bd->ops->get_brightness)
 		rc = sprintf(buf, "%d\n", bd->ops->get_brightness(bd));
+	else
+		rc = sprintf(buf, "%d\n", bd->props.brightness);
 	mutex_unlock(&bd->ops_lock);
 
 	return rc;
-- 
1.9.1
