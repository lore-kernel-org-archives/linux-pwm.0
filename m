From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [[PATCH v2] 09/11] pwm: sti: Add support for
 PWM Capture IRQs
Date: Tue, 7 Jun 2016 10:03:12 +0100
Message-ID: <20160607090312.GB18047@dell>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-10-git-send-email-lee.jones@linaro.org>
 <20160607081455.GB22744@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160607081455.GB22744@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, thierry.reding@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Tue, 07 Jun 2016, Peter Griffin wrote:

> Hi Lee,
>=20
> On Fri, 22 Apr 2016, Lee Jones wrote:
>=20
> > Here we're requesting the PWM Capture IRQ and supplying the
> > handler which will be called in the event of an IRQ fire to
> > handle it.
> >=20
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/pwm/pwm-sti.c | 92 +++++++++++++++++++++++++++++++++++++++=
+++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > index 9d597bb..2230afb 100644
> > --- a/drivers/pwm/pwm-sti.c
> > +++ b/drivers/pwm/pwm-sti.c

[...]

Please cut any large chunks of unnecessary cruft when reviewing.

> > @@ -367,7 +444,7 @@ static int sti_pwm_probe(struct platform_device=
 *pdev)
> >  	struct sti_pwm_chip *pc;
> >  	struct resource *res;
> >  	unsigned int devnum;
> > -	int ret;
> > +	int irq, ret;
> > =20
> >  	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> >  	if (!pc)
> > @@ -388,6 +465,19 @@ static int sti_pwm_probe(struct platform_devic=
e *pdev)
> >  	if (IS_ERR(pc->regmap))
> >  		return PTR_ERR(pc->regmap);
> > =20
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> > +		return irq;
> > +	}
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt,
> > +			       0, pdev->name, pc);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed to request IRQ\n");
> > +		return ret;
> > +	}
> > +
> >  	/*
> >  	 * Setup PWM data with default values: some values could be repla=
ced
> >  	 * with specific ones provided from Device Tree.
>=20
> pwm-st.txt dt binding document and pwm example needs updating to docu=
ment this
> irq.

Yes, it does.  I will update the documentation and place it into this
patch-set on next submission.=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
