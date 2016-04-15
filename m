From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [RESEND 07/11] pwm: sti: Initialise PWM Capture channel data
Date: Fri, 15 Apr 2016 16:23:17 +0200
Message-ID: <20160415142317.GF3472@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-8-git-send-email-lee.jones@linaro.org>
 <20160412102926.GC18882@ulmo.ba.sec>
 <20160415131146.GE3589@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32828 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcDOOXV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Apr 2016 10:23:21 -0400
Content-Disposition: inline
In-Reply-To: <20160415131146.GE3589@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pwm@vger.kernel.org, ajitpal.singh@st.com


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 15, 2016 at 02:11:46PM +0100, Lee Jones wrote:
> On Tue, 12 Apr 2016, Thierry Reding wrote:
> > On Wed, Mar 02, 2016 at 03:32:05PM +0000, Lee Jones wrote:
> > [...]
> > > +struct sti_cpt_data {
> > > +	u32 snapshot[3];
> > > +	int index;
> > > +	int gpio;
>=20
> [...]
>=20
> > > +
> > > +		init_waitqueue_head(&data->wait);
> > > +		mutex_init(&data->lock);
> > > +		data->gpio =3D of_get_named_gpio(np, "capture-gpios", chan);
> > > +		pc->cpt_data[chan] =3D data;
> >=20
> > Converting to per-PWM data should be as simple as turning this last line
> > into:
> >=20
> > 	pwm_set_chip_data(pc->chip.pwms[chan], data);
> >=20
> > Also I don't see any cleanup for this data in the driver. The memory for
> > the per-PWM data should be freed by devm_*() infrastructure, but how
> > will the GPIO be released?
>=20
> There is no reason to release a GPIO.

Why? If you request it why would you not need to release it?

Thierry

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXEPlVAAoJEN0jrNd/PrOhPr0P/1axPZA89c1HeSL6MJUzlKki
j+UecMJAzlWUlCx5deNensIT/5r1AdCHs1byaba/nESZqfyNZMKA8rOTdPETX2AP
mkkRQOZ50bKCf8QS3UUEVfSHMO2OYQ3n6XuNnlgZksVhXzsdXS+5LuCuzrxxP1gH
4L/Hl3KIGrP7uO9xtLuHcMpEUGuk/Ac/sRmo2b3gQ94XZTyPQor1+z/2R5br+17i
r0PG0fEySxJqiz25TDNu8fZuq988OKXfINVQH6Ajph0YuZjDgzKcY9tCbvqUC9N5
2Dr+823nVNqW5TIb8gXrM34l9uegrje85fdagTbz+TzqSBOCC27z3Z/no1Q+O5wL
rf4PMnpv++UODvqsFO7DV2TmbHgfVq6ffM6Cn48JnK21rtAWVfsay0YYzTW+7ANk
cn2E8XhLfvv1kk2i4iV9b06G5J8bf8vOqXIQ6YPe/XNzYWt4n3ULF/E0XIM4rf6Y
BvCC5MpZfjK/REDEBp/LnMo7tpWUgv2Ii2T0+BYE/+WEAvPVqMisiMvBkUKMioEb
1FcqqnLub1mLITWhJdXdetv5xVlEQ5h3skJaSIZxgO1FTXI5B9DWg1pq1I0wXNGi
7vIBSDZ4plo1q8+Cc3+eNi2wRPik73vFP2ttNe2Q+hgSm/+K64Ht5nyze8YkmlNn
AA9sRotV07uHZbCUbPuV
=39AX
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
