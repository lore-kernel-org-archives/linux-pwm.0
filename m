From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 08/11] pwm: sti: Add support for PWM Capture IRQs
Date: Wed, 13 Apr 2016 17:16:12 +0200
Message-ID: <20160413151612.GB29509@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-9-git-send-email-lee.jones@linaro.org>
 <20160412103521.GD18882@ulmo.ba.sec>
 <20160413100521.GP8094@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34517 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933921AbcDMPQW (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2016 11:16:22 -0400
Content-Disposition: inline
In-Reply-To: <20160413100521.GP8094@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 13, 2016 at 11:05:21AM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
>=20
> > On Wed, Mar 02, 2016 at 03:32:06PM +0000, Lee Jones wrote:
> > [...]
> > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
[...]
> > > +
> > > +		regmap_read(pc->regmap,
> > > +			    PWM_CPT_VAL(channel), &d->snapshot[d->index]);
> > > +
> > > +		switch (d->index) {
> > > +		case 0:
> > > +		case 1:
> > > +			regmap_read(pc->regmap, PWM_CPT_EDGE(channel), &reg);
> > > +			reg ^=3D PWM_CPT_EDGE_MASK;
> > > +			regmap_write(pc->regmap, PWM_CPT_EDGE(channel), reg);
> > > +
> > > +			d->index++;
> > > +			break;
> > > +		case 2:
> > > +			regmap_write(pc->regmap,
> > > +				     PWM_CPT_EDGE(channel), CPT_EDGE_DISABLED);
> > > +			wake_up(&d->wait);
> > > +			break;
> > > +		default:
> > > +			dev_err(dev, "Internal error\n");
> > > +		}
> > > +
> > > +		clear_bit(channel, (unsigned long int *)&cpt_int_stat);
> >=20
> > clear_bit() is a little unusual to use on regular data types, as
> > evidenced by the need for the goofy cast here.
>=20
> It's just a bit neater (and provides locking) than manually bit
> twiddling using bitwise operators.  What do you suggest?

I think the cast indicates that you're mixing unrelated interfaces. Also
looking at patch 9/11 it seems like you'll need extra locking to protect
against concurrent accesses in the interrupt handler and the ->capture()
implementation anyway, so might as well use that lock for this access.

> > > @@ -371,7 +447,7 @@ static int sti_pwm_probe(struct platform_device *=
pdev)
> > >  	struct sti_pwm_chip *pc;
> > >  	struct resource *res;
> > >  	unsigned int chan;
> > > -	int ret;
> > > +	int ret, irq;
> > > =20
> > >  	pc =3D devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
> > >  	if (!pc)
> > > @@ -392,6 +468,19 @@ static int sti_pwm_probe(struct platform_device =
*pdev)
> > >  	if (IS_ERR(pc->regmap))
> > >  		return PTR_ERR(pc->regmap);
> > > =20
> > > +	irq =3D platform_get_irq(pdev, 0);
> > > +	if (irq < 0) {
> > > +		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
> > > +		return -ENODEV;
> > > +	}
> >=20
> > I think you need to propagate the return value of platform_get_irq()
> > here.
>=20
> Yes, could do.  Although, I think we could go either way:
>=20
> $ git grep -A5 platform_get_irq | grep "return ret\|return irq" | wc -l
> 176
> $ git grep -A5 platform_get_irq | grep "return -EINVAL\|-ENODEV\|-ENXIO" =
| wc -l
> 256
>=20
> Happy to change it though.

I think all the latter are really wrong. Looking at the implementation
of platform_get_irq() there are a number of error codes that it can
return (-EPROBE_DEFER amongst them), so collapsing them all into an
-EINVAL, -ENODEV or -ENXIO is very wrong.

Thierry

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDmK5AAoJEN0jrNd/PrOh2/gP/1mTQ3AIeaSMtRTacDoNSMfo
gLNOIY+ZBRT9MUpL4LfRgltTYN1AlFS0BWGYXA+gmGPbrBlQ3qHQM23PsfSFGtL+
wGw2tLrVvNe/4gryFjgTMvP8laRsERsMOn2FVoGAZjHXRJPjIZG1TujosKWLWZkb
wjri7hKoPaBkAYpUuEm1d5TWNMfGg5A8QYDU+0qbsclm1O7WizUQw4ngnpmwTdjI
IkL3RcHwrlFXYNIvbNx+AEmXrPL/iO+fJmbm8ds3lMriqDWMONBBixbof3VsQAzg
hJx/wUAB/mPWM3UUSoNJLFtlaDLdp1uwe/YCFh0mxDeqQXYh+euff7gifgYjGWvD
KwNXT6pLM1g5ib1n4QJInnfiT6qV+TNyrPzpNjIu2p6dIzpgMFXKaSuDJF+rP89V
7xOkbZmEqIxMJ+/FbYQyVBkSZQzuJcDMogUiI02LkOxlFZcbWOuz9lzgSHCyUDkt
lAUCrhjfnGV0RnL27VFqZmnaYsfAFs7o12OiHShdTvufHHn0e9zQdsCuCnb/lEpP
6qcVI9XlJi/u3zRm72LA8gwoPmRqEI3fVAYQCP6nZ18MUOXh9rA6QDtdMEdJ+/8F
NiFGMy3jQyuuMUdpbl1a6zavbphRnMAZsYAP1AV7jTXUaB5mmTwRjZkAnwQXDK3b
iT9fPu43NsKamt3EbNkh
=WSTK
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
