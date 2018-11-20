Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Tue, 20 Nov 2018 17:45:30 +0100
Message-Id: <20181120164530.6400-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH] pwm: drop per-chip dbg_show callback
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

This callback was introduced in commit 62099abf67a2 ("pwm: Add debugfs
interface") in 2012 and up to now there is not a single user. So drop this
unused code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 5 +----
 include/linux/pwm.h | 3 ---
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 253a459fe0d8..3149204567f3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1036,10 +1036,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 		   dev_name(chip->dev), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
 
-	if (chip->ops->dbg_show)
-		chip->ops->dbg_show(chip, s);
-	else
-		pwm_dbg_show(chip, s);
+	pwm_dbg_show(chip, s);
 
 	return 0;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 017d1e13e29d..a40bbe55fd29 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -272,9 +272,6 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
-#ifdef CONFIG_DEBUG_FS
-	void (*dbg_show)(struct pwm_chip *chip, struct seq_file *s);
-#endif
 	struct module *owner;
 };
 
-- 
2.19.1
