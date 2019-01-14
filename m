From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] pwm: imx27: fix build issue
Date: Mon, 14 Jan 2019 12:14:35 +0100
Message-ID: <20190114111435.27397-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
List-Id: linux-pwm@vger.kernel.org

When PWM_IMX27 was configured as a module we got the following
build error:

In file included from ../drivers/pwm/pwm-imx27.c:15:
../drivers/pwm/pwm-imx27.c:292:25: error: ‘imx_pwm_dt_ids’
undeclared here (not in a function); did you mean ‘pwm_imx27_dt_ids’?
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
                         ^~~~~~~~~~~~~~
../include/linux/module.h:213:15: note: in definition of macro ‘MODULE_DEVICE_TABLE’
 extern typeof(name) __mod_##type##__##name##_device_table  \
               ^~~~
../include/linux/module.h:213:21: error: ‘__mod_of__imx_pwm_dt_ids_device_table’
aliased to undefined symbol ‘imx_pwm_dt_ids’
 extern typeof(name) __mod_##type##__##name##_device_table  \
                     ^~~~~~
../drivers/pwm/pwm-imx27.c:292:1: note: in expansion of macro ‘MODULE_DEVICE_TABLE’
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
 ^~~~~~~~~~~~~~~~~~~

Rework to use the new variable name pwm_imx27_dt_ids.

Fixes: 5a309d380019 ("pwm: imx: Split into two drivers")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/pwm/pwm-imx27.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8997c4c1bd03..55666cca4cee 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -289,7 +289,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] = {
 	{ .compatible = "fsl,imx27-pwm", },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
+MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
-- 
2.19.2
