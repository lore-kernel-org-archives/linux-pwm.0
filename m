From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 06/11] pwm: sti: Add new driver for ST's PWM IP
Date: Fri, 8 Aug 2014 08:38:02 +0100
Message-ID: <20140808073802.GC21618@lee--X1>
References: <1405348412-7352-1-git-send-email-lee.jones@linaro.org>
 <1405348412-7352-7-git-send-email-lee.jones@linaro.org>
 <20140807142344.GA11095@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140807142344.GA11095-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 07 Aug 2014, Thierry Reding wrote:
> On Mon, Jul 14, 2014 at 03:33:27PM +0100, Lee Jones wrote:
> [...]
> > +static int sti_pwm_probe(struct platform_device *pdev)
> > +{
> [...]
> > +	pc->clk =3D of_clk_get_by_name(np, "pwm");
>=20
> This didn't compile because the np variable isn't declared. It was ea=
sy
> to fix up, so I did, but please be more careful next time that the
> patches you submit at least compile (preferably without sparse warnin=
gs
> of which I also fixed up a couple).

That's annoying, I thought I did build test the final changes.
However, there's a mistake in the Makefile meaning that it wasn't
building with no warning/error messages - it actually wasn't building
at all!  Sorry about that Thierry.

I guess if you can build the driver, you've already fixed that?

diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 878333a..79665e3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_PWM_PXA)         +=3D pwm-pxa.o
 obj-$(CONFIG_PWM_RENESAS_TPU)  +=3D pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_SAMSUNG)      +=3D pwm-samsung.o
 obj-$(CONFIG_PWM_SPEAR)                +=3D pwm-spear.o
-obj-$(CONFIG_PWM_STI)          +=3D pwm-st.o
+obj-$(CONFIG_PWM_STI)          +=3D pwm-sti.o
 obj-$(CONFIG_PWM_TEGRA)                +=3D pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)       +=3D pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)     +=3D pwm-tiehrpwm.o

After that change, I can see that you're absolutely correct:

  CC      drivers/pwm/pwm-sti.o
=2E./drivers/pwm/pwm-sti.c: In function =E2=80=98sti_pwm_config=E2=80=99=
:
=2E./drivers/pwm/pwm-sti.c:202:3: warning:
  format =E2=80=98%lu=E2=80=99 expects argument of type =E2=80=98long u=
nsigned int=E2=80=99, but
  argument 5 has type =E2=80=98int=E2=80=99 [-Wformat=3D]
     dev_dbg(dev, "prescale:%u, period:%lu, duty:%i, pwmvalx:%u\n",
     ^
=2E./drivers/pwm/pwm-sti.c: In function =E2=80=98sti_pwm_probe=E2=80=99=
:
=2E./drivers/pwm/pwm-sti.c:352:31: error: =E2=80=98np=E2=80=99 undeclar=
ed=20
  pc->clk =3D of_clk_get_by_name(np, "pwm");
                               ^
Sorry for the fuss.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
