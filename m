From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 01/10] DT bindings in plain text format
Date: Mon, 22 Jun 2020 11:32:43 +0100
Message-ID: <20200622103243.GT954398@dell>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200620223915.1311485-2-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200620223915.1311485-2-j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.chen-4K37Az1KcQB9nmWX13WWKA@public.gmane.org>, Mauro Carvalho Chehab <mchehab+>
List-Id: linux-pwm@vger.kernel.org

On Sun, 21 Jun 2020, Jonathan Neuschäfer wrote:

> For reference, here are the devicetree bindings in plaintext format.
> (Not for merge.)

This would be better placed inside the relevant patch(es), rather than
in a separate non-mergeable extra/superfluous patch.

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
> ---
>  .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
>  .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
