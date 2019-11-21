From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v8 3/6] pwm: sun4i: Add an optional probe for
 bus clock
Date: Thu, 21 Nov 2019 20:58:59 +0100
Message-ID: <20191121195902.6906-4-peron.clem@gmail.com>
References: <20191121195902.6906-1-peron.clem@gmail.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBE6Z3PXAKGQEG7NT54Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20191121195902.6906-1-peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Philipp Zabel <pza-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>

H6 PWM core needs bus clock to be enabled in order to work.

Add an optional probe for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 369990ae7d09..66befd8d6f9c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
=20
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device *pde=
v)
 		}
 	}
=20
+	pwm->bus_clk =3D devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get bus clock failed %pe\n",
+				pwm->bus_clk);
+		return PTR_ERR(pwm->bus_clk);
+	}
+
 	pwm->rst =3D devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
 		if (PTR_ERR(pwm->rst) !=3D -EPROBE_DEFER)
@@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device *pde=
v)
 		return ret;
 	}
=20
+	/*
+	 * We're keeping the bus clock on for the sake of simplicity.
+	 * Actually it only needs to be on for hardware register accesses.
+	 */
+	ret =3D clk_prepare_enable(pwm->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk %d\n",
+			ret);
+		goto err_bus;
+	}
+
 	pwm->chip.dev =3D &pdev->dev;
 	pwm->chip.ops =3D &sun4i_pwm_ops;
 	pwm->chip.base =3D -1;
@@ -427,6 +447,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev=
)
 	return 0;
=20
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
=20
 	return ret;
@@ -441,6 +463,7 @@ static int sun4i_pwm_remove(struct platform_device *pde=
v)
 	if (ret)
 		return ret;
=20
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
=20
 	return 0;
--=20
2.20.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20191121195902.6906-4-peron.clem%40gmail.com.
