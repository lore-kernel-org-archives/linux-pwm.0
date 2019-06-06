From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH -next] pwm: pca9685: Remove set but not used variable 'pwm'
Date: Thu,  6 Jun 2019 11:11:11 -0400
Message-ID: <20190606151111.14237-1-TheSven73@gmail.com>
References: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGngYiVDCCjo6VKt660Uz5mbEGOBOZpcUWeRHWx_L=TapZgv_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, YueHaibing <yuehaibing@huawei.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

I was able to test the patch [1] exclusion mechanism without access to actual
hardware - by giving it a dummy regmap. See patch below.

Test cases (all via sysfs):
1. verify requested pwm cannot be requested as gpio
2. verify requested gpio cannot be requested as pwm
3. verify pwm "all LEDs" cannot be used if pwms/gpios in use
4. verify pwms/gpios cannot be requested if pwm "all LEDs" in use

All test cases ok.
 Obviously, I could not test multi-threaded correctness.

[1] https://lkml.org/lkml/2019/6/4/1039

---
 drivers/pwm/pwm-pca9685.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 259fd58812ae..c059da5f86f4 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -83,6 +83,7 @@ struct pca9685 {
 	struct regmap *regmap;
 	int duty_ns;
 	int period_ns;
+	u8 regs[PCA9685_NUMREGS];
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -446,11 +447,31 @@ static const struct pwm_ops pca9685_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int read_reg_dummy(void *context, unsigned int reg,
+			unsigned int *val)
+{
+	struct pca9685 *pca = context;
+
+	*val = pca->regs[reg];
+	return 0;
+}
+
+static int write_reg_dummy(void *context, unsigned int reg,
+			 unsigned int val)
+{
+	struct pca9685 *pca = context;
+
+	pca->regs[reg] = val;
+	return 0;
+}
+
 static const struct regmap_config pca9685_regmap_i2c_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = PCA9685_NUMREGS,
 	.cache_type = REGCACHE_NONE,
+	.reg_read = read_reg_dummy,
+	.reg_write = write_reg_dummy,
 };
 
 static int pca9685_pwm_probe(struct i2c_client *client,
@@ -464,7 +485,8 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	if (!pca)
 		return -ENOMEM;
 
-	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
+	pca->regmap = devm_regmap_init(&client->dev, NULL, pca,
+					&pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
 		ret = PTR_ERR(pca->regmap);
 		dev_err(&client->dev, "Failed to initialize register map: %d\n",
-- 
2.17.1
