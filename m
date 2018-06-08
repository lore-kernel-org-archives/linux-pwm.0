From: shenwei.wang@nxp.com
Subject: [PATCH v2 3/4] pwm: fsl-ftm: Enable support for the new SoC i.mx8qm
Date: Fri,  8 Jun 2018 14:22:36 -0500
Message-ID: <20180608192237.11063-3-shenwei.wang@nxp.com>
References: <20180608192237.11063-1-shenwei.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180608192237.11063-1-shenwei.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Enabled the support for the new SoC i.mx8qm by adding the
compatible string of "fsl,imx8qm-ftm-pwm" and its
per-compatible data with setting "has_enable_bits" to "true".

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/pwm/pwm-fsl-ftm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index e4c76da..28b87ec 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -562,8 +562,13 @@ static const struct fsl_ftm_soc vf610_ftm_pwm = {
 	.has_enable_bits = false,
 };
 
+static const struct fsl_ftm_soc imx8qm_ftm_pwm = {
+	.has_enable_bits = true,
+};
+
 static const struct of_device_id fsl_pwm_dt_ids[] = {
 	{ .compatible = "fsl,vf610-ftm-pwm", .data = &vf610_ftm_pwm },
+	{ .compatible = "fsl,imx8qm-ftm-pwm", .data = &imx8qm_ftm_pwm },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_pwm_dt_ids);
-- 
2.9.2
