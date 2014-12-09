From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] clk: Add PWM clock driver
Date: Tue, 09 Dec 2014 10:15:33 +0100
Message-ID: <1418116533.3107.1.camel@pengutronix.de>
References: <1415007078-7947-1-git-send-email-p.zabel@pengutronix.de>
	 <5480A132.2010103@elproma.com.pl> <54860426.3020400@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54860426.3020400-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki-9tnw74Q4ehaHKKo6LODCOg@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Janusz,

Am Montag, den 08.12.2014, 21:03 +0100 schrieb Janusz U=C5=BCycki:
> Hi,
>=20
> I've fixed my pwm driver and I can enable 12MHz 50% output using sysf=
s.=20
> Then I rebased the pwm-clock to 3.14.
> I have connected mcp2515 and it works with fixed clock. When I switch=
=20
> the chip's clock to pwm clock in dt
> I get "mcp251x: probe of spi1.2 failed with error -2". I've also adde=
d=20
> clock-frequency property
> but it didn't help.
> When I set the mcp2515 clock to fixed clock again but the clock is no=
t=20
> applied to mcp2515 I get
> "mcp251x spi1.2: MCP251x didn't enter in conf mode after reset".
> So it looks this is indeed probe error caused likely by dt.

Did pwm-clock fail to probe already? Could you check with the patch
below?

> The fixed and pwm clock in DT:
>          clocks {
>                  #address-cells =3D <1>;
>                  #size-cells =3D <1>;
>                  ranges;
>                  mcp251x_xtal_clk: mcp2515_xtal {
>                          compatible =3D "fixed-clock";
>                          #clock-cells =3D <0>;
>                          clock-frequency =3D <12000000>;
>                  };
>=20
>                  mcp251x_pwm_clk: mcp2515_pwm {
>                          compatible =3D "pwm-clock";
>                          #clock-cells =3D <0>;
>                          clock-frequency =3D <12000000>;
>                          clock-output-names =3D "can_clk";
>                          pwms =3D <&pwm 3 83>;     /* 12MHz =3D 1 / ~=
83ns */
>                  };
>          };
>=20
> Also the mentioned frequency recalculation problem appears here.
> In the case above recalc value is about 12.048MHz instead of 12.0MHz.
> While PWM block is clocked 24MHz and the pwm generates exactly 12MHz
> the pwm-clock driver returns drifted value. Using clock-frequency lik=
e
> fixed-clock does could simply solve the binding problem.

Yes, for this case it is very unfortunate that there's only nanosecond
resolution for the duty cycle. Adding a clock-frequency property to
indicate the real frequency would solve this problem.

------8<------
diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 8f747b3..9c13856 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -63,12 +63,16 @@ int clk_pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
=20
 	pwm =3D devm_pwm_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm))
+	if (IS_ERR(pwm)) {
+		dev_err(&pdev->dev, "failed to get pwm: %ld\n", PTR_ERR(pwm));
 		return PTR_ERR(pwm);
+	}
=20
 	ret =3D pwm_config(pwm, (pwm->period + 1) >> 1, pwm->period);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to configure pwm: %d\n", ret);
 		return ret;
+	}
=20
 	init.name =3D "pwm-clock";
 	init.ops =3D &clk_pwm_ops;
@@ -78,11 +82,18 @@ int clk_pwm_probe(struct platform_device *pdev)
 	clk_pwm->pwm =3D pwm;
 	clk_pwm->hw.init =3D &init;
 	clk =3D devm_clk_register(&pdev->dev, &clk_pwm->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to register clock: %ld\n",
+			PTR_ERR(clk));
 		return PTR_ERR(clk);
+	}
=20
-	return of_clk_add_provider(pdev->dev.of_node,
-				   of_clk_src_simple_get, clk);
+	ret =3D of_clk_add_provider(pdev->dev.of_node,
+				  of_clk_src_simple_get, clk);
+	if (ret)
+		dev_err(&pdev->dev, "failed to add clock provider: %d\n", ret);
+
+	return ret;
 }
=20
 int clk_pwm_remove(struct platform_device *pdev)


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
