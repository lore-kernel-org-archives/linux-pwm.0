Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] pwm: samsung: don't uses devm-functions in .request
Date: Mon, 25 Mar 2019 10:49:34 +0100
Message-Id: <20190325094934.10221-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
References: <20190325094934.10221-1-u.kleine-koenig@pengutronix.de>
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
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

A call to .request() is always paired by a call to .free() before a given
device is disposed. So the simplification that usually is possible when
using devm-functions cannot be used here. So use plain kzalloc() and
kfree() for improved runtime behaviour and reduced memory footprint.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 3762432dd6a7..145a1c1ecf11 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -226,7 +226,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return -EINVAL;
 	}
 
-	our_chan = devm_kzalloc(chip->dev, sizeof(*our_chan), GFP_KERNEL);
+	our_chan = kzalloc(chip->dev, sizeof(*our_chan), GFP_KERNEL);
 	if (!our_chan)
 		return -ENOMEM;
 
@@ -237,7 +237,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pwm_samsung_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	devm_kfree(chip->dev, pwm_get_chip_data(pwm));
+	kfree(chip->dev, pwm_get_chip_data(pwm));
 }
 
 static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
2.20.1
