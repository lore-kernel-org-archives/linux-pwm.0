From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/7] mfd: add atmel-hlcdc driver
Date: Mon, 16 Jun 2014 18:03:01 +0100
Message-ID: <20140616170301.GC14323@lee--X1>
References: <1402329860-27520-1-git-send-email-boris.brezillon@free-electrons.com>
 <1402329860-27520-2-git-send-email-boris.brezillon@free-electrons.com>
 <20140616125030.GT14323@lee--X1>
 <539EEFD8.20703@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539EEFD8.20703-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean-Jacques Hiblot <jjhiblot-dLKeG7h1OhBDOHtkgc7UlQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 16 Jun 2014, Boris BREZILLON wrote:
> On 16/06/2014 14:50, Lee Jones wrote:
> >> The HLCDC IP available on some Atmel SoCs (i.e. at91sam9n12, at91s=
am9x5
> >> family or sama5d3 family) exposes 2 subdevices:
> >> - a display controller (controlled by a DRM driver)
> >> - a PWM chip
> >>
> >> Add support for the MFD device which will just retrieve HLCDC cloc=
ks and
> >> create a regmap so that subdevices can access the HLCDC register r=
ange
> >> concurrently.
> >>
> >> Signed-off-by: Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> >> ---
> >>  .../devicetree/bindings/mfd/atmel-hlcdc.txt        |  41 ++++++++
> >>  drivers/mfd/Kconfig                                |  11 ++
> >>  drivers/mfd/Makefile                               |   1 +
> >>  drivers/mfd/atmel-hlcdc.c                          | 116 ++++++++=
+++++++++++++
> >>  include/linux/mfd/atmel-hlcdc.h                    |  78 ++++++++=
++++++
> >>  5 files changed, 247 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-hl=
cdc.txt
> >>  create mode 100644 drivers/mfd/atmel-hlcdc.c
> >>  create mode 100644 include/linux/mfd/atmel-hlcdc.h
> >> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt=
 b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> >> new file mode 100644
> >> index 0000000..f5b69cb
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt

[...]

> >> +		hlcdc-display-controller {
> >> +			compatible =3D "atmel,hlcdc-dc";
> >> +			interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> > I assume you're using the 3rd parameter for flags.  If so, please u=
se
> > the defines.
>=20
> No, the third parameter encodes the irq priority (from 0 to 7 IIRC).

Ah okay.  Can you point me to the documentation for this IRQ
controller please?  I'd like to have a quick peek.  It might be worth
defining the priority to prevent confusion, also you definitely should
document it in your binding.

[...]

> >> +static struct platform_driver atmel_hlcdc_driver =3D {
> >> +	.probe =3D atmel_hlcdc_probe,
> >> +	.remove =3D atmel_hlcdc_remove,
> >> +	.driver =3D {
> >> +		.name =3D "atmel-hlcdc",
> >> +		.owner =3D THIS_MODULE,
> >> +		.of_match_table =3D atmel_hlcdc_match,
> > Is this driver DT only?
>=20
> Yes it is.

So it should depend on OF in the Kconfig entry.

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
