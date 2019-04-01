From: Anson Huang <anson.huang@nxp.com>
Subject: [PATCH] pwm: imx27: use devm_platform_ioremap_resource() to simplify
 code
Date: Mon, 1 Apr 2019 05:24:02 +0000
Message-ID: <1554095960-15638-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 8061306..434a351 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -291,7 +291,6 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
 	struct pwm_imx27_chip *imx;
-	struct resource *r;
=20
 	imx =3D devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
 	if (imx =3D=3D NULL)
@@ -326,8 +325,7 @@ static int pwm_imx27_probe(struct platform_device *pdev=
)
 	imx->chip.of_xlate =3D of_pwm_xlate_with_flags;
 	imx->chip.of_pwm_n_cells =3D 3;
=20
-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imx->mmio_base =3D devm_ioremap_resource(&pdev->dev, r);
+	imx->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
=20
--=20
2.7.4
