From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: lpc32xx: Set PWM_PIN_LEVEL bit in lpc32xx_pwm_disable
Date: Wed, 22 Jun 2016 16:36:50 +0200
Message-ID: <20160622143650.GO26943@ulmo.ba.sec>
References: <1464982677-24883-1-git-send-email-slemieux.tyco@gmail.com>
 <20160622123222.GD26943@ulmo.ba.sec>
 <1466601964.5316.19.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3135975727526881330=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466601964.5316.19.camel@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vz@mleia.com
List-Id: linux-pwm@vger.kernel.org


--===============3135975727526881330==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gqEssfNGWsEa4HfM"
Content-Disposition: inline


--gqEssfNGWsEa4HfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2016 at 09:26:04AM -0400, Sylvain Lemieux wrote:
> Hi Thierry,
>=20
> On Wed, 2016-06-22 at 14:32 +0200, Thierry Reding wrote:
> > On Fri, Jun 03, 2016 at 03:37:57PM -0400, Sylvain Lemieux wrote:
> > > From: Sylvain Lemieux <slemieux@tycoint.com>
> > >=20
> > > If the PWM_PIN_LEVEL bit is setup to 1 in the bootloader, when the ke=
rnel
> > > disable the PWM, the PWM output is always set as a logic 1.
> >=20
> > I presume there's a reason why the bootloader set this bit to 1. Why do
> > you assume it's the right thing to clear it?
> >=20
> There is an alternative mode for the PWM output pin; using the=20
> PWM_PIN_LEVEL bit to control the PWM output (logical 0 or 1 on=20
> output) when the PWM is disable.
>=20
> In this case, the bootloader is using the PWM_PIN_LEVEL bit
> to control the PWM output (always 1) to enable the LCD; the=20
> application is using the PWM to control the intensity of the=20
> LCD output. When disabling the PWM, the line level should be=20
> setup to 0.

But doesn't that mean that if the pin is used in PWM mode there's never
a use-case for having it go high when disabled? Given that this is a PWM
driver I don't see how we'd ever be in the case where the alternate
setting makes sense.

> A version 2 of this patch will be send with support to select=20
> the alternate PWM disable level high from the device tree.
>=20
> For details, you can refer to:
> http://thread.gmane.org/gmane.linux.pwm/3882/focus=3D508758

Given the above I don't think we should add this new device tree
property until we encounter a setup where it's needed.

Thierry

--gqEssfNGWsEa4HfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXaqKCAAoJEN0jrNd/PrOhXREP/0Ozq9AVXDV5QU1ltLIg8q8H
+57mUo6Xivu4ALehzFUZY8y54viBBQYSmNGVfnNbl3oj3o4dFBGuV40pSzf/dDfr
KIDZ+kwrb9rNkjErFuXiisCItUVaxtjl+ZsxZJ7ScHG2MTmf2mPHHkax9D12RBqn
7CtryK16r5Fv9t+mFEg2d7We83vTMzmR5AKJki0QMRB+NGukzTn3c1+wlKcegz28
c/Ra54glqrinjCBWS2rzABX1KbSG3CRExc9FhSzBx1EQYcOumZEmFPSVcVt6Dfq/
AxhUIpJ2H0MnLDs5Ts+cmMrVqiLqmBseYcm9X4nxvk9QEIEJagcjojhE9k1rsA+/
w+vuBZjDoOlk+ZH0Q1fpq/aGLtdUmP3A71nus+lUKJttw3wA6Y1jSudryEQvE97K
TJ5+TUHcO8qfQYF+I/PjgNHh6ACSzAs77yLtlJQtaUa0H6i1oF5nlidC5xPazACs
Za14Ho5t1yw+/XOLpmplNIDoTaI/LA1iL2Wu1vnOExfOfHQgkiDqtAa0nDjtKmXx
oiDymU9b2QMl03aZjQAH83sMlyf1o8dt1EeKlRloxrgvxUZoeko5+d2uocerRZnM
jxUlrwNsVE901NNo+ntFH4PamenT4FURdXyY0HPgXDyi+QEaySPbhwRSuBubv9Hy
KmyU7k3RJMewNEiws2Vs
=zBmA
-----END PGP SIGNATURE-----

--gqEssfNGWsEa4HfM--


--===============3135975727526881330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3135975727526881330==--
