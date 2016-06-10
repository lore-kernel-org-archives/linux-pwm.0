From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 10 Jun 2016 15:10:08 +0200
Message-ID: <20160610131008.GF27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160608205152.GA5511@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2016 at 03:51:52PM -0500, Rob Herring wrote:
> On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > be more inline with the naming conventions of the subsystem.  Where
> > we used to treat each line as a channel, the PWM convention is to
> > describe them as devices.
>=20
> That's all linux implementation details and you are breaking=20
> compatibility.

While it's true that the API calls channels struct pwm_device, that's
primarily for historical reasons. It's completely fine, and in fact most
drivers already do exactly that, to internally refer to channels as
channels.

Thierry

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWrwtAAoJEN0jrNd/PrOhcpoQALhZwFanc3Z3iglfH06D4Rtq
+qp7hIfnSVFsMwYVE28Y/Q+8hWqx1zAhTkddIzARS3NAibjM5btTeZz6YFszatl8
ufRqR56BcQj1w7ZFe2+/lNv+ZFvFIteWmPfgXwUmKjWbKj/JQe9FKX0cjtK3L8gJ
4CKFYYBYoj8m76S0fFPyuuCkW9AywK8mlyo/z3KYuvv2DBKKiLJJFU1uWeC1xFwn
xshanrmMdX3sz4qZEkVr0hryczbsJUo/dTD02Yha/Pa+/soLCl/nWOiMZMp6TBRX
aIbSl/3MnNjPlCLvh2GQIfVzCsVFfbbl9zTlXX58leoqgs9Fwuo3nNli99FuD1MH
6wF5KdS9D4jUssIjsvrKQUZnTlenHiMNginpfLnUOcD5NJ4wbzWgqzzc3TjUSGPx
11s0Xyrluut3USnWTVHokiSFU2Gygi32+Wr/1T1KcyBa/EQrXiPmLuf3m2EyKNlL
SSZuBH4+T+KEMK8jiJrtrqwv6v9fJEJW3sIHVBh5G42Ss9SVDb/4WfAf06kMgnQv
5KiP/dWMyL/2RLWKG08ovMvDviWkyQ0iFMmO8kfHRc0BCJ0gXirFZyopiaXkdUDj
WhHTZIEJsE1IryPTO+eo0qM7ufYrBjOcMo8V6SLxMHypT+hAs0t3IhL7Qf/ZHnd9
/Qpo2Q/4Ytm70TDSkmS2
=iKEu
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--
