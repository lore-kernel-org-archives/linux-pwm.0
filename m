Return-Path: <>
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/2] pwm: rcar: Use PM Runtime to control module clock
Date: Tue, 13 Mar 2018 17:18:17 +0900
Message-Id: <1520929098-20873-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520929098-20873-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-pwm.vger.kernel.org>
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hien Dang <hien.dang.eb@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Hien Dang <hien.dang.eb@renesas.com>

Runtime PM API (pm_runtime_get_sync/pm_runtime_put) should be used
to control module clock instead of clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1c85ecc..b942010 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -134,16 +134,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-
-	return clk_prepare_enable(rp->clk);
+	return pm_runtime_get_sync(chip->dev);
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-
-	clk_disable_unprepare(rp->clk);
+	pm_runtime_put(chip->dev);
 }
 
 static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
1.9.1
