From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/2] pwm: pca9685: fix prescaler initialization
Date: Tue, 13 Dec 2016 16:52:51 +0100
Message-ID: <20161213155251.28684-2-clemens.gruber@pqgruber.com>
References: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161213155251.28684-1-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>, Clemens Gruber <clemens.gruber@pqgruber.com>
List-Id: linux-pwm@vger.kernel.org

Until now, we assumed that the period is the hardware default of 1/200Hz
at probe time, but if the period was changed and the user reboots, this
assumption is wrong.

Solution: Check if the prescaler is set to the hardware default. If not,
reprogram the prescaler at first configuration.

Cc: <stable@vger.kernel.org> # v4.3+
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 01a6a83..efc657e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -55,6 +55,7 @@
 #define PCA9685_PRESCALE	0xFE
 
 #define PCA9685_PRESCALE_MIN	0x03	/* => max. frequency of 1526 Hz */
+#define PCA9685_PRESCALE_DEF	0x1E	/* => default frequency of 200 Hz */
 #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
 
 #define PCA9685_COUNTER_RANGE	4096
@@ -289,8 +290,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	struct pca9685 *pca;
+	int prescale, mode2;
 	int ret;
-	int mode2;
 
 	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
 	if (!pca)
@@ -304,10 +305,15 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 	}
 	pca->duty_ns = 0;
-	pca->period_ns = PCA9685_DEFAULT_PERIOD;
 
 	i2c_set_clientdata(client, pca);
 
+	regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
+	if (prescale == PCA9685_PRESCALE_DEF)
+		pca->period_ns = PCA9685_DEFAULT_PERIOD;
+	else
+		pca->period_ns = 0;
+
 	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-- 
2.10.2
