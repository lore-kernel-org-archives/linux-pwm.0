Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: sysfs: fix typo "its" -> "it's"
Date: Tue, 12 Mar 2019 10:25:47 +0100
Message-Id: <20190312092547.24722-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, trivial@kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ceb233dd6048..651130dd515b 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -398,7 +398,7 @@ void pwmchip_sysfs_export(struct pwm_chip *chip)
 
 	/*
 	 * If device_create() fails the pwm_chip is still usable by
-	 * the kernel its just not exported.
+	 * the kernel it's just not exported.
 	 */
 	parent = device_create(&pwm_class, chip->dev, MKDEV(0, 0), chip,
 			       "pwmchip%d", chip->base);
-- 
2.20.1
