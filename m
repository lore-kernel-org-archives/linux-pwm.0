From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 1/2] pwm: add support for atmel-hlcdc-pwm device
Date: Tue, 7 Oct 2014 11:55:56 +0200
Message-ID: <20141007095556.GB12631@ulmo>
References: <1412604423-19329-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412604423-19329-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141007084514.GE24254@ulmo>
 <20141007111411.57448c57@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:50567 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaJGJz7 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Oct 2014 05:55:59 -0400
Content-Disposition: inline
In-Reply-To: <20141007111411.57448c57@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2014 at 11:14:11AM +0200, Boris Brezillon wrote:
> On Tue, 7 Oct 2014 10:45:16 +0200 Thierry Reding <thierry.reding@gmail.co=
m> wrote:
> > On Mon, Oct 06, 2014 at 04:07:02PM +0200, Boris Brezillon wrote:
[...]
> > > +static int atmel_hlcdc_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +	struct atmel_hlcdc_pwm *chip =3D platform_get_drvdata(pdev);
> > > +	int ret;
> > > +
> > > +	ret =3D pwmchip_remove(&chip->chip);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	clk_disable_unprepare(chip->hlcdc->periph_clk);
> >=20
> > You might want to call clk_disable_unprepare() regardless of whether or
> > not pwmchip_remove() failed. You could simply leave out the above check
> > for ret and instead...
>=20
> Are you sure of this one, if pwmchip_remove fails, then the PWM chip
> might still be used. And if we disable the clock the PWM chip won't work
> anymore.

The return value of .remove() isn't really used, so if built as a module
the PWM chip will disappear anyway. Even if not built as a module the
managed resources are going to go away anyway, so for all intents and
purposes the PWM chip will be defunct.

A long time ago there were some discussions about adding reference
counting to the PWM chip and PWM devices to better handle this situation
but it has never really proven to be an issue thus far.

Perhaps a better way to solve this would be to make pwmchip_remove() not
return an error and instead WARN in the single case where it can fail
(if one of the PWM devices it exposes is still in use). That way users
will still get an appropriate warning that something's awry and it would
play more nicely with an advanced mechanism to keep PWM devices alive
beyond the lifetime of a driver to cope with removal.

Irrespective of the above it's probably fine either way, since if
pwmchip_remove() fails you're in a pretty bad place anyway.

Thierry

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUM7isAAoJEN0jrNd/PrOhDsEP/13UL68OGeiQW61vnHESk7/D
MNXcg5iJsNeujQTG/WpzSa3K8rxCLb7+sYcWxmI20BvqYPogYz0J7a1L2rwFaDyF
HKRpdc4uXnnCP5DJOvs4z3qTbXMwW8vXE16uwl2OrrLwlSrovl53L3XcPiy8jjsS
c7qsjBTopqPJe1wkINHO5evKTIrwTwHzB3FXLY865qIQzRSx8qRlpFRhiTEnMYlP
u/bcp2U+QYmf8eBJ2vLflYZDHBtYCBCRBBLqiTdLZcBeVISk8+roNPRX7SRNcnkH
D1WpR6JYIllw7QuRMd39jiqmy/+jubunIbuD/NtRJm+ERet9H3gmPSJ9SZKK7Gxz
7ELIn1JYS5LxmXwl/q/847UifB5kWuWA1egld4xgg5TWeVgK9RiC2BAH7zc7SMEo
aNMGFo20tUC1W4XJBx4BPj49asz3g5YWV0Z74PwscwzJHIfiO69c/jpBrIQ7GkHX
uA2QPeWw00o3HJbqMOmRcc8DoSjKUP5KEoYhKPy5dQT6bFUeJsshvGXUnDIPgbZa
RbClZ0Uqjyv1aG5n+r0ciJghyx5y1I7KadPdxE225ofkw/w9vaTkalncblOYyiHu
xzAIz9niS6rtYn4O1VlwNxX8ORnu7r1R9Ka3mn4HUSfvo3262Ih06CntN+g63ML3
Rk0RM4gcA9x6TaOPtK9c
=yaPz
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
